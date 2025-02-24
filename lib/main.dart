import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scavis/gui/3-screening/control-group-screening.dart';
import 'package:scavis/gui/4-group-assigning/control-group.dart';
import 'package:scavis/gui/4-group-assigning/prevention-group.dart';
import 'package:scavis/gui/4-group-assigning/participant-information.dart';
import 'package:scavis/gui/5-finished-group/control-group.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/gui/other/personal-data.dart';
import 'package:scavis/gui/3-screening/daily-screening.dart';
import 'package:scavis/theme/my-theme.dart';
import 'gui/1-login/login.dart';
import 'gui/1-login/more-info.dart';
import 'gui/1-login/app-consent.dart';
import 'gui/1-login/init-study.dart';
import 'gui/4-group-assigning/intervention.group.dart';
import 'gui/5-finished-group/abort-intervention.group.dart';
import 'gui/intervention/intervention-main.dart';
import 'gui/3-screening/mandatory-screening.dart';
import 'gui/3-screening/optional-screening.dart';
import 'gui/0-setup-screen/setup-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Scavis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // text color
        textTheme: TextTheme(
          bodyText1: TextStyle(color: MyTheme.TEXT_COLOR),
          bodyText2: TextStyle(color: MyTheme.TEXT_COLOR),
          headline1: TextStyle(color: MyTheme.TEXT_COLOR),
          headline2: TextStyle(color: MyTheme.TEXT_COLOR),
          headline3: TextStyle(color: MyTheme.TEXT_COLOR),
          headline4: TextStyle(color: MyTheme.TEXT_COLOR),
          headline5: TextStyle(color: MyTheme.TEXT_COLOR),
          headline6: TextStyle(color: MyTheme.TEXT_COLOR),
          subtitle1: TextStyle(color: MyTheme.TEXT_COLOR),
          subtitle2: TextStyle(color: MyTheme.TEXT_COLOR),
          overline: TextStyle(color: MyTheme.TEXT_COLOR),
          caption: TextStyle(color: MyTheme.TEXT_COLOR),
          button: TextStyle(color: MyTheme.TEXT_COLOR),
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SetupScreen.ROUTE,
      routes: {
        SetupScreen.ROUTE: (context) => SetupScreen(),
        LoginScreen.ROUTE: (context) => LoginScreen(),
        MoreInfoScreen.ROUTE: (context) => MoreInfoScreen(),
        InitStudyScreen.ROUTE: (context) => InitStudyScreen(),

        InterventionMainScreen.ROUTE: (context) => InterventionMainScreen(),
        MainMenuScreen.ROUTE: (context) => MainMenuScreen(),

        // Screening Intro and screening questionnaires
        AppConsentScreen.ROUTE: (context) => AppConsentScreen(),
        MandatoryScreeningSetScreen.ROUTE: (context) => MandatoryScreeningSetScreen(),
        OptionalScreeningSetScreen.ROUTE: (context) => OptionalScreeningSetScreen(),

        // After Screening and Tracking / Group Assigning
        ParticipantInformationScreen.ROUTE: (context) => ParticipantInformationScreen(),
        AssignToInterventionGroupScreen.ROUTE: (context) => AssignToInterventionGroupScreen(),
        AssignToControlGroupScreen.ROUTE: (context) => AssignToControlGroupScreen(),
        AssignToPreventionGroupScreen.ROUTE: (context) => AssignToPreventionGroupScreen(),
        AbortInterventionGroupScreen.ROUTE: (context) => AbortInterventionGroupScreen(),
        FinishedControlGroupScreen.ROUTE: (context) => FinishedControlGroupScreen(),

        // Daily questionnaires in the intervention app
        DailyScreening.ROUTE: (context) => DailyScreening(),
        ControlGroupScreeningSetScreen.ROUTE: (context) => ControlGroupScreeningSetScreen(),

        // Other
        PersonalDataScreen.ROUTE: (context) => PersonalDataScreen(),
      },
    );
  }
}
