import 'package:flutter/material.dart';

class ActionFlow {
  final String initialStateId;
  String currentStateId;
  final List<FlowState> states;

  ActionFlow({this.initialStateId, this.states}) {
    currentStateId = initialStateId;
  }

  // get the current state id
  FlowState getCurrentState() {
    for (int i = 0; i < states.length; i++) {
      if (states[i].id == currentStateId) return states[i];
    }
    return null;
  }
}

class FlowState {
  final String id;

  FlowState({@required this.id});
}

class FlowQuestionState extends FlowState {
  final String id;
  final dynamic content;
  final Widget chart;
  final List<FlowAnswer> answers;

  FlowQuestionState({@required this.id, @required this.content, this.chart, @required this.answers});
}

class FlowDecision extends FlowState {
  final String id;
  final Function decide;

  FlowDecision({@required this.id, @required this.decide});
}

class FlowEndState extends FlowState {
  final String id;
  final dynamic content;
  final Widget chart;
  final String link;
  final bool autoClose;

  FlowEndState({@required this.id, @required this.content, this.chart, this.link, this.autoClose=false});
}

class FlowAnswer {
  final String text;
  final dynamic value;
  final String gotoId;

  FlowAnswer({this.text, this.value, this.gotoId});
}

class FlowAnswerButton extends FlowAnswer {
  final String text;
  final dynamic value;
  final String gotoId;

  FlowAnswerButton({this.text, this.value, this.gotoId});
}




class FlowAnswerText extends FlowAnswer {
  final String id;

  FlowAnswerText({this.id});
}
class FlowAnswerCheckbox extends FlowAnswer {
  final String id;
  final String label;

  FlowAnswerCheckbox({this.id, this.label});
}