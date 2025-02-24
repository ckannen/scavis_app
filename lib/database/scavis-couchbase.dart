import 'dart:convert';
import 'dart:io';

import 'package:couchbase_lite/couchbase_lite.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CouchbaseUser {
  final String syncGatewayUsername;
  final String syncGatewayPassword;
  final String participantId;
  final String participantCode;

  CouchbaseUser({this.syncGatewayUsername, this.syncGatewayPassword, this.participantId, this.participantCode});

  String toString() {
    return "{syncGatewayUsername: $syncGatewayUsername, syncGatewayPassword: $syncGatewayPassword, participantId: $participantId, participantCode: $participantCode}";
  }
}

enum RemoteLoginStatus {
  SIGNED_UP,
  LOGGED_IN,
  INTERNET_CONNECTION_ERROR,
  ERROR,
}

class CouchbaseDocTypes {
  static const PARTICIPANT = "participant";
  static const APP_STATE = "app-state";
  static const PARTICIPANT_SCHEDULE = "participant-schedule";
  static const QUESTIONNAIRE_ANSWER = "questionnaire-answer";
  static const ACTION_FLOW_ANSWERS = "action-flow-answers";
  static const QUESTIONNAIRE_STATE = "questionnaire-state";
  static const SURVEY_STATE = "survey-state";
}

class ScavisCouchbase {
  // Singleton
  static final ScavisCouchbase _instance = ScavisCouchbase._internal();
  factory ScavisCouchbase() => _instance;
  ScavisCouchbase._internal();
  // End: Singleton

  static const int DOC_VERSION = 1;

  // local database settings
  static const String LOCAL_DB_NAME = "scavis";

  // server settings
  static const String SIGN_UP_HTTP_PROTOCOL = "https";
  static const String SIGN_UP_DOMAIN = "app.scavis.net";
  static const SIGN_UP_URL = "$SIGN_UP_HTTP_PROTOCOL://$SIGN_UP_DOMAIN/app-api/sign-up.php";

  static const String SYNC_GATEWAY_DOMAIN = "db.scavis.net";
  static const String SYNC_GATEWAY_PORT = "4984";
  static const String SYNC_GATEWAY_DB = "scavis";
  static const REMOTE_DB_URL = "ws://$SYNC_GATEWAY_DOMAIN:$SYNC_GATEWAY_PORT/$SYNC_GATEWAY_DB";

  // temp, nach debuggen wieder löschen, db password: 'password' => 'fgdashj',

  // server connection
  CouchbaseUser couchbaseUser;

  Database database;
  Replicator replicator;
  List<dynamic> dbEntries = [];

  static bool _isInitialied = false;

  initDatabase() async {
    if (!_isInitialied) {
      _isInitialied = true;
    }
  }

  // ####################################################################################################
  // Couchbase Local Database
  // ####################################################################################################

  // Initialize the local couchbase lite database
  Future<bool> initLocalDb() async {
    // if the database is already initialized, stop here
    if (_isInitialied) {
      return true;
    }

    // init the local database
    try {
      database = await Database.initWithName(LOCAL_DB_NAME);
    } on Exception catch (e) {
      print("$runtimeType.initLocalDb: $e");
    }

    // check if there are already credentials for the remote server stored
    // this means, that the user is already signed up
    // if so, load the data, but do not connect to the remote server yet
    await loadParticipantDataAndSyncGatewayCredentials();
    return true;
  }

  bool isSignedup() {
    return couchbaseUser != null;
  }

  // load the participant id and code and the username and password for Sync Gateway
  // all together is stored in one database entry that is synced to the local database after the signing up the server and the first connection to the remote database
  Future<bool> loadParticipantDataAndSyncGatewayCredentials() async {
    // Create a query to fetch documents of type SDK.
    var query = QueryBuilder.select([SelectResult.all().from("doc")]).from(LOCAL_DB_NAME, as: "doc").where(Expression.property("docType").from("doc").equalTo(Expression.string("participant")));

    // Run the query.
    try {
      var resultSet = await query.execute();
      if (resultSet.allResults().length > 0) {
        Result result = resultSet.allResults().first;
        couchbaseUser = CouchbaseUser(
          syncGatewayUsername: result["doc"]["syncGatewayUsername"].getString(),
          syncGatewayPassword: result["doc"]["syncGatewayPassword"].getString(),
          participantId: result["doc"]["participantId"].getString(),
          participantCode: result["doc"]["participantCode"].getString(),
        );
        return true;
      }
    } on Exception catch (e) {
      print("$runtimeType.initLocalDb: $e");
    }
    return false;
  }

  // delete local couchbase lite database and all saved data
  // reset the connection information for the remote database
  deleteLocalDb() async {
    // if the datbase is not opened, open it
    if (database == null) {
      await initLocalDb();
    }
    // if the replicator is running, stop it
    if (replicator != null) {
      await replicator.stop();
      await replicator.dispose();
    }
    // delete the database and reset the remote data
    database.delete();
    couchbaseUser = null;
  }

  // ####################################################################################################
  // Listener
  // ####################################################################################################
  // add a listener to the database
  ListenerToken addListener(Function(DatabaseChange) callback) {
    // stop if the local database has not been initialized yet
    if (database == null) {
      return null;
    }

    // add listener and return the listener token
    // the listener token is used to remove the listener again
    ListenerToken token = database.addChangeListener(callback);
    return token;
  }

  // remove a listener from the database
  Future<ListenerToken> removeListener(ListenerToken token) async {
    // stop if the local database has not been initialized yet
    if (database == null) {
      return null;
    }

    // stop if no token was defined
    if (token == null) {
      return null;
    }

    // remove the listener with the specified token
    ListenerToken newToken = await database.removeChangeListener(token);
    return newToken;
  }

  // ####################################################################################################
  // Couchbase Server Remote
  // ####################################################################################################

  // init
  Future<RemoteLoginStatus> initRemoteDb() async {
    // stop if the local database has not been initialized yet
    if (database == null) {
      return RemoteLoginStatus.ERROR;
    }

    // check whether the device is connected to the internet
    bool internetConnected = await isConnectedToInternet();
    if (!internetConnected) {
      return RemoteLoginStatus.INTERNET_CONNECTION_ERROR;
    }

    // check if there is already a Sync Gateway user
    // if there is such an user, the data was loaded when the local database was initialized and stored in the variable couchbaseUser
    // if there is no such user, sign up to the server now
    bool userExists = false;
    bool signedUp = false;
    if (couchbaseUser == null) {
      userExists = await signUpOnServer();
      signedUp = userExists;
    } else {
      userExists = true;
    }
    if (userExists) {
      bool connectedToServer = await connectWithRemoteDb();
      if (connectedToServer) {
        if (signedUp) return RemoteLoginStatus.SIGNED_UP;
        else return RemoteLoginStatus.LOGGED_IN;
      }
    }

    return RemoteLoginStatus.ERROR;
  }

  // check whether the device is connected to the internet
  Future<bool> isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  // create a new user (participant)
  // sign up a new participant on the server
  // receive the Sync Gateway credentials
  // and then connect to the server with Sync Gateway, so that the credentials are synced down to the local database
  Future<bool> signUpOnServer() async {
    try {
      Response response = await Dio().get(SIGN_UP_URL);
      dynamic jsonRespnse = jsonDecode(response.data);
      if (jsonRespnse["status"] == "ok") {
        couchbaseUser = CouchbaseUser(
          syncGatewayUsername: jsonRespnse["participant"]["syncGatewayUsername"],
          syncGatewayPassword: jsonRespnse["participant"]["syncGatewayPassword"],
          participantId: jsonRespnse["participant"]["participantId"],
          participantCode: jsonRespnse["participant"]["participantCode"],
        );
        return true;
      }
    } on Exception catch (e) {
      print("$runtimeType.createNewUser: $e");
    }
    return false;
  }

  // connect the local database with the server database
  // all entries from the server are then synced down to the client
  // and all entries from the client are synced up the the server
  Future<bool> connectWithRemoteDb() async {
    // server settings
    ReplicatorConfiguration config = ReplicatorConfiguration(database, REMOTE_DB_URL);
    config.replicatorType = ReplicatorType.pushAndPull;
    config.continuous = true;

    // authentication
    config.authenticator = BasicAuthenticator(couchbaseUser.syncGatewayUsername, couchbaseUser.syncGatewayPassword);

    // create replicator and replicate data
    replicator = Replicator(config);
    await replicator.start();
    return true;
  }

  // ####################################################################################################
  // Couchbase Lite database I/O
  // ####################################################################################################
  Future<bool> createDbEntry(String docType, dynamic data) async {
    String channel;
    if (database == null) {
      return false;
    }
    channel = couchbaseUser.participantId;
    var document = MutableDocument();
    document.setValue("docType", docType);
    document.setValue("docVersion", DOC_VERSION);
    document.setValue("participantId", couchbaseUser.participantId);
    document.setValue("data", data);
    document.setValue("channels", [channel]);
    document.setValue("creationDt", DateTime.now().toIso8601String());

    // Save it to the database.
    try {
      bool docCreated = await database.saveDocument(document);
      return docCreated;
    } on Exception catch (e) {
      print("$runtimeType.createDbEntry: $e");
      return false;
    }
  }

  queryAllDbEntries() async {
    // Create a query to fetch documents of type SDK.
    var query = QueryBuilder.select([SelectResult.all().from("doc")]).from(LOCAL_DB_NAME, as: "doc");

    // Run the query.
    try {
      var result = await query.execute();
      List<dynamic> dbEntries = [];
      for (int i = 0; i < result.allResults().length; i++) {
        dbEntries.add(result.allResults().elementAt(i)["doc"]);
      }
      this.dbEntries = dbEntries;
    } on Exception catch (e) {
      print("$runtimeType.queryAllDbEntries: $e");
    }
  }

  // store a document in the database, channels and all settings around the data are set automatically by this function
  // this will create a new document or update an exisiting document with this id
  // by default, this function uses the participant id as prefix for the document id, so that it can be synced to the server without any conflict to documents of other participants
  Future<bool> storeDocWithId({@required String id, @required String docType, @required dynamic data, bool useParticipantIdAsPrefix = true}) async {
    // set the document id
    // use the participant id as prefix by default
    String docId = id;
    if (useParticipantIdAsPrefix) {
      docId = couchbaseUser.participantId + "-" + id;
    }

    // set the channels for the document
    List<String> channels = [couchbaseUser.participantId];

    // create a document object with all data
    var document = MutableDocument(id: docId);
    document.setValue("docType", docType);
    document.setValue("docVersion", DOC_VERSION);
    document.setValue("participantId", couchbaseUser.participantId);
    document.setValue("data", data);
    document.setValue("channels", channels);
    document.setValue("creationDt", DateTime.now().toIso8601String());

    // save it to the database.
    try {
      bool docCreated = await database.saveDocument(document);
      return docCreated;
    } on Exception catch (e) {
      print("$runtimeType.storeDocWithId ($docId): $e");
      return false;
    }
  }

  // get the data part of a document from the database
  // by default, this function uses the participant id as prefix for the document id, so that it can be synced to the server without any conflict to documents of other participants
  Future<dynamic> getDocWithId({@required String id, dynamic defaultValue, bool useParticipantIdAsPrefix = true}) async {
    if (couchbaseUser == null) {
      return defaultValue;
    }

    // set the document id
    // use the participant id as prefix by default
    String docId = id;
    if (useParticipantIdAsPrefix) {
      docId = couchbaseUser.participantId + "-" + id;
    }

    Document document = await database.document(docId);
    if (document == null) {
      return defaultValue;
    } else {
      return document.getValue("data");
    }
  }

  // ####################################################################################################
  // Couchbase Lite database I/O functions for special use cases
  // ####################################################################################################
  // store document with app state
  Future<bool> storeAppState({dynamic appState}) async {
    return await storeDocWithId(id: CouchbaseDocTypes.APP_STATE, docType: CouchbaseDocTypes.APP_STATE, data: appState);
  }

  // get document with app state
  Future<dynamic> loadAppState() async {
    return await getDocWithId(id: CouchbaseDocTypes.APP_STATE);
  }

  // store document with participant schedule
  Future<bool> storeParticipantSchedule({dynamic participantSchedule}) async {
    return await storeDocWithId(id: CouchbaseDocTypes.PARTICIPANT_SCHEDULE, docType: CouchbaseDocTypes.PARTICIPANT_SCHEDULE, data: participantSchedule);
  }

  // get document with participant schedule
  Future<dynamic> loadParticipantSchedule() async {
    return await getDocWithId(id: CouchbaseDocTypes.PARTICIPANT_SCHEDULE);
  }

  // store document with state of questionnaire
  Future<bool> storeQuestionnaireState({@required String surveyId, @required int day, @required String questionnaireId, @required int itemIndex, @required bool complete}) async {
    String docId = "${CouchbaseDocTypes.QUESTIONNAIRE_STATE}-$surveyId-$questionnaireId";
    return await storeDocWithId(id: docId, docType: CouchbaseDocTypes.QUESTIONNAIRE_STATE, data: {
      "surveyId": surveyId,
      "day": day,
      "questionnaireId": questionnaireId,
      "itemIndex": itemIndex,
      "complete": complete,
    });
  }

  // get document with state of questionnaire
  Future<dynamic> loadQuestionnaireState({@required String surveyId, @required String questionnaireId}) async {
    String docId = "${CouchbaseDocTypes.QUESTIONNAIRE_STATE}-$surveyId-$questionnaireId";
    return await getDocWithId(id: docId, defaultValue: {
      "surveyId": surveyId,
      "questionnaireId": questionnaireId,
      "itemIndex": 0,
      "complete": false,
    });
  }

  // store document with state of questionnaire set
  Future<bool> storeSurveyState({@required String surveyId, @required int day, @required int pageIndex, @required int itemIndex, @required bool complete}) async {
    String docId = "${CouchbaseDocTypes.SURVEY_STATE}-$surveyId";
    return await storeDocWithId(id: docId, docType: CouchbaseDocTypes.SURVEY_STATE, data: {
      "surveyId": surveyId,
      "day": day,
      "pageIndex": pageIndex,
      "itemIndex": itemIndex,
      "complete": complete,
    });
  }

  // get document with state of questionnaire set
  Future<dynamic> loadSurveyState({@required String surveyId}) async {
    String docId = "${CouchbaseDocTypes.SURVEY_STATE}-$surveyId";
    return await getDocWithId(id: docId, defaultValue: {
      "surveyId": surveyId,
      "pageIndex": 0,
      "itemIndex": 0,
      "complete": false,
    });
  }

  // store document with answer to questionnaire question
  Future<bool> storeQuestionnaireAnswer({@required String surveyId, @required int day, @required int pageIndex, @required int itemIndex, @required dynamic answer}) async {
    String docId = "${CouchbaseDocTypes.QUESTIONNAIRE_ANSWER}-$surveyId-$pageIndex-$itemIndex";
    return await storeDocWithId(id: docId, docType: CouchbaseDocTypes.QUESTIONNAIRE_ANSWER, data: {
      "surveyId": surveyId,
      "day": day,
      "pageIndex": pageIndex,
      "itemIndex": itemIndex,
      "answer": answer,
    });
  }

  // get all documents with questionnaire answers
  Future<List<Fragment>> loadAllQuestionnaireAnswersForSurvey({@required String surveyId}) async {
    // Create a query to fetch documents of type SDK.
    var query = QueryBuilder.select([SelectResult.all().from("doc")]).from(LOCAL_DB_NAME, as: "doc")
    .where(Expression.property("doc.docType").equalTo(Expression.string(CouchbaseDocTypes.QUESTIONNAIRE_ANSWER))
    .and(Expression.property("doc.data.surveyId").equalTo(Expression.string(surveyId))));

    // Run the query.
    List<Fragment> answers = [];
    try {
      ResultSet resultSet = await query.execute();
      List<Result> results = resultSet.allResults();
      for (int i = 0; i < results.length; i++) {
        answers.add(results.elementAt(i)["doc"]);
      }
    } on Exception catch (e) {
      print("$runtimeType.loadAllQuestionnaireAnswersForSurvey: $e");
    }
    return answers;
  }

  // get the computed results of this participant for all questionnaire
  Future<Map> loadQuestionnaireResults() async {
    Map questionnaireResults = {};

    // query the documents with the questionnaire set id
    var query = QueryBuilder.select([SelectResult.all().from("doc")]).from(LOCAL_DB_NAME, as: "doc").where(Expression.property("doc.docType").equalTo(Expression.string("questionnaire-results")));
    try {
      ResultSet resultSet = await query.execute();
      List<Result> results = resultSet.allResults();
      for (int i = 0; i < results.length; i++) {
        String questionnaireId = results.elementAt(i)["doc"].getMap()["questionnaireId"];
        questionnaireResults[questionnaireId] = results.elementAt(i)["doc"].getMap()["data"];
      }
    } on Exception catch (e) {
      print("$runtimeType.loadQuestionnaireResults: $e");
    }
    return questionnaireResults;
  }

  // get the aggregated results of all participants for all questionnaires
  Future<Map> loadAggregatedResults() async {
    Map aggregatedResults;

    // query the document with the aggregated results
    var query = QueryBuilder.select([SelectResult.all().from("doc")]).from(LOCAL_DB_NAME, as: "doc").where(Expression.property("doc.docType").equalTo(Expression.string("aggregated-results")));
    try {
      ResultSet resultSet = await query.execute();
      List<Result> results = resultSet.allResults();
      if (results.length > 0) {
        aggregatedResults = results.first["doc"].getMap()["data"];
      }
    } on Exception catch (e) {
      print("$runtimeType.loadAggregatedResults: $e");
    }
    return aggregatedResults;
  }



  // store document with answer to questionnaire question
  Future<bool> storeActionFlowAnswers({@required String surveyId, @required int day, @required int pageIndex, @required dynamic answers}) async {
    String docId = "${CouchbaseDocTypes.ACTION_FLOW_ANSWERS}-$surveyId-$pageIndex";
    return await storeDocWithId(id: docId, docType: CouchbaseDocTypes.ACTION_FLOW_ANSWERS, data: {
      "surveyId": surveyId,
      "day": day,
      "pageIndex": pageIndex,
      "answers": answers,
    });
  }

  // get all documents with questionnaire answers
  Future<List<Fragment>> loadAllActionFlowAnswersForSurvey({@required String surveyId}) async {
    // Create a query to fetch documents of type SDK.
    var query = QueryBuilder.select([SelectResult.all().from("doc")]).from(LOCAL_DB_NAME, as: "doc")
    .where(Expression.property("doc.docType").equalTo(Expression.string(CouchbaseDocTypes.ACTION_FLOW_ANSWERS))
    .and(Expression.property("doc.data.surveyId").equalTo(Expression.string(surveyId))));

    // Run the query.
    List<Fragment> list = [];
    try {
      ResultSet resultSet = await query.execute();
      List<Result> results = resultSet.allResults();
      for (int i = 0; i < results.length; i++) {
        list.add(results.elementAt(i)["doc"]);
      }
    } on Exception catch (e) {
      print("$runtimeType.loadAllActionFlowAnswersForSurvey: $e");
    }
    return list;
  }
}
