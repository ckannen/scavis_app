import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scavis/theme/my-theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CombinedChart extends StatefulWidget {
  final dynamic chartData;

  CombinedChart({this.chartData});

  @override
  CombinedChartState createState() => CombinedChartState();
}

class CombinedChartState extends State<CombinedChart> {

  @override
  Widget build(BuildContext context) {
    dynamic chartData = widget.chartData;
    return SfCartesianChart(
      // border around chart
      plotAreaBorderWidth: 0,
      //x axis
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: chartData["xAxis"]["label"],
        textStyle: TextStyle(color: MyTheme.CHART_TEXT_COLOR)),
        //majorGridLines: MajorGridLines(width: 0),
        labelStyle: TextStyle(color: MyTheme.CHART_TEXT_COLOR),
      ),
      // y axis
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: chartData["yAxis"]["label"], textStyle: TextStyle(color: MyTheme.CHART_TEXT_COLOR)),
        //majorGridLines: MajorGridLines(width: 0),
        //desiredIntervals: 2,
        minimum: 0.0,
        labelStyle: TextStyle(color: MyTheme.CHART_TEXT_COLOR),
      ),
      // track ball (line shown when touching chart)
      trackballBehavior: TrackballBehavior(
        enable: false,
        lineWidth: 1,
        lineType: TrackballLineType.vertical,
        lineDashArray: [10, 10],
        lineColor: MyTheme.CHARTS_TRACKBALL_LINE_COLOR,
        activationMode: ActivationMode.singleTap
      ),
      // Chart title
      title: ChartTitle(text: chartData["title"]),
      // Enable legend
      legend: Legend(isVisible: chartData["legend"], textStyle: TextStyle(color: MyTheme.CHART_TEXT_COLOR), position: LegendPosition.bottom),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: List.generate(
        chartData["series"].length,
        (seriesIndex) {
          dynamic chartSeries = chartData["series"][seriesIndex];

          if (chartSeries["type"] == "line") {
            return LineSeries<dynamic, dynamic>(
              dataSource: chartSeries["data"],
              xValueMapper: (dynamic dataPoint, _) => dataPoint["x"],
              yValueMapper: (dynamic dataPoint, _) => dataPoint["y"],
              color: HexColor(chartSeries["color"]),
              name: chartSeries["title"],
              dataLabelSettings: DataLabelSettings(isVisible: chartSeries["labels"] == true),
              dataLabelMapper: (dynamic dataPoint, int index) {return "${dataPoint["label"]}" ?? "${dataPoint["y"]}";},
              dashArray: chartSeries["dashed"] == true ? [5.0, 12.0] : null,
            );
          }
          if (chartSeries["type"] == "bubble") {
            return BubbleSeries<dynamic, dynamic>(
              dataSource: chartSeries["data"],
              xValueMapper: (dynamic dataPoint, _) => dataPoint["x"],
              yValueMapper: (dynamic dataPoint, _) => dataPoint["y"],
              color: HexColor(chartSeries["color"]),
              name: chartSeries["title"],
              dataLabelSettings: DataLabelSettings(isVisible: chartSeries["labels"] == true),
              dataLabelMapper: (dynamic dataPoint, int index) {return "${dataPoint["label"]}" ?? "${dataPoint["y"]}";},
            );
          }
          if (chartSeries["type"] == "bar") {
            return BarSeries<dynamic, dynamic>(
              dataSource: chartSeries["data"],
              xValueMapper: (dynamic dataPoint, _) => dataPoint["x"],
              yValueMapper: (dynamic dataPoint, _) => dataPoint["y"],
              color: HexColor(chartSeries["color"]),
              name: chartSeries["title"],
              dataLabelSettings: DataLabelSettings(isVisible: chartSeries["labels"] == true),
              dataLabelMapper: (dynamic dataPoint, int index) {return "${dataPoint["label"]}" ?? "${dataPoint["y"]}";},
            );
          }
          if (chartSeries["type"] == "column") {
            return ColumnSeries<dynamic, dynamic>(
              dataSource: chartSeries["data"],
              xValueMapper: (dynamic dataPoint, _) => dataPoint["x"],
              yValueMapper: (dynamic dataPoint, _) => dataPoint["y"],
              color: HexColor(chartSeries["color"]),
              name: chartSeries["title"],
              dataLabelSettings: DataLabelSettings(isVisible: chartSeries["labels"] == true),
              dataLabelMapper: (dynamic dataPoint, int index) {return "${dataPoint["label"]}" ?? "${dataPoint["y"]}";},
            );
          }
        },
      ),
    );
  }
}
