import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';

import 'input-element-template.dart';

class DistanceInSquare extends InputElementTemplate {
  final Key key;
  final _MyInfoState state = _MyInfoState();
  final QuestionnaireAnswer answer;

  DistanceInSquare({this.key, this.answer});

  @override
  _MyInfoState createState() => state;
}

class _MyInfoState extends InputElementTemplateState<DistanceInSquare> {

  @override
  void initState() {
    super.initState();
    this.initAnswerStructure();
  }

  @override
  void initAnswerStructure() {
    if (widget.answer.answerValues == null) {
      widget.answer.answerValues = {"x": -1, "y": -1, "squareSize": -1};
    }
  }

  void onValueChange({double x, double y, double squareSize}) {
    if (mounted) {
      setState(() {
        widget.answer.answerValues = {"x": x, "y": y, "squareSize": squareSize};
        widget.answer.complete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);

    double smallerSide = Math.min(mqd.size.width, mqd.size.height);
    double squareEdgeLength = smallerSide * 0.7;

    double boxSize = squareEdgeLength / 6;
    double initialBoxLeft = squareEdgeLength * 0.8;
    double initialBoxTop = squareEdgeLength * 0.8;

    double customBoxSize = boxSize;
    double customBoxLeft = 0;
    double customBoxTop = 0;

    if (widget.answer.answerValues["x"] != -1) {
      customBoxLeft = widget.answer.answerValues["x"] - boxSize / 2;
      customBoxTop = widget.answer.answerValues["y"] - boxSize / 2;
    } else {
      customBoxSize = 0;
    }
    if (customBoxLeft < 0) customBoxLeft = 0;
    if (customBoxLeft + boxSize > squareEdgeLength) customBoxLeft = squareEdgeLength - boxSize;
    if (customBoxTop < 0) customBoxTop = 0;
    if (customBoxTop + boxSize > squareEdgeLength) customBoxTop = squareEdgeLength - boxSize;

    return Container(
      margin: EdgeInsets.only(top: 20),
      width: squareEdgeLength,
      height: squareEdgeLength,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: GestureDetector(
        child: Stack(
          children: [
            Container(color: Colors.transparent),
            Positioned(
              left: initialBoxLeft,
              top: initialBoxTop,
              child: Container(
                alignment: Alignment.center,
                width: boxSize,
                height: boxSize,
                child: Text("Ich"),
                decoration: BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
              ),
            ),
            Positioned(
              left: customBoxLeft,
              top: customBoxTop,
              child: Container(
                alignment: Alignment.center,
                width: customBoxSize,
                height: customBoxSize,
                child: Icon(
                  FontAwesomeIcons.times,
                  size: customBoxSize,
                ),
              ),
            ),
          ],
        ),
        onTapDown: (TapDownDetails details) {
          onValueChange(x: details.localPosition.dx, y: details.localPosition.dy, squareSize: squareEdgeLength);
        },
      ),
    );
  }
}
