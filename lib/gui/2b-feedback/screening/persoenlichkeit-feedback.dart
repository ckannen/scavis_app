import 'package:flutter/material.dart';
import 'package:scavis/components/charts/polar-chart/polar_chart.dart';

class PersoenlichkeitFeedback extends StatefulWidget {
  final Map ownData;
  final Map comparisonData;

  PersoenlichkeitFeedback({this.ownData, this.comparisonData});

  @override
  _PersoenlichkeitFeedbackState createState() => _PersoenlichkeitFeedbackState();
}

class _PersoenlichkeitFeedbackState extends State<PersoenlichkeitFeedback> {
  String title = "Persönlichkeit";
  String introduction =
      "Sie haben sich auch mit Hinblick auf Ihre Persönlichkeit eingeschätzt. In der Psychologie werden fünf Eigenschaften unterschieden, um Persönlichkeit zu beschreiben. Unter der Grafik werden die verschiedenen Eigenschaften genauer beschrieben. Die Beschreibungen sind dabei lediglich als Verhaltenstendenzen zu verstehen. Im Folgenden sehen Sie die Auswertung Ihrer Angaben sowie einen Vergleich zu den anderen Teilnehmenden.";
  // TODO Erkläungen nicht fett drucken
  // Skalenamen bis : fett z.B. "Extraversion:" fett, die Punktzahl dahinter normal
  // Punktzahl in der nächsten Zeile im Text. Dann Zeilenumbruch und dann der Text. wie hier bei Offenheit für Erfahrungen.
  String textExplanation = "Offenheit für Erfahrungen:\n[POINTS_OPENNESS] von 20\n" +
      "Personen mit niedrigen Werten schätzen Bekanntes und Bewährtes. Hohe Werte auf dieser Skala bedeuten, dass man eher kreativ und neugierig ist und dazu neigt, vielen unterschiedlichen Aktivitäten nachzugehen.\n" +
      "\n" +
      "Verträglichkeit: [POINTS_AGREEABLENESS] von 20\n" +
      "Personen mit niedrigen Werten brauchen länger, um Vertrauen zu anderen Menschen aufzubauen und stehen stärker für ihre eigenen Interessen ein. Hohe Werte deuten darauf hin, dass man gerne kooperiert und anderen Menschen schneller sein Vertrauen schenkt.\n" +
      "\n" +
      "Emotionale Stabilität: [POINTS_EMOTIONAL_STABILITY] von 20\n" +
      "Menschen mit niedrigen Werten erleben Emotionen intensiver und haben tendenziell eher Schwierigkeiten im Umgang mit Stresssituationen. Bei hohen Werten sind Personen weniger ängstlich und machen sich eher weniger Sorgen über die Zukunft.\n" +
      "\n" +
      "Gewissenhaftigkeit: [POINTS_CONSCIENTIOUNESS] von 20\n" +
      "Menschen mit niedrigen Werten handeln eher spontan und unbekümmert. Hohe Werte gehen eher einher mit Verlässlichkeit und disziplinierten Verhalten.\n" +
      "\n" +
      "Extraversion: [POINTS_EXTRAVERSION] von 20\n" +
      "Personen mit niedrigen Werten sind gerne alleine und unabhängig. Hohe Werte deuten darauf hin, dass man gerne Zeit in Gesellschaft anderer Menschen verbringt.";
  String additionalText = "";
  bool additionalTextVisible = false;
  dynamic polarChartSettings = {
    "data": [
      // demo data
      [50, 10, 80, 100, 70],
      [10, 30, 30, 60, 80]
    ],
    "ticks": [25, 50, 75, 100], // 4, 8, 12, 16, 20: TODO
    "features": ["Emotionale Stabilität", "Extraversion", "Offenheit", "Gewissenhaftigkeit", "Verträglichkeit"],
    "colors": [0xff395278, 0xff0081c7]
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

    // get own points in percent to display in the graph and then change the own values in the graph

    // TODO: change to points 4-20 instead of 100%

    int aggregatedAgreeablenessInPercent = (double.parse("${widget.comparisonData["agreeableness"]["avgInPercent"]}") * 100.0).round();
    int aggregatedConscientiounesssInPercent = (double.parse("${widget.comparisonData["conscientiounesss"]["avgInPercent"]}") * 100.0).round();
    int aggregatedEmotionalStabilityInPercent = (double.parse("${widget.comparisonData["emotionalStability"]["avgInPercent"]}") * 100.0).round();
    int aggregatedImaginationInPercent = (double.parse("${widget.comparisonData["imagination"]["avgInPercent"]}") * 100.0).round();
    int aggregatedExtraversionInPercent = (double.parse("${widget.comparisonData["extraversion"]["avgInPercent"]}") * 100.0).round();
    polarChartSettings["data"]
        [0] = [aggregatedEmotionalStabilityInPercent, aggregatedExtraversionInPercent, aggregatedImaginationInPercent, aggregatedConscientiounesssInPercent, aggregatedAgreeablenessInPercent];

    // get own points in percent to display in the graph and then change the own values in the graph
    int agreeablenessInPercent = (double.parse("${widget.ownData["agreeableness"]["sumInPercent"]}") * 100.0).round();
    int conscientiounesssInPercent = (double.parse("${widget.ownData["conscientiounesss"]["sumInPercent"]}") * 100.0).round();
    int emotionalStabilityInPercent = (double.parse("${widget.ownData["emotionalStability"]["sumInPercent"]}") * 100.0).round();
    int imaginationInPercent = (double.parse("${widget.ownData["imagination"]["sumInPercent"]}") * 100.0).round();
    int extraversionInPercent = (double.parse("${widget.ownData["extraversion"]["sumInPercent"]}") * 100.0).round();
    polarChartSettings["data"][1] = [emotionalStabilityInPercent, extraversionInPercent, imaginationInPercent, conscientiounesssInPercent, agreeablenessInPercent];

    // get own points as absolute values for the text
    int agreeableness = widget.ownData["agreeableness"]["sum"];
    int conscientiounesss = widget.ownData["conscientiounesss"]["sum"];
    int emotionalStability = widget.ownData["emotionalStability"]["sum"];
    int imagination = widget.ownData["imagination"]["sum"];
    int extraversion = widget.ownData["extraversion"]["sum"];

    // adjust the text with the own values instead of the placeholders
    textExplanation = textExplanation.replaceAll("[POINTS_OPENNESS]", "$imagination");
    textExplanation = textExplanation.replaceAll("[POINTS_AGREEABLENESS]", "$agreeableness");
    textExplanation = textExplanation.replaceAll("[POINTS_EMOTIONAL_STABILITY]", "$emotionalStability");
    textExplanation = textExplanation.replaceAll("[POINTS_CONSCIENTIOUNESS]", "$conscientiounesss");
    textExplanation = textExplanation.replaceAll("[POINTS_EXTRAVERSION]", "$extraversion");
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
          margin: EdgeInsets.only(bottom: 10),
          child: Text(introduction),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: MyPolarChart(data: polarChartSettings),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: FittedBox(
            child: Row(
              children: [
                Row(
                  children: [
                    Container(margin: EdgeInsets.all(5), width: 15, height: 15, color: Color(0xff395278)),
                    Container(child: Text("Vergleichsdaten")),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Container(margin: EdgeInsets.all(5), width: 15, height: 15, color: Color(0xff0081c7)),
                    Container(child: Text("Eigenes Ergebnis")),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(bottom: 10),
          child: Text("Erklärung", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
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
