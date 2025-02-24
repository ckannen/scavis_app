import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/theme/my-theme.dart';

import 'input-element-template.dart';
import 'slider-tooltip.dart';

enum NumberSliderNumberType { INT, DOUBLE }

class NumberSlider extends InputElementTemplate {
  final Key key;
  final _NumberSliderState state = _NumberSliderState();

  final QuestionnaireAnswer answer;

  final num min;
  final num max;
  final num divisions;
  final String trailing;
  final NumberSliderNumberType numberType;

  final bool displayError;

  NumberSlider({this.key, this.numberType = NumberSliderNumberType.INT, this.min = 0, this.max = 100, this.divisions, this.trailing, this.displayError = false, this.answer});

  @override
  _NumberSliderState createState() => state;
}

class _NumberSliderState extends InputElementTemplateState<NumberSlider> {
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

  void onValueChange({num sliderValue, bool fireCallback = true}) {
    if (mounted) {
      setState(() {
        widget.answer.answerValues = {"value": sliderValue};
        widget.answer.complete = true;
      });
    }
  }

  String labelFn() {
    num _sliderValue = widget.answer.answerValues["value"];
    String trailing = "";
    if (widget.trailing != null) trailing = widget.trailing;
    if (_sliderValue == null) {
      return widget.min.toString() + trailing;
    }
    if (widget.numberType == NumberSliderNumberType.INT) {
      return _sliderValue.toInt().toString() + trailing;
    } else {
      return _sliderValue.toDouble().toString().replaceAll(".", ",") + trailing;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Container(child: Text(widget.answer.answerValues["value"] == null ? "Zum Auswählen Slider bewegen." : "")),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: SliderTheme(
              data: SliderThemeData(
                showValueIndicator: ShowValueIndicator.never,
                thumbShape: widget.answer.answerValues["value"] == null ? null : SliderTooltip(),
              ),
              child: Slider(
                onChangeStart: (num _sliderValue) {
                  // this code also triggers the answer to be set, if the slider was not moved at the beginning and the user only taps the handle to select the first possible answer
                  onValueChange(sliderValue: _sliderValue, fireCallback: false);
                },
                onChanged: (num _sliderValue) {
                  // this code triggers when then slider handle is dragged or when the slider is tapped on
                  onValueChange(sliderValue: _sliderValue, fireCallback: false);
                },
                onChangeEnd: (num _sliderValue) {
                  // this code triggers when then slider handle is released
                  onValueChange(sliderValue: _sliderValue, fireCallback: true);
                },
                value: widget.answer.answerValues["value"] == null ? widget.min.toDouble() : widget.answer.answerValues["value"].toDouble(),
                min: widget.min.toDouble(),
                max: widget.max.toDouble(),
                divisions: widget.divisions != null ? widget.divisions : (widget.max - widget.min).round(),
                label: labelFn(),
                inactiveColor: widget.answer.answerValues["value"] == null ? Colors.grey.shade300 : Colors.grey,
                activeColor: widget.answer.answerValues["value"] == null ? Colors.transparent : MyTheme.col2,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 22, right: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.numberType == NumberSliderNumberType.INT ? widget.min.toInt().toString() : widget.min.toDouble().toString().replaceAll(".", ","),
                  style: TextStyle(color: Colors.grey.shade300),
                ),
                Text(
                  widget.numberType == NumberSliderNumberType.INT ? widget.max.toInt().toString() : widget.max.toDouble().toString().replaceAll(".", ","),
                  style: TextStyle(color: Colors.grey.shade300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
