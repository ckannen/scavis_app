import 'package:scavis/components/charts/combined-chart.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/theme/my-theme.dart';

import 'intervention-chart-creator.dart';

class Day14MoodIntervention extends ActionFlowTemplate {
  @override
  String id = "day14_intervention_mood";

  dynamic chartData = {
    "title": "Stimmung",
    "legend": true,
    "xAxis": {"label": "Tag"},
    "yAxis": {"label": "Punkte"},
    "series": [
      {
        "title": "Ihr Ergebnis",
        "type": "line",
        "labels": false,
        "color": MyTheme.GRAPH_COLOR_1_STRING,
        "data": [
          // demo data
          {"x": "Mo", "y": 8},
          {"x": "Di", "y": 7},
          {"x": "Mi", "y": 4},
          {"x": "Do", "y": 3},
          {"x": "Fr", "y": 7},
          {"x": "Sa", "y": 8},
          {"x": "So", "y": 8},
        ]
      },
    ]
  };
  
  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();

    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      // init the data for a 7-day chart
      chartData["series"][0]["data"] = InterventionChartCreator.init7DayChart(questionnaireResults["dailyMood"], "mood", 14);
    } catch (e) {
      print("could not access data");
      return false;
    }
    return true;
  }

  @override
  Future<bool> init() async {
    await super.init();

    // load the results data from the database
    bool success = await loadFromDb();
    if (!success) return false;

    flow = ActionFlow(
      initialStateId: "mb1",
      states: [
        FlowQuestionState(
            id: "mb1",
            content: "Schauen Sie sich diese Grafik zu Ihrer Stimmung in der letzten Woche an. Wie denken Sie darüber?",
            chart: CombinedChart(
              chartData: chartData,
            ),
            answers: [
              FlowAnswerButton(value: 1, text: "Das überrascht mich ein bisschen.", gotoId: "mb2"),
              FlowAnswerButton(value: 0, text: "Mein Stimmungsverlauf sieht so aus, wie ich es vermutet habe.", gotoId: "mb2"),
            ]),
        FlowQuestionState(
            id: "mb2",
            content: "Erinnern Sie sich an Ereignisse, die mit Ihrer Stimmung in der letzten Woche zusammenhingen? Wenn Sie möchten, können Sie diese hier notieren.",
            answers: [
              FlowAnswerText(id: "mb2_freeText"),
              FlowAnswerButton(value: 1, text: "Weiter", gotoId: "mb3"),
              FlowAnswerButton(value: 0, text: "Ich möchte die Ereignisse hier erstmal nicht notieren.", gotoId: "mb3"),
            ]),
        FlowQuestionState(
            id: "mb3",
            content: "Erinnern Sie sich daran, ob die Nutzung Ihres Smartphones in der letzten Woche mit Ihrer Stimmung zusammenhing? Wenn Sie möchten, können Sie hier Ihre Gedanken notieren.",
            answers: [
              FlowAnswerText(id: "mb3_freeText"),
              FlowAnswerButton(value: 1, text: "Weiter", gotoId: "mbend"),
              FlowAnswerButton(value: 0, text: "Ich möchte meine Gedanken hier erstmal nicht notieren.", gotoId: "mbend"),
            ]),
        FlowEndState(id: "mbend", content: "Vielen Dank!"),
      ],
    );

    return true;
  }
}