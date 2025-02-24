import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CombinedCircularChart extends StatefulWidget {
  final dynamic chartData;

  CombinedCircularChart({this.chartData});

  @override
  CombinedCircularChartState createState() => CombinedCircularChartState();
}

class CombinedCircularChartState extends State<CombinedCircularChart> {

  @override
  Widget build(BuildContext context) {
    dynamic chartData = widget.chartData;
    return SfCircularChart(
      //primaryXAxis: CategoryAxis(title: AxisTitle(text: "Punkte")),
      //primaryYAxis: CategoryAxis(title: AxisTitle(text: "Personen in Punktgruppe"), minimum: 0.0),
      // Chart title
      title: ChartTitle(text: chartData["title"]),
      // Enable legend
      legend: Legend(isVisible: chartData["legend"], position: LegendPosition.bottom),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: List.generate(
        chartData["series"].length,
        (seriesIndex) {
          dynamic chartSeries = chartData["series"][seriesIndex];
          if (chartSeries["type"] == "radial-bar") {
            return RadialBarSeries<dynamic, dynamic>(
              dataSource: chartSeries["data"],
              xValueMapper: (dynamic dataPoint, _) => dataPoint["x"],
              yValueMapper: (dynamic dataPoint, _) => dataPoint["y"],
              strokeColor: HexColor(chartSeries["color"]),
              name: chartSeries["title"],
              dataLabelSettings: DataLabelSettings(isVisible: chartSeries["labels"] == true),
            );
          }
          if (chartSeries["type"] == "doughnut") {
            return DoughnutSeries<dynamic, dynamic>(
              dataSource: chartSeries["data"],
              xValueMapper: (dynamic dataPoint, _) => dataPoint["x"],
              yValueMapper: (dynamic dataPoint, _) => dataPoint["y"],
              strokeColor: HexColor(chartSeries["color"]),
              name: chartSeries["title"],
              dataLabelSettings: DataLabelSettings(isVisible: chartSeries["labels"] == true),
            );
          }
          if (chartSeries["type"] == "radial-gaudge") {
            return DoughnutSeries<dynamic, dynamic>(
              dataSource: chartSeries["data"],
              xValueMapper: (dynamic dataPoint, _) => dataPoint["x"],
              yValueMapper: (dynamic dataPoint, _) => dataPoint["y"],
              strokeColor: HexColor(chartSeries["color"]),
              name: chartSeries["title"],
              dataLabelSettings: DataLabelSettings(isVisible: chartSeries["labels"] == true),
            );
          }
          return null;
        },
      ),
    );
  }
}
