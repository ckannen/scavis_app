import 'dart:async';

import 'package:couchbase_lite/couchbase_lite.dart';
import 'package:flutter/material.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/gui/3-screening/mandatory-screening.dart';
import 'package:scavis/theme/my-theme.dart';

import 'device-info.dart';

class InitStudyScreen extends StatefulWidget {
  static const String ROUTE = "/init-study/";

  @override
  _InitStudyScreenState createState() => _InitStudyScreenState();
}

class _InitStudyScreenState extends State<InitStudyScreen> {
  bool internetConnectionMessageVisible = false;
  bool signingUpMessageVisible = false;
  bool pleaseWaitMessageVisible = false;

  dynamic screenInfo = {};

  @override
  void initState() {
    super.initState();
    connectWithRemoteDatabase();
  }

  connectWithRemoteDatabase() async {
    var scavisCouchbase = ScavisCouchbase();

    // check the internet connection
    // if the user is not signed up yet, the app must be connected to the internet to sign up the user
    if (!await scavisCouchbase.isConnectedToInternet()) {
      // show a warning
      setState(() {
        internetConnectionMessageVisible = true;
      });

      // try again in 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        connectWithRemoteDatabase();
      });

      return;
    }

    // hide the warning
    setState(() {
      internetConnectionMessageVisible = false;
      signingUpMessageVisible = true;
    });

    // connect to the server
    // if the user is not signed up yet, it will sign up the user now
    RemoteLoginStatus status = await scavisCouchbase.initRemoteDb();

    // if the user was already signed up and now logged in, the user can continue with the next screen
    if (status == RemoteLoginStatus.LOGGED_IN) {
      Navigator.pushReplacementNamed(context, MandatoryScreeningSetScreen.ROUTE);
      return true;
    }

    // if the user just signed up, wait until the first data with the participant information was synced down from the server
    ListenerToken token;
    token = scavisCouchbase.addListener((DatabaseChange databaseChange) async {
      // check if the data was synced down from the server
      bool signedUp = false;

      databaseChange.documentIDs.forEach((id) {
        if (id.startsWith("participant-")) {
          signedUp = true;
        }
      });

      if (signedUp) {
        // update the app state
        AppStateManager appStateManager = AppStateManager();
        appStateManager.appState[AppStateNames.STUDY_PART_1_CONSENT] = StateValues.YES;
        appStateManager.appState[AppStateNames.SIGNED_UP_ON_SERVER] = true;
        appStateManager.appState[AppStateNames.INITIAL_SYNC_FINISHED] = true;
        await appStateManager.storeAppState();

        // remove the database listener
        scavisCouchbase.removeListener(token);

        // store device info in database
        storeDeviceInfo();

        // go to the screening
        Navigator.pushReplacementNamed(context, MandatoryScreeningSetScreen.ROUTE);
      }
    });
    return true;
  }

  storeDeviceInfo() async {
    var scavisCouchbase = ScavisCouchbase();
    dynamic devcieInfo = await DeviceInfo.getInfo(screenInfo);
    scavisCouchbase.storeDocWithId(id: "device-info", docType: "device-info", data: devcieInfo);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);

    screenInfo = {
      "width": mqd.size.width,
      "height": mqd.size.height,
      "devicePixelRatio": mqd.devicePixelRatio
    };

    AppBar appBar = MyAppBar.createDefaultAppBar();

    double headerHeight = appBar.preferredSize.height;
    double footerHeight = 200;
    double contentHeight = mqd.size.height - mqd.padding.vertical - headerHeight - footerHeight;

    String textLabel = "Initialisiere";
    if (internetConnectionMessageVisible) {
      textLabel = "Bitte aktivieren Sie eine Internetverbindung";
    }
    if (signingUpMessageVisible) {
      textLabel = "Lade Daten von Server";
    }

    return Scaffold(
      appBar: appBar,
      backgroundColor: MyTheme.BACKGROUND_COLOR,
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: contentHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyTheme.col2)),
                      Container(height: 40),
                      Text(
                        textLabel,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      pleaseWaitMessageVisible ? Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text("Zurzeit befinden sich viele Nutzer auf dem Server.\nBitte warten Sie bis Sie zur Studie angemeldet werden können.")
                      ) : Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
