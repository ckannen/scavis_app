import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:scavis/theme/my-theme.dart';

class ChartColors {
  static List<Color> defaultColors = [MyTheme.col2, MyTheme.col1, Colors.blue, Colors.purple,];

  static getDefaultColor(int index) {
    return defaultColors[index % defaultColors.length];
  }

  // set the paint color either as color or as gradient/shader
  // start at the beginning of the list and use the first element that is a color or a shader as paint color
  static bool setPaintColor(Paint paint, List<dynamic> colorAndShaderList) {
    for (int i=0; i<colorAndShaderList.length; i++) {
      dynamic element = colorAndShaderList[i];
      if (element != null) {
        if (element is Shader) {
          paint.shader = element;
          return true;
        }
        if (element is Color) {
          paint.color = element;
          paint.shader = null;
          return true;
        }
      }  
    }
    return false;
  }
}