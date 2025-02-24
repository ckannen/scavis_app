import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/theme/my-theme.dart';

import 'input-element-template.dart';

class Dropdown extends InputElementTemplate {
  final Key key;
  final _DropdownState state = _DropdownState();

  final List<AnswerOption> answerOptions = [];
  final QuestionnaireAnswer answer;

  final bool displayError;

  Dropdown({this.key, List<dynamic> answerOptions, this.displayError = false, this.answer}) {
    // convert answer options
    for (int i = 0; i < answerOptions.length; i++) {
      this.answerOptions.add(AnswerOption(label: answerOptions[i].label, index: i, value: answerOptions[i].value, isGroupTitle: answerOptions[i].isGroupTitle));
    }
  }

  @override
  _DropdownState createState() => state;
}

class _DropdownState extends InputElementTemplateState<Dropdown> {

  @override
  void initState() {
    super.initState();
    this.initAnswerStructure();
  }

  @override
  void initAnswerStructure() {
    if (widget.answer.answerValues == null) {
      widget.answer.answerValues = {"index": -1, "label": null, "value": ""};
    }
  }

  void onValueChange({int index}) {
    if (mounted) {
      setState(() {
        widget.answer.answerValues = {"index": index, "label": widget.answerOptions[index].label, "value": widget.answerOptions[index].value};
        widget.answer.complete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(
          widget.answer.answerValues["index"] == -1 ? "Bitte auswählen" : widget.answerOptions[widget.answer.answerValues["index"]].label,
          style: TextStyle(color: widget.answer.answerValues["index"] == -1 ? MyTheme.textColor : MyTheme.col2),
        ),
        //dropdownColor: MyTheme.bgLightColor,
        dropdownColor: Colors.grey.shade100,
        iconEnabledColor: MyTheme.textColor,
        items: List.generate(widget.answerOptions.length, (index) {
          return new DropdownMenuItem<String>(
            value: widget.answerOptions[index].label,
            child: new Text(
              widget.answerOptions[index].label,
              style: TextStyle(color: MyTheme.textColor),
            ),
          );
        }),
        onChanged: (value) {
          widget.answerOptions.forEach((element) {
            if (element.label == value) {
              onValueChange(index: element.index);
            }
          });
        },
      ),
    );
  }
}
