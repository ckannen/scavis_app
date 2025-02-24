import 'package:flutter/material.dart';
import 'package:scavis/components/charts/combined-chart.dart';
import 'package:scavis/theme/my-theme.dart';

class IuesFeedback extends StatefulWidget {
  final Map ownData;
  final Map comparisonData;

  IuesFeedback({this.ownData, this.comparisonData});

  @override
  _IuesFeedbackState createState() => _IuesFeedbackState();
}

class _IuesFeedbackState extends State<IuesFeedback> {
  bool dataLoaded = false;
  String title = "Internetnutzung";
  String textIntro =
      "An dieser Stelle erhalten Sie eine Rückmeldung zu Ihrer eigenen Internetnutzung. Dabei wurde aus Ihren Angaben im Fragebogen ein Punktewert ermittelt, den wir hier im Vergleich zu den Werten anderer Teilnehmender darstellen. Ihr Wert muss nicht mit einem bedeutsamen Problem für Sie verbunden sein. Wir möchten Ihnen lediglich die Möglichkeit geben, über Ihr eigenes Verhalten nachzudenken, wenn Sie das möchten.";
  String textExplanation =
      "Ihr Ergebnis liegt bei [OWN_POINTS] von 56 Punkten.\n\n[PARTICIPANTS_WITH_LESS_POINTS_%]% der anderen Teilnehmenden haben einen niedrigeren Wert erzielt.\nInsgesamt liegen von [PARTICIPANT_COUNT] Teilnehmenden Angaben zur Internetnutzung vor.\n\nIm unteren Teil der Grafik sind die möglichen Punktewerte des Fragebogens zur Erfassung einer problematischen Internetnutzung abgebildet, wobei höhere Werte eine eher problematische Internetnutzung bedeuten. Eine eventuell problematische Internetnutzung bezieht sich dabei nicht auf die reine Zeit, die man online verbringt, sondern auf negative Folgen der Internetnutzung. Der große blaue Punkt zeigt Ihren Punktewert, während die Höhe der Kurve an den verschiedenen Stellen angibt, wie viele Personen einen bestimmten Punktewert erzielt haben. Je höher die Kurve an einer Stelle ausfällt, desto mehr Personen erzielten den jeweiligen Punktewert.";
  String additionalText =
      "Seit vielen Jahren wird darüber diskutiert, ob Menschen “süchtig“ nach dem Internet sein können. Der Begriff „Internetsucht“ ist umstritten, momentan sprechen Wissenschaftler*innen eher von “Internetbezogenen Störungen” oder “Internetnutzungsstörungen”. Mittlerweile gibt es unter den meisten Expert*innen Einigkeit, dass Internetnutzungsstörungen mit Beeinträchtigungen im Alltag (z. B. Produktivitätsverlust oder zwischenmenschliche Probleme) und negativen Emotionen einhergehen können. Bisher wurde jedoch nur die Computerspielstörung, eine Form der Internetnutzungsstörung, von der Weltgesundheitsorganisation anerkannt.";
  bool additionalTextVisible = false;
  dynamic chartData = {
    "title": "Punkteverteilung",
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
          {"x": 0, "y": 1},
          {"x": 1, "y": 1},
          {"x": 2, "y": 1},
          {"x": 3, "y": 1},
          {"x": 4, "y": 1},
          {"x": 5, "y": 1},
          {"x": 6, "y": 1},
          {"x": 7, "y": 1},
          {"x": 8, "y": 1},
          {"x": 9, "y": 1},
          {"x": 10, "y": 1},
          {"x": 11, "y": 2},
          {"x": 12, "y": 4},
          {"x": 13, "y": 10},
          {"x": 14, "y": 11},
          {"x": 15, "y": 12},
          {"x": 16, "y": 14},
          {"x": 17, "y": 16},
          {"x": 18, "y": 17},
          {"x": 19, "y": 20},
          {"x": 20, "y": 22},
          {"x": 21, "y": 35},
          {"x": 22, "y": 24},
          {"x": 23, "y": 25},
          {"x": 24, "y": 30},
          {"x": 25, "y": 40},
          {"x": 26, "y": 42},
          {"x": 27, "y": 44},
          {"x": 28, "y": 39},
          {"x": 29, "y": 38},
          {"x": 30, "y": 27},
          {"x": 31, "y": 25},
          {"x": 32, "y": 24},
          {"x": 33, "y": 23},
          {"x": 34, "y": 21},
          {"x": 35, "y": 18},
          {"x": 36, "y": 16},
          {"x": 37, "y": 1},
          {"x": 38, "y": 0},
          {"x": 39, "y": 1},
          {"x": 40, "y": 0},
        ]
      },
      {
        "type": "bubble",
        "title": "Ihr Ergebnis",
        "labels": true,
        "color": MyTheme.GRAPH_COLOR_1_STRING,
        "data": [
          // demo data
          {"x": 25, "y": 40, "label": "25"},
        ]
      },
      /*
      // threashold line
      {
        "type": "line",
        "title": "Grenzwert",
        "labels": false,
        "color": MyTheme.GRAPH_COLOR_3_STRING,
        "dashed": true,
        "data": [
          {"x": 21, "y": 0},
          {"x": 21, "y": 40},
        ]
      },
      */
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
    int min = widget.comparisonData["cius"]["min"];
    int max = widget.comparisonData["cius"]["max"];
    List comparisonSeries = chartData["series"][0]["data"];

    comparisonSeries.clear();
    for (int i = min; i <= max; i++) {
      int value = widget.comparisonData["cius"]["distribution"][i - min];
      comparisonSeries.add({"x": i, "y": value});
    }

    // add own data point on curve
    // at the position (x = own points and y = number of participants with the same amount of points)
    int ownPoints = widget.ownData["cius"]["sum"];
    int comparisonCountForOwnValue = widget.comparisonData["cius"]["distribution"][ownPoints - min];
    List ownSeries = chartData["series"][1]["data"];
    ownSeries.clear();
    ownSeries.add(
      {"x": ownPoints, "y": comparisonCountForOwnValue, "label": "$ownPoints"},
    );

    // total number of participants
    int participantCount = widget.comparisonData["cius"]["count"];

    // count number of participants with less points
    int participantsWithLessPoints = 0;
    for (int i = min; i < ownPoints; i++) {
      int value = widget.comparisonData["cius"]["distribution"][i - min];
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
