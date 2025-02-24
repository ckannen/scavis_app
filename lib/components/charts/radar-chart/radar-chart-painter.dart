import 'helper/chart-circles.dart';
import 'helper/layer-type.dart';
import 'helper/math-helper.dart';
import 'radar-chart-corner-positions.dart';
import 'package:flutter/material.dart';

import 'radar-chart-settings.dart';
import 'dart:math' as math;

class RadarChartPainter extends CustomPainter {
  RadarChartSettings settings;
  RadarChartPainter(this.settings);

  Offset _center;
  CornerPositions _cornerPositions;
  CircleDimensions _circleDimensions;
  Canvas _canvas;
  Size _size;
  Paint _paint;
  double pxPerPercent;

  @override
  void paint(Canvas canvas, Size size) {
    pxPerPercent = size.shortestSide / 100;
    _canvas = canvas;
    _size = size;
    if (!prepare()) return;

    drawGrid();
    drawRadarChart(LayerType.DATA_OUTLINE);
    drawRadarChart(LayerType.DATA_FILL);

    drawLabels();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  bool prepare() {
    if (settings.data.datasets.length == 0) {
      return false;
    }

    int cornerCount = settings.data.datasets[0].values.length;

    if (cornerCount == 0) {
      return false;
    }

    // create paint
    _paint = Paint();
    _paint.strokeWidth = settings.lineWidth;

    // find the enter of the canvas
    _center = Offset(_size.width / 2, _size.height / 2);

    // calculate the positions of all corners
    _cornerPositions = CornerPositions(
      center: _center,
      cornerCount: cornerCount,
      startAngle: settings.startAngle,
      totalAngle: settings.totalAngle,
    );

    // get the dimensions of the circle
    _circleDimensions = CircleDimensions(center: _center, innerRadius: settings.radius, outerRadius: settings.radius);

    return true;
  }

  void drawRadarChart(LayerType layerType) {
    /*
    // Draw as lines instead of bars
    Path path = Path();
    */

    // get the chart dimensions

    // draw each bar/line in the circle

    // draw grid

    // draw data of each dataset
    int datasetIndex = 0;
    settings.data.datasets.forEach((dataset) {
      if ([LayerType.DATA_FILL, LayerType.DATA_OUTLINE].indexOf(layerType) != -1) {
        drawPolygon(layerType, datasetIndex, 2, List.generate(dataset.values.length, (index) => dataset.values[index].value / settings.max));
      }
      datasetIndex++;
    });

    // draw grid
    //    background
    //    lines
    // draw each dataset
    //    area
    //      background
    //      outlines
    //    points
    //      background
    //      outlines
    // draw labels
  }

  // draw grid
  drawGrid() {
    [LayerType.BG_FILL, LayerType.BG_OUTLINE].forEach((layerType) {
      for (int tick = 0; tick <= settings.grid.ticks; tick++) {
        drawPolygon(layerType, -1, 1, List.generate(5, (index) => tick / settings.grid.ticks));
      }
    });
    drawScaleLines(settings.radius);
  }

  drawPolygon(LayerType layerType, int datasetIndex, double lineWidth, List<double> scaleFactors) {
    // set the color by calling the color function
    // the color function directly manipulates the paint object
    // and can set the color, shader, mask filters, line width and so on

    DrawEvent drawEvent = DrawEvent(
      layerType: layerType,
      datasetIndex: datasetIndex,
      valueIndex: -1,
      valueType: null,
      dimensions: _circleDimensions,
      drawObjects: DrawObjects(canvas: _canvas, paint: _paint),
    );

    settings.colorFn(drawEvent);

    // set the inner and outer radius to the default values defined in the settings
    // and then call the radius function that ight adjust the radiuses for different layers and values
    settings.radiusFn(drawEvent);

    Path path = Path();
    for (int i = 0; i < settings.data.datasets[0].values.length; i++) {
      Offset corner = _cornerPositions.getCorner(i, settings.radius * scaleFactors[i]);

      if (i == 0) {
        path.moveTo(corner.dx, corner.dy);
      } else {
        path.lineTo(corner.dx, corner.dy);
      }
    }

    // if the chart has not the full 360°, do not close the path directly, but make a detour over the center, so that the chart stays on the outer grid line
    if (settings.totalAngle != 360) {
      path.lineTo(_center.dx, _center.dy);
    }

    path.close();
    if ([LayerType.BG_FILL, LayerType.DATA_FILL].indexOf(layerType) != -1) {
      _paint.style = PaintingStyle.fill;
    }
    if ([LayerType.BG_OUTLINE, LayerType.DATA_OUTLINE].indexOf(layerType) != -1) {
      _paint.style = PaintingStyle.stroke;
    }

    _paint.strokeWidth = lineWidth;
    _canvas.drawPath(path, _paint);
  }

  drawScaleLines(double radius) {
    DrawEvent drawEvent = DrawEvent(
      layerType: LayerType.BG_OUTLINE,
      subType: "scaleLines",
      datasetIndex: -1,
      valueIndex: -1,
      valueType: null,
      dimensions: _circleDimensions,
      drawObjects: DrawObjects(canvas: _canvas, paint: _paint),
    );

    for (int i = 0; i < settings.data.datasets[0].values.length; i++) {
      drawEvent.valueIndex = i;
      settings.colorFn(drawEvent);
      _canvas.drawLine(_center, _cornerPositions.getCorner(i, radius), _paint);
    }
  }

  // draw all labels
  drawLabels() {
    for (int i = 0; i < settings.data.labels.list.length; i++) {
      Offset corner = _cornerPositions.getCorner(i, settings.radius);
      drawLabel(_center, Offset(corner.dx, corner.dy), _circleDimensions, i);
    }
  }

  // draw one label
  drawLabel(Offset center, Offset textPos, CircleDimensions dimensions, int labelIndex) {
    String label = settings.data.labels.list[labelIndex];

    double fontSize = settings.data.labels.fontSize * pxPerPercent;

    TextStyle textStyle = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1),
      fontSize: fontSize,
      letterSpacing: 1,
      textBaseline: TextBaseline.ideographic,
    );
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: label, style: textStyle),
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
    );



    // call color function
    DrawEvent drawEvent = DrawEvent(
      layerType: LayerType.LABELS,
      datasetIndex: -1,
      valueIndex: labelIndex,
      valueType: null,
      dimensions: _circleDimensions,
      drawObjects: DrawObjects(canvas: _canvas, paint: _paint, textStyle: textStyle, textPainter: textPainter,),
    );

    settings.colorFn(drawEvent);
    textPainter = drawEvent.drawObjects.textPainter;


    textPainter.layout(
      maxWidth: _size.width - 12.0 - 12.0,
    );

    // calculate text x position
    double textX = textPos.dx;
    if (textPos.dx.round() == center.dx.round())
      textX -= textPainter.width / 2;
    else if (textPos.dx < center.dx) textX -= textPainter.width;

    // calculate text y position
    double textY = textPos.dy;
    textY -= ((center.dy + dimensions.height / 2) - textY) / dimensions.height * fontSize;

    // add padding to text
    if (textPos.dx.round() == center.dx.round()) {
    } else if (textPos.dx < center.dx)
      textX -= 5;
    else
      textX += 5;
    if (textPos.dy.round() == (center.dy - dimensions.height / 2).round()) textY -= 5;
    if (textPos.dy.round() == (center.dy + dimensions.height / 2).round()) textY += 5;

    

    // draw text
    textPainter.paint(_canvas, Offset(textX, textY));
  }

  getValueBounds() {
    double min = settings.data.min;
    double max = settings.data.max;

    // if no min and max value was set, calculate the min and max value over all values
    double calculatedMin, calculatedMax;
    settings.data.datasets.forEach((dataset) {
      dataset.values.forEach((value) {
        calculatedMin = math.min(calculatedMin, ChartMathHelper.getMin([value.min, value.max, value.value, calculatedMin]));
        calculatedMax = math.max(calculatedMax, ChartMathHelper.getMax([value.min, value.max, value.value, calculatedMax]));
      });
    });
    if (settings.data.min == null) min = calculatedMin;
    if (settings.data.max == null) max = calculatedMax;
  }
}
