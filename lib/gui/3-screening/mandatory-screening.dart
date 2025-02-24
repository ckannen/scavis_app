import 'package:flutter/material.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/components/questionnaires/inanspruchnahme.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/components/questionnaires/act-questionnaire.dart';
import 'package:scavis/components/questionnaires/audit-questionnaire.dart';
import 'package:scavis/components/questionnaires/burnout-questionnaire.dart';
import 'package:scavis/components/questionnaires/cius-questionnaire.dart';
import 'package:scavis/components/questionnaires/games-questionnaire.dart';
import 'package:scavis/components/questionnaires/gesundheit-questionnaire.dart';
import 'package:scavis/components/questionnaires/homeoffice-1-questionnaire.dart';
import 'package:scavis/components/questionnaires/internet-questionnaire.dart';
import 'package:scavis/components/questionnaires/mhi5-questionnaire.dart';
import 'package:scavis/components/questionnaires/pss4-questionnaire.dart';
import 'package:scavis/components/questionnaires/smarb-questionnaire.dart';
import 'package:scavis/components/questionnaires/sofalizing-questionnaire.dart';
import 'package:scavis/components/questionnaires/sozio-1-questionnaire.dart';
import 'package:scavis/components/questionnaires/sozio-2-questionnaire.dart';
import 'package:scavis/components/questionnaires/swls-questionnaire.dart';
import 'package:scavis/components/questionnaires/zeitgeber-questionnaire.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/template/survey-content-template.dart';
import 'package:scavis/survey/survey.dart';
import 'package:scavis/gui/3-screening/optional-screening.dart';
import 'package:scavis/theme/my-theme.dart';

class MandatoryScreeningSetScreen extends SurveyScreen {
  static const String ROUTE = '/mandatory-screening/';

  MandatoryScreeningSetScreen();

  @override
  _MandatoryScreeningSetScreenState createState() => _MandatoryScreeningSetScreenState();
}

class _MandatoryScreeningSetScreenState extends SurveyScreenState<MandatoryScreeningSetScreen> {
  @override
  String surveyId = "mandatory-screening";

  @override
  List<SurveyContentTemplate> questionnaires = [
    Sozio1Questionnaire(),
    InternetQuestionnaire(),
    ActQuestionnaire(),
    CiusQuestionnaire(),
    GamesQuestionnaire(),
    SofalizingQuestionnaire(),
    SwlsQuestionnaire(),
    Mhi5Questionnaire(),
    Pss4Questionnaire(),
    BurnoutQuestionnaire(),
    SmarbQuestionnaire(),
    ZeitgeberQuestionnaire(),
    GesundheitQuestionnaire(),
    AuditQuestionnaire(),
    HomeOffice1Questionnaire(),
    Sozio2Questionnaire(),
    InanspruchnahmeQuestionnaire(),
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
        "Herzlich Willkommen zum smart@net-Screening!",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Das Screening ist der erste Teil dieser Studie. Das Ausfüllen dauert durchschnittlich 20 Minuten.\nEs gibt dabei keine richtigen oder falschen Antworten. Beantworten Sie alle Fragen so, wie es für Sie am zutreffendsten ist. Füllen Sie möglichst alle Fragen in einem Durchgang aus.\n\nNach dem Screening erhalten Sie entweder Zugang zu unserem Präventionsmodul oder werden eingeladen, an der weiteren SCAVIS-Studie teilzunehmen und mehr über Ihre individuelle Smartphonenutzung zu lernen.\nSämtliche Angaben sind selbstverständlich anonym.",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Bitte beachten Sie, dass Sie während der Beantwortung der Fragen nicht zurückblättern können. Bitte verwenden Sie auch nicht die „Zurück-Taste“ Ihres Smartphones.",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16, fontWeight: FontWeight.bold),
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
            appStateManager.appState[AppStateNames.MANDATORY_SCREENING_STATE] = StateValues.STARTED;
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
        "Sie haben das Screening vollständig ausgefüllt. Wenn Sie möchten, können Sie noch ein paar zusätzliche Fragen beantworten (Dauer ca. 5 Minuten). Wenn Sie diese beantworten, erhalten Sie weiteres individuelles Feedback von uns.\n\nSie können jetzt entweder direkt zu Ihrem Feedback wechseln und Ihre persönliche Auswertung ansehen oder erst noch das optionale Zusatz-Screening ausfüllen.",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(
        ElevatedButton(
          child: Text("Zum optionalen Screening"),
          style: ElevatedButton.styleFrom(
            primary: MyTheme.col2,
            onPrimary: MyTheme.col2Text,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, OptionalScreeningSetScreen.ROUTE);
          },
        ),
      );
      children.add(Container(height: 20));
      children.add(
        ElevatedButton(
          child: Text("Zum Feedback"),
          style: ElevatedButton.styleFrom(
            primary: MyTheme.col2,
            onPrimary: MyTheme.col2Text,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE, arguments: {"tab": "feedback", "feedback": "mandatory-screening"});
          },
        ),
      );
    }

    return children;
  }

  @override
  finishSurvey() async {
    await super.finishSurvey();

    // update the app state, store that mandatory screening is finished
    AppStateManager appStateManager = AppStateManager();
    appStateManager.appState[AppStateNames.MANDATORY_SCREENING_STATE] = StateValues.FINISHED;
    await appStateManager.storeAppState();

    // logic for question "soz_ende":
    // go to the optional screening instead of showing the finish modal, if the user chose that option
    this.questionnaires.forEach((SurveyContentTemplate element) {
      if (element is QuestionnaireTemplate) {
        QuestionnaireTemplate questionnaire = element;
        questionnaire.answers.forEach((QuestionnaireAnswer answer) {
          if (answer.questionId == "soz_ende") {
            if (answer != null && answer.answerValues != null && answer.answerValues["value"] == 1) {
              Navigator.pushReplacementNamed(context, OptionalScreeningSetScreen.ROUTE);
            }
          }
        });
      }
    });
  }
}
