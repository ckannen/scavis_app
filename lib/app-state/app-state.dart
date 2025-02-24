import 'package:scavis/database/scavis-couchbase.dart';

class AssignedGroupValues {
  static const String NONE = "none";
  static const String PREVENTION = "prevention";
  static const String INTERVENTION = "intervention";
  static const String CONTROL = "control";
}


class StateValues {
  static const String PENDING = "pending";
  static const String STARTED = "started";
  static const String FINISHED = "finished";
  static const String YES = "yes";
  static const String NO = "no";
}

class AppStateNames {
  // login and consent
  static const String STUDY_PART_1_CONSENT = "studyPart1Consent";
  static const String SIGNED_UP_ON_SERVER = "signedUpOnServer";
  static const String INITIAL_SYNC_FINISHED = "initialSyncFinished";

  // screening
  static const String MANDATORY_SCREENING_STATE = "mandatoryScreeningState";
  static const String OPTIONAL_SCREENING_STATE = "optionalScreeningState";
  static const String FEEDBACK_OPENED = "feedbackOpened";

  // group, group assigning and consent
  static const String STUDY_PART_2_CONSENT = "studyPart2Consent";
  static const String TRACKING_CONSENT = "trackingConsent";
  static const String RAFFLE_EMAIL_ENTERED = "raffleEmailEntered";
  static const String CONTACT_DATA_ENTERED = "contactDataEntered";
  static const String STUDY_PART_2_START_DATETIME = "studyPart2StartDateTime";
}

class AppStateManager {
  // Singleton
  static final AppStateManager _instance = AppStateManager._internal();
  factory AppStateManager() => _instance;
  AppStateManager._internal();
  // End: Singleton

  dynamic appState = {
    // login and consent
    AppStateNames.STUDY_PART_1_CONSENT: StateValues.PENDING,
    AppStateNames.SIGNED_UP_ON_SERVER: false,
    AppStateNames.INITIAL_SYNC_FINISHED: false,

    // screening
    AppStateNames.MANDATORY_SCREENING_STATE: StateValues.PENDING,
    AppStateNames.OPTIONAL_SCREENING_STATE: StateValues.PENDING,
    AppStateNames.FEEDBACK_OPENED : false,

    // group, group assigning and consent
    AppStateNames.STUDY_PART_2_CONSENT: StateValues.PENDING,
    AppStateNames.TRACKING_CONSENT: StateValues.PENDING,
    AppStateNames.RAFFLE_EMAIL_ENTERED: false,
    AppStateNames.CONTACT_DATA_ENTERED: false,
    AppStateNames.STUDY_PART_2_START_DATETIME: "",
  };

  dynamic participantSchedule;

  // load app state from database, if it was saved before
  loadAppState() async {
    ScavisCouchbase database = ScavisCouchbase();
    await database.initLocalDb();
    dynamic appState = await database.loadAppState();
    if (appState != null) {
      this.appState = appState;
    }
  }

  // store app state
  Future<void> storeAppState() async {
    ScavisCouchbase database = ScavisCouchbase();
    await database.initLocalDb();
    await database.storeAppState(appState: appState);
  }

  // load participant schedule from database
  loadParticipantSchedule() async {
    ScavisCouchbase database = ScavisCouchbase();
    await database.initLocalDb();
    dynamic participantSchedule = await database.loadParticipantSchedule();
    if (participantSchedule != null) {
      this.participantSchedule = participantSchedule;
    }
  }

  // store participant schedule
  Future<void> storeParticipantSchedule() async {
    ScavisCouchbase database = ScavisCouchbase();
    await database.initLocalDb();
    await database.storeParticipantSchedule(participantSchedule: participantSchedule);
  }
}
