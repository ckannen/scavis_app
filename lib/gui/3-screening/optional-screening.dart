import 'package:flutter/material.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/survey/components/template/survey-content-template.dart';
import 'package:scavis/survey/survey.dart';
import 'package:scavis/components/questionnaires/fomo-questionnaire.dart';
import 'package:scavis/components/questionnaires/homeoffice-2-questionnaire.dart';
import 'package:scavis/components/questionnaires/ipip-questionnaire.dart';
import 'package:scavis/theme/my-theme.dart';

class OptionalScreeningSetScreen extends SurveyScreen {
  static const String ROUTE = '/optional-screening/';
  
  OptionalScreeningSetScreen();

  @override
  _OptionalScreeningSetScreenState createState() => _OptionalScreeningSetScreenState();
}

class _OptionalScreeningSetScreenState extends SurveyScreenState<OptionalScreeningSetScreen> {
  @override
  String surveyId = "optional-screening";

  @override
  List<SurveyContentTemplate> questionnaires = [
    HomeOffice2Questionnaire(),
    IpipQuestionnaire(),
    FomoQuestionnaire(),
  ];

  @override
  Widget build(BuildContext context) {
    // set the day to 0
    day = 0;

    // build the survey
    return super.build(context);
  }

  @override
  createModalContent(ModalType type) {
    List<Widget> children = [];

    // Start screening modal
    if (type == ModalType.WELCOME) {
      children.add(Text(
        "Willkommen zum optionalen Zusatz-Screening!",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Schön, dass Sie auch das optionale Screening ausfüllen wollen.\n" +
            "Das Ausfüllen des optionalen Screenings dauert im Schnitt 5 Minuten.\n" +
            "Bitte arbeiten Sie konzentriert und füllen Sie möglichst alle Fragen in einem Durchgang aus.\n\n" +
            "Bitte beachten Sie, dass Sie während der Beantwortung der Fragen nicht zurückblättern können. Bitte verwenden Sie auch nicht die \"Zurück-Taste\" Ihres Smartphones.",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(
        ElevatedButton(
          child: Text("Jetzt starten"),
          style: ElevatedButton.styleFrom(
            primary: MyTheme.col2,
            onPrimary: MyTheme.col2Text,
          ),
          onPressed: () {
            // store in the app state, that the screening has started
            AppStateManager appStateManager = AppStateManager();
            appStateManager.appState[AppStateNames.OPTIONAL_SCREENING_STATE] = StateValues.STARTED;
            appStateManager.storeAppState();
            
            // hide the modal
            setState(
              () {
                modalVisible = false;
              },
            );
          },
        ),
      );
    }

    // Continue screening modal
    if (type == ModalType.CONITNUE) {
      children.add(Text(
        "Screening fortsetzen",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Sie haben das Screening unterbrochen. Klicken Sie auf 'Weitermachen', um es fortzusetzen.",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(
        ElevatedButton(
          child: Text("Weitermachen"),
          style: ElevatedButton.styleFrom(
            primary: MyTheme.col2,
            onPrimary: MyTheme.col2Text,
          ),
          onPressed: () {
            setState(() {
              modalVisible = false;
            });
          },
        ),
      );
    }

    // Finished screening modal
    if (type == ModalType.FINISH) {
      children.add(Text(
        "Super!",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Sie haben auch das optionale Screening vollständig ausgefüllt.\nNun haben Sie das komplette Feedback freigeschaltet.\n",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(
        ElevatedButton(
          child: Text("Zum Feedback"),
          style: ElevatedButton.styleFrom(
            primary: MyTheme.col2,
            onPrimary: MyTheme.col2Text,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE, arguments: {"tab": "feedback", "feedback": "optional-screening"});
          },
        ),
      );
    }

    return children;
  }

  @override
  finishSurvey() async {
    await super.finishSurvey();

    // update the app state, store that optional screening is finished
    AppStateManager appStateManager = AppStateManager();
    appStateManager.appState[AppStateNames.OPTIONAL_SCREENING_STATE] = StateValues.FINISHED;
    await appStateManager.storeAppState();
  }
}
