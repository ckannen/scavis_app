
import 'package:flutter/material.dart';

class RadarChartValue {
  dynamic value;
  String label;


  
  double opacityPct = 1;
  double sizePct = 1;
  Color bgColor;
  Color color;
  
  

  RadarChartValue({this.value, this.opacityPct, this.sizePct, this.bgColor, this.color, this.label});
}