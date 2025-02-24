import 'package:flutter/material.dart';
import 'package:scavis/components/charts/combined-chart.dart';
import 'package:scavis/theme/my-theme.dart';

class UrbanitaetFeedback extends StatefulWidget {
  final Map ownData;
  final Map comparisonData;

  UrbanitaetFeedback({this.ownData, this.comparisonData});

  @override
  _UrbanitaetFeedbackState createState() => _UrbanitaetFeedbackState();
}

class _UrbanitaetFeedbackState extends State<UrbanitaetFeedback> {
  String title = "Urbanität";
  String textIntro = "";
  String textExplanation = "";
  String additionalText = "";
  bool additionalTextVisible = false;
  dynamic chartData = {
    "title": "Einwohnerzahl",
    "legend": true,
    "xAxis": {"label": "Einwohner"},
    "yAxis": {"label": "Personenanzahl"},
    "series": [
      {
        "title": "Anzahl Teilnehmer nach Stadtgröße",
        "type": "column",
        "labels": false,
        "color": MyTheme.GRAPH_COLOR_2_STRING,
        "data": [
          // demo data
          {"x": "<= 10.000", "y": 10},
          {"x": "> 10.000", "y": 20},
          {"x": "> 100.000", "y": 15},
        ]
      },
    ]
  };

  @override
  initState() {
    super.initState();
    initData();
  }

  initData() {
    // stop if no data was provided
    if (widget.ownData == null || widget.comparisonData == null) {
      return;
    }

    // show distribution of the city sizes for all participants
    chartData["series"][0]["data"][0]["y"] = widget.comparisonData["citySize"]["distribution"][0];
    chartData["series"][0]["data"][1]["y"] = widget.comparisonData["citySize"]["distribution"][1];
    chartData["series"][0]["data"][2]["y"] = widget.comparisonData["citySize"]["distribution"][2];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Text(textIntro),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: CombinedChart(chartData: chartData,),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          child: Text("Erklärung", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(textExplanation),
        ),
        additionalText != ""
            ? additionalTextVisible
                ? Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(additionalText),
                  )
                : Container(
                    child: ElevatedButton(
                        child: Text("Mehr erfahren"),
                        onPressed: () {
                          setState(() {
                            additionalTextVisible = true;
                          });
                        }))
            : Container(),
      ],
    );
  }
}
