import 'package:flutter/material.dart';
import 'package:scavis/components/charts/combined-chart.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/theme/my-theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'intervention-chart-creator.dart';

class Day15FomoIntervention extends ActionFlowTemplate {
  @override
  String id = "day15_intervention_fomo";

  List<String> weekdays = ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"];
  static const String LABEL_TODAY = "heute";

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
      fomoDecision = questionnaireResults["dailyFoMO"]["computation"]["decision-on-day-15"];
      if (fomoDecision == null) throw ("value not found");

      // init the data for a 7-day chart
      chartData["series"][0]["data"] = InterventionChartCreator.init7DayChart(questionnaireResults["dailyFoMO"], "state", 15);
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
            content: "Sehen Sie sich diese Grafik an. Seit der letzten Woche ist Ihre 'Fear of Missing Out' (FoMO) gestiegen. Zur Erinnerung: Das ist die Angst, online etwas zu verpassen. Wie geht es Ihnen damit?",
            chart: CombinedChart(
              chartData: chartData,
            ),
            answers: [
              FlowAnswerButton(value: 1, text: "Gut zu wissen.", gotoId: "fl_end"),
              FlowAnswerButton(value: 2, text: "Das habe ich nicht erwartet.", gotoId: "fl_end"),
              FlowAnswerButton(value: 3, text: "Das interessiert mich nicht allzu sehr.", gotoId: "fl_end"),
              FlowAnswerButton(value: 4, text: "Das sollte ich ändern.", gotoId: "f_end"),
            ]),
        FlowQuestionState(
            id: "Lower",
            content:
                "Sehen Sie sich diese Grafik an. Seit der letzten Woche ist Ihre 'Fear of Missing Out' (FoMO) gesunken. Zur Erinnerung: FoMO ist die Angst, online etwas zu verpassen. Das könnte bedeuten, dass Sie sich weniger angespannt beim Gedanken daran fühlten, online etwas zu verpassen. Wie geht es Ihnen damit?",
            chart: CombinedChart(
              chartData: chartData,
            ),
            answers: [
              FlowAnswerButton(value: 1, text: "Darüber bin ich sehr froh.", gotoId: "fl_end"),
              FlowAnswerButton(value: 2, text: "Das habe ich nicht erwartet.", gotoId: "fl_end"),
              FlowAnswerButton(value: 3, text: "Das interessiert mich nicht allzu sehr.", gotoId: "fl_end"),
            ]),
        FlowQuestionState(
            id: "Same",
            content: "Sehen Sie sich diese Grafik an. Seit der letzten Woche ist Ihre 'Fear of Missing Out' (FoMO) fast gleich geblieben. Zur Erinnerung: FoMO ist die Angst, online etwas zu verpassen. Wie geht es Ihnen damit?",
            chart: CombinedChart(
              chartData: chartData,
            ),
            answers: [
              FlowAnswerButton(value: 1, text: "Gut zu wissen.", gotoId: "fl_end"),
              FlowAnswerButton(value: 2, text: "Das habe ich nicht erwartet.", gotoId: "fl_end"),
              FlowAnswerButton(value: 3, text: "Das interessiert mich nicht allzu sehr.", gotoId: "fl_end"),
              FlowAnswerButton(value: 4, text: "Das sollte ich ändern.", gotoId: "f_end"),
            ]),
        FlowEndState(
            id: "f_end",
            content: Column(children: [
              Text(
                  "Gute Idee. Andere Leute versuchen, mehr Zeit offline mit angenehmen Aktivitäten zu verbringen, die sie von dem ablenken, was online passiert. Wenn Sie Ideen bekommen möchten, was Sie an alternativen Dingen tun könnten, dann schauen Sie sich doch mal die verlinkte Seite an.\nHier sind Aktivitäten, die anderen Spaß machen:"),
              InkWell(
                  child: Text("https://8leben.psychenet.de/wp-content/uploads/2019/10/Kap5-AB1-Aufbau-angenehmer-Akt-191022.pdf"),
                  onTap: () async {
                    String url = "https://8leben.psychenet.de/wp-content/uploads/2019/10/Kap5-AB1-Aufbau-angenehmer-Akt-191022.pdf";
                    if (await canLaunch(url)) {
                      launch(url);
                    }
                  }),
              Text(
                  "In Corona-Zeiten sind viele Aktivitäten schwierig durchzuführen. Hier finden Sie ein paar Tipps, wie Sie gut durch die Pandemie kommen und wie Sie trotzdem Ihre Zeit mit angenehmen Aktivitäten verbringen können:"),
              InkWell(
                  child: Text("[Liste 'Corona-konforme Aktivitäten' als PDF hinterlegen]"),
                  onTap: () async {
                    String url = "https://app.scavis.net/files-for-app/Corona-konforme-Aktivitaeten.pdf";
                    if (await canLaunch(url)) {
                      launch(url);
                    }
                  }),
            ])),
        FlowEndState(id: "fl_end", content: "Vielen Dank für Ihre Antwort!"),
      ],
    );

    return true;
  }
}