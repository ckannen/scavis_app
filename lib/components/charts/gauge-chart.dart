import 'package:flutter/material.dart';
import 'package:scavis/theme/my-theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeChart extends StatefulWidget {
  final dynamic chartData;

  GaugeChart({this.chartData});

  @override
  GaugeChartState createState() => GaugeChartState();
}

class GaugeChartState extends State<GaugeChart> {
  @override
  Widget build(BuildContext context) {
    double min = double.parse("${widget.chartData["yAxis"]["min"]}");
    double max = double.parse("${widget.chartData["yAxis"]["max"]}");
    double value = double.parse("${widget.chartData["series"][0]["data"][0]["y"]}");
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: min,
          maximum: max,
          startAngle: 30,
          endAngle: -30,
          canScaleToFit: true,
          axisLineStyle: AxisLineStyle(
            cornerStyle: CornerStyle.bothCurve,
          ),
          pointers: <GaugePointer>[
            RangePointer(value: value, enableAnimation: true, color: MyTheme.col2, cornerStyle: CornerStyle.bothCurve),
          ],
        ),
      ],
    );
  }
}
