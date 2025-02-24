import 'package:flutter/material.dart';
import 'package:scavis/components/charts/combined-chart.dart';
import 'package:scavis/theme/my-theme.dart';

class SwlsFeedback extends StatefulWidget {
  final Map ownData;
  final Map comparisonData;

  SwlsFeedback({this.ownData, this.comparisonData});

  @override
  _SwlsFeedbackState createState() => _SwlsFeedbackState();
}

class _SwlsFeedbackState extends State<SwlsFeedback> {
  String title = "Lebenszufriedenheit";
  String textIntro = "Sie haben im Fragebogen Angaben zu Ihrer allgemeinen Lebenszufriedenheit gemacht. Dazu möchten wir Ihnen an dieser Stelle eine Rückmeldung ermöglichen.";
  String textExplanation = "Ihr Ergebnis liegt bei [OWN_POINTS] von 25 Punkten.\n\n[PARTICIPANTS_WITH_LESS_POINTS_%] % der anderen Teilnehmenden haben einen niedrigeren Wert erzielt.\nInsgesamt liegen von [PARTICIPANT_COUNT] Teilnehmenden Angaben zur Lebenszufriedenheit vor.\n\nIm unteren Teil der Grafik sind die möglichen Punktewerte der allgemeinen Lebenszufriedenheit abgebildet. Höhere Werte bedeuten eine höhere Lebenszufriedenheit. Der große blaue Punkt zeigt Ihren Punktewert, während die Höhe der Kurve an den unterschiedlichen Stellen die Anzahl an Personen widerspiegelt, die den jeweiligen Punktewert erzielt haben. Je höher die Kurve an einer Stelle, desto mehr Personen erzielten diesen Punktewert.\n\nDer Vergleich mit den anderen Teilnehmenden soll Ihnen lediglich dabei helfen, Ihren eigenen Wert besser einzuordnen, ohne dass Sie sich dabei in irgendeiner Weise schlecht fühlen sollen.";
  String additionalText = "Seit vielen Jahren wird im Bereich der Positiven Psychologie zur Frage nach Wohlbefinden und Glück geforscht. Eine zentrale Stellung nimmt in diesem Zusammenhang die Erforschung der Lebenszufriedenheit ein. Was macht jemanden zufrieden mit dem eigenen Leben? In Fragebogen-Umfragen bittet man in diesem Zusammenhang Studienteilnehmende häufig darüber nachzudenken, ob sie beispielsweise generell oder in Teilbereichen ihres Lebens (Familie, Finanzen, Job, Gesundheit, etc.) Zufriedenheit erleben.";
  bool additionalTextVisible = false;
  dynamic chartData = {
    "title": "Verteilung Lebenszufriedenheit",
    "type": "line",
    "legend": true,
    "xAxis": {"label": "Punkte"},
    "yAxis": {"label": "Personenanzahl"},
    "series": [
      {
        "title": "Verteilung",
        "type": "line",
        "labels": false,
        "color": MyTheme.GRAPH_COLOR_2_STRING,
        "data": [
          // demo data
          {"x": 10, "y": 11},
          {"x": 11, "y": 12},
          {"x": 12, "y": 14},
          {"x": 13, "y": 10},
          {"x": 14, "y": 11},
          {"x": 15, "y": 12},
          {"x": 16, "y": 14},
          {"x": 17, "y": 16},
          {"x": 18, "y": 17},
          {"x": 19, "y": 20},
          {"x": 20, "y": 22},
          {"x": 21, "y": 25},
          {"x": 22, "y": 14},
          {"x": 23, "y": 15},
          {"x": 24, "y": 20},
          {"x": 25, "y": 20},
          {"x": 26, "y": 22},
          {"x": 27, "y": 24},
          {"x": 28, "y": 29},
          {"x": 29, "y": 18},
          {"x": 30, "y": 17},
          {"x": 31, "y": 15},
        ]
      },
      {
        "type": "bubble",
        "title": "Ihr Ergebnis",
        "labels": true,
        "color": MyTheme.GRAPH_COLOR_1_STRING,
        "data": [
          // demo data
          {"x": 21, "y": 25, "label": "21"},
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
    if (widget.ownData == null || widget.comparisonData == null) {
      return;
    }

    // create distribution curve
    int min = widget.comparisonData["swls"]["min"];
    int max = widget.comparisonData["swls"]["max"];
    List comparisonSeries = chartData["series"][0]["data"];
    comparisonSeries.clear();
    for (int i = min; i <= max; i++) {
      int value = widget.comparisonData["swls"]["distribution"][i - min];
      comparisonSeries.add({"x": i, "y": value});
    }

    // add own data point on curve
    // at the position (x = own points and y = number of participants with the same amount of points)
    int ownPoints = widget.ownData["swls"]["sum"];
    int comparisonCountForOwnValue = widget.comparisonData["swls"]["distribution"][ownPoints - min];
    List ownSeries = chartData["series"][1]["data"];
    ownSeries.clear();
    ownSeries.add(
      {"x": ownPoints, "y": comparisonCountForOwnValue, "label": "$ownPoints"},
    );

    // total number of participants
    int participantCount = widget.comparisonData["swls"]["count"];

    // count number of participants with less points
    int participantsWithLessPoints = 0;
    for (int i = min; i < ownPoints; i++) {
      int value = widget.comparisonData["swls"]["distribution"][i - min];
      participantsWithLessPoints += value;
    }
    int participantsWithLessPointsInPercent = (participantsWithLessPoints / participantCount * 100).round();

    // replace placeholders in text with values
    textExplanation = textExplanation.replaceAll("[OWN_POINTS]", "$ownPoints");
    textExplanation = textExplanation.replaceAll("[PARTICIPANT_COUNT]", "$participantCount");
    textExplanation = textExplanation.replaceAll("[PARTICIPANTS_WITH_LESS_POINTS_%]", "$participantsWithLessPointsInPercent");
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
