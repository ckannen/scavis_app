import 'package:scavis/components/charts/combined-chart.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';
import 'package:scavis/theme/my-theme.dart';

import 'intervention-chart-creator.dart';

class Day22FomoIntervention extends ActionFlowTemplate {
  @override
  String id = "day22_intervention_fomo";

  String fomoDecision;

  dynamic chartData = {
    "title": "FoMO",
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
      fomoDecision = questionnaireResults["dailyFoMO"]["computation"]["decision-on-day-22"];
      if (fomoDecision == null) throw ("value not found");

      // init the data for a 7-day chart
      chartData["series"][0]["data"] = InterventionChartCreator.init7DayChart(questionnaireResults["dailyFoMO"], "state", 22);
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
      initialStateId: "FoMo",
      states: [
        FlowDecision(
            id: "FoMo",
            decide: () {
              if (fomoDecision == "Higher") return "Higher";
              if (fomoDecision == "Lower") return "Lower";
              if (fomoDecision == "Same") return "Same";
            }),
        FlowQuestionState(
            id: "Higher",
            content: "Wir haben uns schon eine Weile nicht mehr mit Ihrer 'Fear of Missing Out' (FoMO) beschäftigt, also der Angst, online etwas zu verpassen. Interessiert es Sie, wie sich Ihre FoMO entwickelt hat?",
            answers: [
              FlowAnswerButton(value: 1, text: "Ja", gotoId: "fhy"),
              FlowAnswerButton(value: 0, text: "Nein", gotoId: "f_no"),
            ]),
        FlowQuestionState(
            id: "Lower",
            content: "Wir haben uns schon eine Weile nicht mehr mit Ihrer 'Fear of Missing Out' (FoMO) beschäftigt, also der Angst, online etwas zu verpassen. Interessiert es Sie, wie sich Ihre FoMO entwickelt hat?",
            answers: [
              FlowAnswerButton(value: 1, text: "Ja", gotoId: "fly"),
              FlowAnswerButton(value: 0, text: "Nein", gotoId: "f_no"),
            ]),
        FlowQuestionState(
            id: "Same",
            content: "Wir haben uns schon eine Weile nicht mehr mit Ihrer 'Fear of Missing Out' (FoMO) beschäftigt, also der Angst, online etwas zu verpassen. Interessiert es Sie, wie sich Ihre FoMO entwickelt hat?",
            answers: [
              FlowAnswerButton(value: 1, text: "Ja", gotoId: "fsy"),
              FlowAnswerButton(value: 0, text: "Nein", gotoId: "f_no"),
            ]),

        // End States
        FlowEndState(
          id: "fhy",
          content:
              "Sehen Sie sich diese Grafik an. Sie werden sehen, dass Ihre 'FoMO' gestiegen ist. Machen Sie sich keine Sorgen. Möglicherweise ist das okay für Sie, vielleicht möchten Sie es aber auch ändern. Wenn Sie es ändern wollen, kann das einige Zeit dauern - wie bei vielen Menschen. Irgendwann werden Sie es schaffen!",
          chart: CombinedChart(
              chartData: chartData,
            ),
        ),
        FlowEndState(id: "f_no", content: "Sie scheinen nicht allzu neugierig zu sein. Das ist in Ordnung."),
        FlowEndState(
          id: "fly",
          content:
              "Sehen Sie sich diese Grafik an. Sie werden sehen, dass Ihre 'FoMO' gesunken ist. Herzlichen Glückwunsch! Das wird Ihr Leben weniger stressig machen und Sie können mehr kostbare Zeit offline verbringen.",
          chart: CombinedChart(
              chartData: chartData,
            ),
        ),
        FlowEndState(
          id: "fsy",
          content:
              "Sehen Sie sich diese Grafik an. Sie werden sehen, dass Ihre 'FoMO' fast unverändert geblieben ist. Möglicherweise ist das okay für Sie, vielleicht möchten Sie es aber auch ändern. Wenn Sie es ändern wollen, kann das einige Zeit dauern - wie bei vielen Menschen. Irgendwann werden Sie es schaffen!",
          chart: CombinedChart(
              chartData: chartData,
            ),
        ),
      ],
    );

    return true;
  }
}
