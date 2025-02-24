import 'package:flutter/material.dart';
import 'package:scavis/components/charts/gauge-chart.dart';
import 'package:scavis/theme/my-theme.dart';

class Pss4Feedback extends StatefulWidget {
  final Map ownData;
  final Map comparisonData;

  Pss4Feedback({this.ownData, this.comparisonData});

  @override
  _Pss4FeedbackState createState() => _Pss4FeedbackState();
}

class _Pss4FeedbackState extends State<Pss4Feedback> {
  String title = "Stress";
  String textIntro =
      "Stress kennen viele Menschen nur zu gut. Wir leben in einer schnelllebigen Zeit, in der wir viele Anforderungen meistern müssen. Ein voller Terminkalender, die Pflege kranker Angehöriger oder das Betreuen der eigenen Kinder im COVID-19-Lockdown – das alles kann schnell stressen.\nIn einem Fragebogen haben Sie angegeben, wie gestresst Sie in letzter Zeit gewesen sind. Wollen Sie wissen wie es anderen in einem ähnlichen Zeitraum ergangen ist? Hier zeigen wir Ihnen Ihr eigenes Stresserleben im Vergleich zu den anderen Studienteilnehmenden.";
  String textExplanation =
      "Möglicherweise haben Sie höhere Werte als andere Studienteilnehmende erzielt. Das kann sein, wenn Sie beispielsweise in der letzten Zeit mehr Stressereignisse bewältigen mussten als andere. Das ist kein Grund sich schlecht zu fühlen, sondern eher zu überlegen, wie Sie wieder in stressfreie Zeiten kommen können.";
  String additionalText = "";
  bool additionalTextVisible = false;
  dynamic chartData = {
    "title": "PSS-4",
    "legend": true,
    "xAxis": {"label": "Punkte"},
    "yAxis": {"label": "Personenanzahl", "min": 4, "max": 20},
    "series": [
      {
        "title": "Vergleich",
        "type": "doughnut",
        "labels": false,
        "color": MyTheme.GRAPH_COLOR_2_STRING,
        "data": [
          // demo data
          {"x": "Score", "y": 10},
        ]
      },
    ]
  };

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    // stop if no data was provided
    if (widget.ownData == null) {
      return;
    }

    // read min and max value and the points reached on the scale
    chartData["yAxis"]["min"] = widget.ownData["pss4"]["range"]["min"];
    chartData["yAxis"]["max"] = widget.ownData["pss4"]["range"]["max"];
    chartData["series"][0]["data"][0]["y"] = widget.ownData["pss4"]["sum"];
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
          constraints: BoxConstraints(maxHeight: 200),
          margin: EdgeInsets.only(bottom: 10),
          child: Stack(
            children: [
              GaugeChart(
                chartData: chartData,
              ),
              Center(
                child: Container(margin: EdgeInsets.only(left: 120), alignment: Alignment.center, child: Text("${chartData["series"][0]["data"][0]["y"]} Punkte")),
              ),
            ],
          ),
        ),
        Container(
          child: Column(children: [
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
          ]),
        )
      ],
    );
  }
}
