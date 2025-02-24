import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';

import 'input-element-template.dart';

class MyText extends InputElementTemplate {
  final Key key;
  final _MyTextState state = _MyTextState();
  final String textType;
  final String validation;
  final QuestionnaireAnswer answer;
  final bool displayError;

  MyText({this.key, this.textType = "text", this.validation = "text", this.displayError = false, this.answer});

  @override
  _MyTextState createState() => state;
}

class _MyTextState extends InputElementTemplateState<MyText> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.answer.answerValues == null ? "" : widget.answer.answerValues["value"]);
    _controller.addListener(() {
      onValueChange(text: _controller.text);
    });
    this.initAnswerStructure();
  }

  @override
  void initAnswerStructure() {
    if (widget.answer.answerValues == null) {
      widget.answer.answerValues = {"value": ""};
    }
  }

  void onValueChange({String text}) {
    if (mounted) {
      setState(() {
        widget.answer.answerValues = {"value": text};
        if (!isTextValid(text)) {
          widget.answer.complete = false;
        } else {
          widget.answer.complete = true;
        }
      });
    }
  }

  bool isTextValid(String value) {
    if (widget.validation == null) {
      return true;
    }
    if (widget.validation == "text") {
      if (value.length > 0) return true;
    }
    if (widget.validation == "positive-integer") {
      Pattern pattern = r'^[0-9]+$';
      RegExp regex = new RegExp(pattern);
      if (regex.hasMatch(value)) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: TextField(
          controller: _controller,
          keyboardType: widget.textType == "number" ? TextInputType.number : TextInputType.text,
        )

        // positive integer
        );
  }
}
