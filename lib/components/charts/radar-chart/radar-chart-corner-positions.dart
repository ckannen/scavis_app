import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'helper/chart-circles.dart';

class CornerPositions {
  Offset center;
  List<Offset> offsets = List();

  // calculate all positions that are relevant to draw the radar chart
  // _center: is the center position of the chart
  // _offset is the position of the corner on the Unit Circle from the center (sin, cos)
  CornerPositions({@required this.center, @required int cornerCount, double startAngle, double totalAngle}) {
    // define the start position of the circle and the angle size per step
    double degreeOffset = startAngle;
    // device the total angle for the chart by the number of corners
    // an exception is when the chart is not full 360°. Then one corner less
    double stepAngle = totalAngle / (totalAngle == 360 ? cornerCount : cornerCount - 1);

    // calculate each corner position of the chart
    for (int i = 0; i < cornerCount; i++) {
      // get the x and y position on the circle for the current value and draw a line between them
      // for this use the sin and cos function to get the position on the Unit Cirlce and multiply it with the radius
      Offset offset = Offset(
        math.cos(ChartCircles.degreeToRadian(degreeOffset)),
        math.sin(ChartCircles.degreeToRadian(degreeOffset)),
      );
      offsets.add(offset);

      // go to the next corner
      degreeOffset += stepAngle;
    }
  }

  // get corner
  Offset getCorner(int index, double radius) {
    if (index >= offsets.length) return null;

    return Offset(
      center.dx + offsets[index].dx * radius,
      center.dy + offsets[index].dy * radius,
    );
  }
}