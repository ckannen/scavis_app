import 'package:flutter/material.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/gui/1-login/init-study.dart';
import 'package:scavis/gui/1-login/login.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/gui/3-screening/mandatory-screening.dart';

class SetupScreen extends StatefulWidget {
  static const String ROUTE = "/setup-screen/";

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  initState() {
    super.initState();
    init();
  }

  init() async {
    await initDb();
    await initAppState();
    gotoCorrectScreen(context);
  }

  // init the couchbase database
  // and if the user is already signed up, also init the connection to the remote database on the server
  // so that the automatic sync starts in the background
  initDb() async {
    var scavisCouchbase = ScavisCouchbase();
    // open the local database
    await scavisCouchbase.initLocalDb();
    // if the user is already signed up, also try to connect with remote database for syncing
    if (scavisCouchbase.isSignedup()) {
      await scavisCouchbase.initRemoteDb();
    }
  }

  // init the app state manager and load the current app state
  // this contains the progress of the app and study
  // and decides which screen is loaded next
  initAppState() async {
    var appStateManager = AppStateManager();
    await appStateManager.loadAppState();
  }

  gotoCorrectScreen(BuildContext context) async {
    var appStateManager = AppStateManager();

    // if the user did not give consent, go to the login screen
    if (appStateManager.appState[AppStateNames.STUDY_PART_1_CONSENT] != StateValues.YES) {
      Navigator.pushReplacementNamed(context, LoginScreen.ROUTE);
      return;
    }

    // if the user gave consent, but the app was not yet connected to the server for sign up, go to the init study screen
    if (!appStateManager.appState[AppStateNames.SIGNED_UP_ON_SERVER]) {
      Navigator.pushReplacementNamed(context, InitStudyScreen.ROUTE);
      return;
    }

    // if the mandatory screening is not finished yet, go to the screening
    if (appStateManager.appState[AppStateNames.MANDATORY_SCREENING_STATE] != StateValues.FINISHED) {
      Navigator.pushReplacementNamed(context, MandatoryScreeningSetScreen.ROUTE);
      return;
    }

    // otherwise go to the main menu
    Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(""),
        alignment: Alignment.center,
      ),
    );
  }
}
