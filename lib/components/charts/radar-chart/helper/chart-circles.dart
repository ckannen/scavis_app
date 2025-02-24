import 'dart:math' as math;

import 'package:flutter/painting.dart';

enum DrawType { OUTLINE, FILL }

class CircleRadiuses {
  double innerRadius;
  double outerRadius;

  CircleRadiuses(this.innerRadius, this.outerRadius);
}

class CircleDimensions {
  Offset center;
  double innerRadius;
  double outerRadius;
  double width;
  double height;
  Rect rect;

  CircleDimensions({this.center, this.innerRadius, this.outerRadius}) {
    width = outerRadius * 2;
    height = outerRadius * 2;
    rect = Rect.fromCenter(center: center, width: width, height: height);
  }
}

class ChartCircles {
  // convert a degree to radian value
  static double degreeToRadian(num d) {
    return d / 180 * math.pi;
  }

  // convert a radian to a degree value
  static double radianToDegree(num r) {
    return r * 180 / math.pi;
  }

  static Path createArcSegmentPath(Offset center, double innerRadius, double outerRadius, double startAngle, double angle) {
    Path path = Path();
    double x1 = center.dx + math.cos(degreeToRadian(startAngle)) * innerRadius;
    double y1 = center.dy + math.sin(degreeToRadian(startAngle)) * innerRadius;
    path.moveTo(x1, y1);
    double x2 = center.dx + math.cos(degreeToRadian(startAngle)) * outerRadius;
    double y2 = center.dy + math.sin(degreeToRadian(startAngle)) * outerRadius;
    path.lineTo(x2, y2);
    path.arcTo(Rect.fromCenter(center: center, width: 2*outerRadius, height: 2*outerRadius), degreeToRadian(startAngle), degreeToRadian(angle), false);
    double x3 = center.dx + math.cos(degreeToRadian(startAngle + angle)) * innerRadius;
    double y3 = center.dy + math.sin(degreeToRadian(startAngle + angle)) * innerRadius;
    path.lineTo(x3, y3);
    path.arcTo(Rect.fromCenter(center: center, width: 2*innerRadius, height: 2*innerRadius), degreeToRadian(startAngle + angle), -degreeToRadian(angle), false);
    path.close();
    return path;
  }

  // draw a full circle
  static void drawFullCircle(Canvas canvas, Paint paint, Offset center, double outerRadius, double innerRadius, DrawType drawType) {
    // draw the outline or fill of the circle
    if (drawType == DrawType.OUTLINE) {
      paint.style = PaintingStyle.stroke;
      //paint.strokeWidth = settings.outlineWidth;
      canvas.drawCircle(center, outerRadius, paint);
      canvas.drawCircle(center, innerRadius, paint);
    } else if (drawType == DrawType.FILL) {
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = outerRadius - innerRadius;
      canvas.drawCircle(center, innerRadius + paint.strokeWidth / 2, paint);
    }
  }

  // draw circle segment
  static void drawSegment(Canvas canvas, Paint paint, Offset center, double outerRadius, double innerRadius, double startAngle, double sweepAngle, DrawType drawType) {
    // create the path for the segment
    Path path = ChartCircles.createArcSegmentPath(center, innerRadius, outerRadius, startAngle, sweepAngle);

    // draw the outline or fill of the circle segment
    if (drawType == DrawType.OUTLINE) {
      paint.style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    } else if (drawType == DrawType.FILL) {
      paint.style = PaintingStyle.fill;
      canvas.drawPath(path, paint);
    }
  }
}