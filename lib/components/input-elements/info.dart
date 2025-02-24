import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';

import 'input-element-template.dart';

class Info extends InputElementTemplate {
  final Key key;
  final _MyInfoState state = _MyInfoState();
  final QuestionnaireAnswer answer;

  Info({this.key, this.answer});

  QuestionnaireAnswer getValue() {
    return state.value;
  }

  @override
  _MyInfoState createState() => state;
}

class _MyInfoState extends InputElementTemplateState<Info> {
  QuestionnaireAnswer value;

  @override
  void initState() {
    super.initState();
    this.initAnswerStructure();
  }

  @override
  void initAnswerStructure() {
    if (widget.answer.answerValues == null) {
      widget.answer.answerValues = {};
      widget.answer.complete = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
