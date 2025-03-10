import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

import 'package:scavis/theme/my-theme.dart';

const defaultGraphColors = [
  Colors.green,
  Colors.blue,
  Colors.red,
  Colors.orange,
];

class PolarChartCustom extends StatefulWidget {
  final List<int> ticks;
  final List<String> features;
  final List<List<int>> data;
  final bool reverseAxis;
  final TextStyle ticksTextStyle;
  final TextStyle featuresTextStyle;
  final Color outlineColor;
  final Color axisColor;
  final List<Color> graphColors;
  final int sides;

  const PolarChartCustom({
    Key key,
    @required this.ticks,
    @required this.features,
    @required this.data,
    this.reverseAxis = false,
    this.ticksTextStyle = const TextStyle(color: Colors.grey, fontSize: 12),
    this.featuresTextStyle = const TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
    this.outlineColor = Colors.black,
    this.axisColor = Colors.grey,
    this.graphColors = defaultGraphColors,
    this.sides = 0,
  }) : super(key: key);

  factory PolarChartCustom.light({
    @required List<int> ticks,
    @required List<String> features,
    @required List<List<int>> data,
    bool reverseAxis = false,
    bool useSides = false,
  }) {
    return PolarChartCustom(ticks: ticks, features: features, data: data, reverseAxis: reverseAxis, sides: useSides ? features.length : 0);
  }

  factory PolarChartCustom.dark({
    @required List<int> ticks,
    @required List<String> features,
    @required List<List<int>> data,
    bool reverseAxis = false,
    bool useSides = false,
  }) {
    return PolarChartCustom(
        ticks: ticks,
        features: features,
        data: data,
        featuresTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
        outlineColor: Colors.white,
        axisColor: Colors.grey,
        reverseAxis: reverseAxis,
        sides: useSides ? features.length : 0);
  }

  @override
  _PolarChartCustomState createState() => _PolarChartCustomState();
}

class _PolarChartCustomState extends State<PolarChartCustom> with SingleTickerProviderStateMixin {
  double fraction = 0;
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: animationController,
    ))
      ..addListener(() {
        setState(() {
          fraction = animation.value;
        });
      });

    animationController.forward();
  }

  @override
  void didUpdateWidget(PolarChartCustom oldWidget) {
    super.didUpdateWidget(oldWidget);

    animationController.reset();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, double.infinity),
      painter: PolarChartPainter(widget.ticks, widget.features, widget.data, widget.reverseAxis, widget.ticksTextStyle, widget.featuresTextStyle, widget.outlineColor, widget.axisColor,
          widget.graphColors, widget.sides, this.fraction),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class PolarChartPainter extends CustomPainter {
  final List<int> ticks;
  final List<String> features;
  final List<List<int>> data;
  final bool reverseAxis;
  final TextStyle ticksTextStyle;
  final TextStyle featuresTextStyle;
  final Color outlineColor;
  final Color axisColor;
  final List<Color> graphColors;
  final int sides;
  final double fraction;

  PolarChartPainter(
    this.ticks,
    this.features,
    this.data,
    this.reverseAxis,
    this.ticksTextStyle,
    this.featuresTextStyle,
    this.outlineColor,
    this.axisColor,
    this.graphColors,
    this.sides,
    this.fraction,
  );

  Path variablePath(Size size, double radius, int sides) {
    var path = Path();
    var angle = (math.pi * 2) / sides;

    Offset center = Offset(size.width / 2, size.height / 2);

    if (sides < 3) {
      // Draw a circle
      path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ));
    } else {
      // Draw a polygon
      Offset startPoint = Offset(radius * cos(-pi / 2), radius * sin(-pi / 2));

      path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

      for (int i = 1; i <= sides; i++) {
        double x = radius * cos(angle * i - pi / 2) + center.dx;
        double y = radius * sin(angle * i - pi / 2) + center.dy;
        path.lineTo(x, y);
      }
      path.close();
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2.0;
    final centerY = size.height / 2.0;
    final centerOffset = Offset(centerX, centerY);
    final radius = math.min(centerX, centerY) * 0.8;
    final scale = radius / ticks.last;

    // Painting the chart outline
    var outlinePaint = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;

    var ticksPaint = Paint()
      ..color = axisColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    canvas.drawPath(variablePath(size, radius, this.sides), outlinePaint);
    // Painting the circles and labels for the given ticks (could be auto-generated)
    // The last tick is ignored, since it overlaps with the feature label
    var tickDistance = radius / (ticks.length);
    var tickLabels = reverseAxis ? ticks.reversed.toList() : ticks;

    if (reverseAxis) {
      TextPainter(
        text: TextSpan(text: tickLabels[0].toString(), style: ticksTextStyle),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(canvas, Offset(centerX, centerY - ticksTextStyle.fontSize));
    }

    tickLabels.sublist(reverseAxis ? 1 : 0, reverseAxis ? ticks.length : ticks.length - 1).asMap().forEach((index, tick) {
      var tickRadius = tickDistance * (index + 1);

      canvas.drawPath(variablePath(size, tickRadius, this.sides), ticksPaint);

      TextPainter(
        text: TextSpan(text: tick.toString(), style: ticksTextStyle),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(canvas, Offset(centerX, centerY - tickRadius - ticksTextStyle.fontSize));
    });

    // Painting the axis for each given feature
    var angle = (2 * pi) / features.length;

    features.asMap().forEach((index, feature) {
      var xAngle = cos(angle * index - pi / 2);
      var yAngle = sin(angle * index - pi / 2);

      var featureOffset = Offset(centerX + radius * xAngle, centerY + radius * yAngle);

      canvas.drawLine(centerOffset, featureOffset, ticksPaint);

      var featureLabelFontHeight = featuresTextStyle.fontSize;

      //Änderungen Justin: Anfang
      var featureLabelFontWidth = featuresTextStyle.fontSize / 2; // Änderung von -5 auf /2. Absolute Zahlen führen zu Problemen wenn Fontsize geändert wird. Autor anschreiben?
      var labelYOffset;
      if (index == 0) {
        labelYOffset = labelYOffset = -featureLabelFontHeight - 5; // Das -2 hebt das erste Item ein wenig vom Rand des äußersten Rings ab.
      } else if (yAngle < 0) {
        labelYOffset = -featureLabelFontHeight;
      } else {
        labelYOffset = 0;
      }
      var labelXOffset;

      // Für zentriert: labelXOffset = (-featureLabelFontWidth * feature.length) / 2;
      // Für linksbündig: labelXOffset = -featureLabelFontWidth * feature.length;
      // Für rechtsbündig:labelXOffset = 0;
      // Angle < 0 => links von der Mitte des charts
      if (index == 0) {
        // Das zentriert das erste/oberste Item
        labelXOffset = (-featureLabelFontWidth * feature.length) / 2; //zentriert
      } else if (xAngle < 0) {
        labelXOffset = -featureLabelFontWidth * feature.length + 5; // macht linksbündig, könnte mit +1/-1 noch manuell verschoben werden
      } else {
        labelXOffset = 10; // macht rechtsbündig, könnte mit +1/-1 noch manuell verschoben werden
      }

      TextPainter(
        text: TextSpan(text: feature, style: featuresTextStyle),
        // textAlign: TextAlign.center, // War unnötig
        // Änderungen Justin: Ende
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(canvas, Offset(featureOffset.dx + labelXOffset, featureOffset.dy + labelYOffset));
    });

    // Painting each graph
    data.asMap().forEach((index, graph) {
      var graphPaint = Paint()
        ..color = graphColors[index % graphColors.length].withOpacity(0.3)
        ..style = PaintingStyle.fill;

      var graphOutlinePaint = Paint()
        ..color = graphColors[index % graphColors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..isAntiAlias = true;

      // Start the graph on the initial point
      var scaledPoint = scale * graph[0] * fraction;
      var path = Path();

      if (reverseAxis) {
        path.moveTo(centerX, centerY - (radius * fraction - scaledPoint));
      } else {
        path.moveTo(centerX, centerY - scaledPoint);
      }

      graph.asMap().forEach((index, point) {
        if (index == 0) return;

        var xAngle = cos(angle * index - pi / 2);
        var yAngle = sin(angle * index - pi / 2);
        var scaledPoint = scale * point * fraction;

        if (reverseAxis) {
          path.lineTo(centerX + (radius * fraction - scaledPoint) * xAngle, centerY + (radius * fraction - scaledPoint) * yAngle);
        } else {
          path.lineTo(centerX + scaledPoint * xAngle, centerY + scaledPoint * yAngle);
        }
      });

      path.close();
      canvas.drawPath(path, graphPaint);
      canvas.drawPath(path, graphOutlinePaint);
    });
  }

  @override
  bool shouldRepaint(PolarChartPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
