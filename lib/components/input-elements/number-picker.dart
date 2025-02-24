import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/theme/my-theme.dart';
import 'package:numberpicker/numberpicker.dart' as NumberPickerInput;

import 'input-element-template.dart';

class NumberPicker extends InputElementTemplate {
  final Key key;
  final _NumberNumberPickerState state = _NumberNumberPickerState();

  final QuestionnaireAnswer answer;

  final int min;
  final int max;
  final int step;
  final String trailing;
  final bool messageAsFirstElement;

  final bool displayError;

  NumberPicker({this.key, this.min = 0, this.max = 100, this.step, this.trailing, this.displayError = false, this.answer, this.messageAsFirstElement = false});

  @override
  _NumberNumberPickerState createState() => state;
}

class _NumberNumberPickerState extends InputElementTemplateState<NumberPicker> {
  @override
  void initState() {
    super.initState();
    this.initAnswerStructure();
  }

  @override
  void initAnswerStructure() {
    if (widget.answer.answerValues == null) {
      widget.answer.answerValues = {"value": null};
    }
  }

  void onValueChange({int pickerValue}) {
    if (mounted) {
      setState(() {
        widget.answer.answerValues = {"value": pickerValue};
        if (pickerValue == null) {
          widget.answer.complete = false;
        } else {
          widget.answer.complete = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int minValue = widget.min == null ? 0 : widget.min;
    int maxValue = widget.max == null ? 100 : widget.max;
    if (widget.messageAsFirstElement) minValue -= 1;

    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: NumberPickerInput.NumberPicker(
                  value: widget.answer.answerValues["value"] == null ? minValue : widget.answer.answerValues["value"],
                  textMapper: (String inputString) {
                    if (!widget.messageAsFirstElement) {
                      return inputString;
                    } else {
                      if (inputString == minValue.toString()) {
                        return "...";
                      } else {
                        return inputString;
                      }
                    }
                  },
                  minValue: minValue,
                  maxValue: maxValue,
                  step: widget.step == null ? 1 : widget.step,
                  onChanged: (int value) => setState(() {
                    int _value = value;
                    if (widget.messageAsFirstElement && value == minValue) {
                      _value = null;
                    }
                    onValueChange(pickerValue: _value);
                  }),
                ),
              ),
              Container(
                  child: Text(
                widget.trailing == null ? "" : widget.trailing,
                style: TextStyle(fontSize: 20, color: widget.answer.answerValues["value"] == null ? MyTheme.TEXT_COLOR : MyTheme.col2),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
