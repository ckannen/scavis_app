import 'package:scavis/theme/my-theme.dart';

import 'polar_chart_custom.dart';
import 'package:flutter/material.dart';

class MyPolarChart extends StatelessWidget {
  final dynamic data;

  MyPolarChart({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PolarChartCustom(
        ticks: data["ticks"],
        features: data["features"],
        data: data["data"],
        featuresTextStyle: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 12),
        graphColors: data["colors"].map<Color>((x) {
          return Color(x);
        }).toList(),
      ),
    );
  }
}