import 'package:flutter/material.dart';
import 'package:scavis/components/charts/combined-chart.dart';
import 'package:scavis/theme/my-theme.dart';

class FomoFeedback extends StatefulWidget {
  final Map ownData;
  final Map comparisonData;

  FomoFeedback({this.ownData, this.comparisonData});

  @override
  _FomoFeedbackState createState() => _FomoFeedbackState();
}

class _FomoFeedbackState extends State<FomoFeedback> {
  String title = "Fear of Missing Out";
  String textIntro = "„Fear of Missing Out“ oder kurz FoMO beschreibt ein Phänomen, welches besonders im Zeitalter sozialer Medien große Beachtung findet. Wenn Menschen FoMO erleben, haben sie häufig Angst, etwas in ihrem Freundeskreis oder erweiterten sozialen Netzwerk zu verpassen: Vielleicht haben andere gerade eine gute Zeit und man selber ist nicht dabei!\nMenschen unterscheiden sich in ihrem FoMO-Erleben. Manche empfinden FoMO nur schwach, andere dagegen eher stark.\nDa Sie in den Fragebögen ebenfalls Aussagen zu Ihrem eigenen FoMO-Erleben gemacht haben, möchten wir Ihnen dazu eine Rückmeldung geben.";
  String textExplanation = "Im oberen Teil der Abbildung ist Ihr generelles FoMO-Erleben im Vergleich zu den bisherigen Teilnehmenden dargestellt. Dieser FoMO-Wert bezieht sich auf Ihr generelles FoMO-Erleben, das Sie im Alltag, der nicht online stattfindet, erleben.\n\nDer untere FoMO-Wert der Abbildung bezieht sich auf das von Ihnen empfundene online FoMO-Erleben, im Kontext von Smartphone, soziale Medien & Co.\n\nHöhere Werte bedeuten ein höheres FoMO-Erleben. Obwohl FoMO mit negativen Emotionen einhergehen kann, ist FoMO keine psychische Störung. FoMO ist eine Erfahrung, die viele Menschen in unterschiedlichem Ausmaß machen. Vielleicht regt der Vergleich mit anderen Sie dazu an, über Ihr Verhalten und Erleben nachzudenken.";
  String additionalText = "";
  bool additionalTextVisible = false;
  dynamic chartData = {
    "title": "FoMO",
    "legend": true,
    "xAxis": {"label": ""},
    "yAxis": {"label": "Punkte"},
    "series": [
      {
        "title": "Vergleich",
        "type": "bar",
        "labels": false,
        "color": MyTheme.GRAPH_COLOR_2_STRING,
        "data": [
          // demo data
          {"x": "online", "y": 12},
          {"x": "generell", "y": 10},
        ]
      },
      {
        "title": "Ihr Ergebnis",
        "type": "bar",
        "labels": false,
        "color": MyTheme.GRAPH_COLOR_1_STRING,
        "data": [
          // demo data
          {"x": "online", "y": 14},
          {"x": "generell", "y": 8},
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
    chartData["series"][0]["data"][0]["y"] = widget.comparisonData["state"]["avg"];
    chartData["series"][0]["data"][1]["y"] = widget.comparisonData["trait"]["avg"];

    // set own data
    chartData["series"][1]["data"][0]["y"] = widget.ownData["state"]["sum"];
    chartData["series"][1]["data"][1]["y"] = widget.ownData["trait"]["sum"];
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
