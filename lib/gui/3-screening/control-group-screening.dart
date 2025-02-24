import 'package:flutter/material.dart';
import 'package:scavis/components/questionnaires/iues-1-questionnaire.dart';
import 'package:scavis/gui/5-finished-group/control-group.dart';
import 'package:scavis/survey/components/template/survey-content-template.dart';
import 'package:scavis/survey/survey.dart';
import 'package:scavis/components/questionnaires/fomo-single-and-mood-questionnaire.dart';
import 'package:scavis/components/questionnaires/icat-short-28-questionnaire.dart';
import 'package:scavis/components/questionnaires/prism-internet-questionnaire.dart';
import 'package:scavis/components/questionnaires/readiness-self-efficacy-questionnaire.dart';
import 'package:scavis/components/questionnaires/whodas-questionnaire.dart';
import 'package:scavis/theme/my-theme.dart';

class ControlGroupScreeningSetScreen extends SurveyScreen {
  static const String ROUTE = '/control-group-screening/';
  
  ControlGroupScreeningSetScreen();

  @override
  _OptionalScreeningSetScreenState createState() => _OptionalScreeningSetScreenState();
}

class _OptionalScreeningSetScreenState extends SurveyScreenState<ControlGroupScreeningSetScreen> {
  @override
  String surveyId = "control-group-screening";

  @override
  List<SurveyContentTemplate> questionnaires = [
    IcatShort28Questionnaire(),
    WhodasQuestionnaire(),
    PrismInternetQuestionnaire(),
    Iues1Questionnaire(),
    ReadinessSelfEfficacyQuestionnaire(),
    FomoSingleAndMoodQuestionnaire(),
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
        "Willkommen in der Kontrollgruppe! Wir haben noch ein paar Fragen für Sie vorbereitet.",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Klicken Sie auf 'Jetzt starten', um mit den Fragen zu beginnen.",
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
        "Sie haben die Befragung der Kontrollgruppe vollständig ausgefüllt. Dankeschön!",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(
        ElevatedButton(
          child: Text("Weiter"),
          style: ElevatedButton.styleFrom(
            primary: MyTheme.col2,
            onPrimary: MyTheme.col2Text,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, FinishedControlGroupScreen.ROUTE);
          },
        ),
      );
    }

    return children;
  }

  @override
  finishSurvey() async {
    await super.finishSurvey();
  }
}