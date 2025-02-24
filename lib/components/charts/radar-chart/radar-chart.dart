import 'radar-chart-settings.dart';
import 'radar-chart-painter.dart';
import 'package:flutter/material.dart';

class RadarChart extends StatefulWidget {
  final _RadarChartState state = _RadarChartState();
  final RadarChartSettings settings;
  final Function(int a, int b) colorFn;

  RadarChart({Key key, @required this.settings, this.colorFn}) : super(key: key);

  @override
  _RadarChartState createState() => state;
}

class _RadarChartState extends State<RadarChart> {
  @override
  Widget build(BuildContext context) {
    // Fitted Box
    // Sized Box
    // Custom paint

    return Container(
      width: widget.settings.widthPx,
      height: widget.settings.heightPx,
      child: CustomPaint(
        painter: RadarChartPainter(widget.settings),
      ),
    );
  }
}
