import 'package:flutter/material.dart';
import 'package:scavis/components/charts/combined-chart.dart';
import 'package:scavis/gui/1-login/init-study.dart';
import 'package:scavis/theme/my-theme.dart';

class SofalizingFeedback extends StatefulWidget {
  final Map ownData;
  final Map comparisonData;

  SofalizingFeedback({this.ownData, this.comparisonData});

  @override
  _SofalizingFeedbackState createState() => _SofalizingFeedbackState();
}

class _SofalizingFeedbackState extends State<SofalizingFeedback> {
  String title = "Sofalizing";
  String textIntro =
      "Sofalizing ist ein Kunstwort aus Sofa und Socializing und beschreibt, dass es einige Menschen bevorzugen, von zu Hause (vom „Sofa“) aus mit anderen Personen online Kontakt zu haben, anstatt sich mit Familie, Freund*innen, Kolleg*innen und Bekannten im wirklichen Leben zu treffen. Hier sehen Sie Ihre eigenen Werte im Vergleich zu den anderen Studienteilnehmenden.";
  String textExplanation =
      "Sofalizing lässt sich in Online-Verlagerung und Soziale Kompensation unterteilen. Personen mit höheren Werten auf der Skala Online-Verlagerung bevorzugen es, sich eher online mit anderen Menschen zu treffen, anstatt in direkter Form ohne Technologien miteinander in Kontakt zu treten.\n\nBei höheren Werten auf der Skala Soziale Kompensation sind Menschen eher der Überzeugung, dass sie in Onlinewelten dem eigenen Bedürfnis nach sozialen Interaktionen in ausreichender Weise nachgehen können (z. B. via Messenger oder Social Media). Zusätzlich beschreiben höhere Werte auf dieser Skala eher solche Personen, die ihre „reinen“ Onlinekontakte auch als wesentlichen Bestandteil ihres sozialen Umfeldes anerkennen.\n\nDer Vergleich mit den Werten der anderen Teilnehmenden soll Ihnen lediglich dabei helfen, sich einen Eindruck über Ihre eigenen Einstellungen zu verschaffen. Die Ergebnisse können nicht als gut oder schlecht bewertet werden.";
  String additionalText = "";
  bool additionalTextVisible = false;
  dynamic chartData = {
    "title": "Sofalizing",
    "legend": true,
    "xAxis": {"label": ""},
    "yAxis": {"label": "Punkte"},
    "series": [
      {
        "title": "Vergleich",
        "type": "column",
        "labels": false,
        "color": MyTheme.GRAPH_COLOR_2_STRING,
        "data": [
          // demo data
          {"x": "Online-Verlagerung", "y": 10},
          {"x": "Soziale Kompensation", "y": 12},
        ]
      },
      {
        "title": "Ihr Ergebnis",
        "type": "column",
        "labels": false,
        "color": MyTheme.GRAPH_COLOR_1_STRING,
        "data": [
          // demo data
          {"x": "Online-Verlagerung", "y": 8},
          {"x": "Soziale Kompensation", "y": 14},
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

    // set comparison data
    chartData["series"][0]["data"][0]["y"] = widget.comparisonData["onlineDisplacement"]["avg"];
    chartData["series"][0]["data"][1]["y"] = widget.comparisonData["socialCompensation"]["avg"];

    // set own data
    chartData["series"][1]["data"][0]["y"] = widget.ownData["onlineDisplacement"]["sum"];
    chartData["series"][1]["data"][1]["y"] = widget.ownData["socialCompensation"]["sum"];
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
          child: CombinedChart(
            chartData: chartData,
          ),
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
