import 'package:flutter/material.dart';
import 'package:scavis/theme/my-theme.dart';

import 'helper/chart-circles.dart';
import 'helper/chart-colors.dart';
import 'helper/layer-type.dart';

class Labels {
  List<String> list = [];
  double fontSize = 3; // [percent: 0-100]
  Color color = MyTheme.TEXT_COLOR;
}

class Data {
  double min;
  double max;
  List<Dataset> datasets = [];
  Labels labels = Labels();
}

class Dataset {
  String title;
  List<Value> values;
  Dataset({this.values, this.title});
}

class Value {
  double value; // for a normal radar chart, only the value is needed to be set
  double min; // for a radar chart with an area that does not go to the zero point in the center, a min value is needed
  double max; // for a radar chart with an area that should go further than the chart value, a max value is needed

  Value({this.value, this.min, this.max});
}

class Grid {
  double ticks = 5; // number
  double outerLineWidth = 2; // [percent: 0-100]
  double tickLineWidth = 1; // [percent: 0-100]
  double scaleLineWidth = 1; // [percent: 0-100]
}

class DrawObjects {
  Canvas canvas;
  Paint paint;
  TextStyle textStyle;
  TextPainter textPainter;

  DrawObjects({@required this.canvas, @required this.paint, this.textStyle, this.textPainter});
}

class DrawEvent {
  LayerType layerType;
  String subType;
  int datasetIndex;
  int valueIndex;
  int valueType; // min, max, value
  DrawObjects drawObjects;
  CircleDimensions dimensions;

  DrawEvent({
    @required this.layerType,
    this.subType,
    @required this.datasetIndex,
    @required this.valueIndex,
    @required this.valueType,
    @required this.drawObjects,
    @required this.dimensions,
  });
}

class RadarChartSettings {
  double radius = 90; // [percent: 0-100]
  double startAngle = -90; // [degree: 0-360]
  double totalAngle = 360; // [degree: 0-360]
  Grid grid = Grid();
  double lineWidth = 2; // [percent: 0-100]
  double min = 0; // value
  double max = 100; // value
  double widthPx = 200; // pixel
  double heightPx = 200; // pixel
  Data data = Data();
  double pointRadius = 5;
  //List<RadarChartValue> values = [];

  // ##############################################################################################################
  // Changable Functions
  // Function that are predefined but are supposed to be changed by the user to modify the appearance of the chart
  // ##############################################################################################################

  Function(DrawEvent drawEvent) colorFn = (DrawEvent drawEvent) {
    if (drawEvent.layerType == LayerType.BG_FILL) {
      drawEvent.drawObjects.paint.color = Colors.transparent;
    }
    if (drawEvent.layerType == LayerType.BG_OUTLINE) {
      drawEvent.drawObjects.paint.color = Colors.grey;
      if (drawEvent.subType == "scaleLines") {
        drawEvent.drawObjects.paint.color = Colors.white.withOpacity(0.5);
        drawEvent.drawObjects.paint.strokeWidth = 1;
      }
    }
    if (drawEvent.layerType == LayerType.DATA_FILL) {
      drawEvent.drawObjects.paint.color = ChartColors.getDefaultColor(drawEvent.datasetIndex).withOpacity(0.2);
    }
    if (drawEvent.layerType == LayerType.DATA_OUTLINE) {
      drawEvent.drawObjects.paint.color = ChartColors.getDefaultColor(drawEvent.datasetIndex);
    }
    if (drawEvent.layerType == LayerType.LABELS) {
      TextStyle textStyle = TextStyle(
        color: drawEvent.drawObjects.textStyle.color,
        fontSize: drawEvent.drawObjects.textStyle.fontSize,
        letterSpacing: drawEvent.drawObjects.textStyle.letterSpacing,
        textBaseline: drawEvent.drawObjects.textStyle.textBaseline,
      );
      drawEvent.drawObjects.textPainter = TextPainter(
        text: TextSpan(text: drawEvent.drawObjects.textPainter.text.toPlainText(), style: textStyle),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
      );
    }
  };

  Function(DrawEvent drawEvent) radiusFn = (DrawEvent drawEvent) {
    if (drawEvent.layerType == LayerType.DATA_FILL && drawEvent.datasetIndex == 0) {
      //dimensions.innerRadius -= 4;
      //dimensions.outerRadius += 4;
    }
    //dimensions.innerRadius = (dimensions.height / 2 - 10) * 0.8;
    //dimensions.outerRadius = dimensions.height / 2 - 10;
  };

  // ##############################################################################################################
  // Normal Class Functions
  // ##############################################################################################################

  // set radiuses of the circle
  void setRadius({@required double radius}) {
    this.radius = radius;
  }

  // set the angles for the circle
  // a start angle of 0° will start the circle at the top
  // a start angle of 90° at the right
  // a total angle of 360° will display a complete circle
  // a totalAngle of 180° will display a half circle
  void setAngles({@required double startAngle, @required double totalAngle}) {
    this.startAngle = startAngle - 90;
    this.totalAngle = totalAngle;
  }

  // set the width of each line
  void setLineWidth(double lineWidth) {
    this.lineWidth = lineWidth;
  }
}
