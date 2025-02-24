import 'package:couchbase_lite/couchbase_lite.dart';
import 'package:flutter/material.dart';
import 'package:scavis/components/questionnaires/decisional-balance-questionnaire.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-8-decisional-balance.dart';
import 'package:scavis/survey/components/template/survey-content-template.dart';
import 'package:scavis/survey/survey.dart';
import 'package:scavis/theme/my-theme.dart';

import 'daily-screening-settings.dart';

class DailyScreening extends SurveyScreen {
  static const String ROUTE = '/daily-screening/';

  DailyScreening();

  @override
  _DailyScreeningState createState() => _DailyScreeningState();
}

class _DailyScreeningState extends SurveyScreenState<DailyScreening> {
  @override
  String surveyId = "daily-screening-";
  DaySettings daySettings;

  @override
  void initState() {
    super.initState();
  }

  @override
  List<SurveyContentTemplate> questionnaires = [];

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      dynamic args = ModalRoute.of(context).settings.arguments;
      setState(() {
        day = args["day"];
        daySettings = DailyScreeningSettings.days[day - 1];
        questionnaires = daySettings.questionnaires;
        surveyId += "$day";
      });
    }
    if (day == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else
      return super.build(context);
  }

  @override
  createModalContent(ModalType type) {
    List<Widget> children = [];

    // Start screening modal
    if (type == ModalType.WELCOME) {
      children.add(Text(
        "smart@net - Tag $day",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        daySettings.introText,
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
        "Abfrage fortsetzen",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Sie haben die Abfrage unterbrochen. Klicken Sie auf 'Weitermachen', um sie fortzusetzen.",
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
        daySettings.finishText,
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(
        ElevatedButton(
          child: Text("Fertig"),
          style: ElevatedButton.styleFrom(
            primary: MyTheme.col2,
            onPrimary: MyTheme.col2Text,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, daySettings.returnRoute != null ? daySettings.returnRoute : MainMenuScreen.ROUTE);
          },
        ),
      );
    }

    return children;
  }

  @override
  onNextPage(int pageIndex) async {
    // TODO: maybe activate this block again with other computation for new questionnaire, or delete this block
    // it was used to jump at day 8 during the questionnaire and intervention part
    /*
    if (day == 8 && (this.questionnaires[this.pageIndex].id == DecisionalBalanceQuestionnaire().id || this.questionnaires[this.pageIndex].id == Day8DecisionalBalanceIntervention().id)) {
      bool skipPage = false;

      ScavisCouchbase db = ScavisCouchbase();
      List<Fragment> list = await db.loadAllActionFlowAnswersForSurvey(surveyId: surveyId);
      list.forEach((Fragment fragment) {
        try {
          dynamic data = fragment.getMap()["data"];
          if (data["answers"]["r_sum_high-button"] == 2) {
            skipPage = true;
          }
        } catch (e) {}
      });

      if (skipPage) {
        gotoNextSurveyPage();
      }
    }
    */
  }
}
