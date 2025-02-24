import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/theme/my-theme.dart';

import 'input-element-template.dart';
import 'slider-tooltip.dart';

class SelectionSlider extends InputElementTemplate {
  final Key key;
  final _SelectionSliderState state = _SelectionSliderState();

  // either use min and max as range or the answer options
  final List<AnswerOption> answerOptions = [];
  final String defaultImageSrc;
  final List<String> imageSrcs = [];
  final QuestionnaireAnswer answer;

  final bool displayError;

  SelectionSlider({this.key, @required this.answer, List<dynamic> answerOptions, this.displayError = false, List<String> imageSrcs, this.defaultImageSrc}) {
    // convert answer options
    for (int i = 0; i < answerOptions.length; i++) {
      this.answerOptions.add(AnswerOption(label: answerOptions[i].label, index: i, value: answerOptions[i].value, isGroupTitle: answerOptions[i].isGroupTitle));
    }

    // copy image srcs
    if (imageSrcs != null) {
      imageSrcs.forEach((element) {
        this.imageSrcs.add(element);
      });
    }
  }

  @override
  _SelectionSliderState createState() => state;
}

class _SelectionSliderState extends InputElementTemplateState<SelectionSlider> {
  //QuestionnaireAnswer value;

  @override
  void initState() {
    super.initState();
    this.initAnswerStructure();
  }

  @override
  void initAnswerStructure() {
    if (widget.answer.answerValues == null) {
      widget.answer.answerValues = {"index": -1, "sliderPercent": 0.0, "label": null, "value": ""};
    }
  }

  void onValueChange({double sliderPercent}) {
    int index = valueToIndex(sliderPercent);
    if (mounted) {
      setState(() {
        widget.answer.answerValues = {"index": index, "sliderPercent": sliderPercent, "label": widget.answerOptions[index].label, "value": widget.answerOptions[index].value};
        widget.answer.complete = true;
      });
    }
  }

  String labelFn(double _sliderPercent) {
    int answerIndex = valueToIndex(_sliderPercent);
    String label = widget.answerOptions[answerIndex].label;
    label = labelToMultiline(label);
    return label;
  }

  // convert a string to a multiline string with max 32 characters per line, if there is a blank to split the string
  // if a word is longer than 32 characters, it is not split into two lines
  String labelToMultiline(String label) {
    const int MAX_CHARS_PER_LINE = 32;
    List<String> lines = [];
    int pos = -1;
    for (int i=0; i<label.length; i++) {
      if (label.substring(i, i+1) == " " && (pos == -1 || i < MAX_CHARS_PER_LINE)) {
        pos = i;
      }
      if (i > MAX_CHARS_PER_LINE && pos != -1) {
        lines.add(label.substring(0, pos).trim());
        label = label.substring(pos);
        i = 0;
        pos = -1;
      }
    }
    if (label.length > 0) {
      lines.add(label);
    }
    for (int i=0; i<lines.length; i++) {
      lines[i] = lines[i].trim();
    }
    return lines.join("\n");
  }

  int valueToIndex(double _sliderPercent) {
    return (_sliderPercent * (widget.answerOptions.length - 1)).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Container(child: Text(widget.answer.answerValues["index"] == -1 ? "Zum Auswählen Slider bewegen." : "")),
          // show image
          widget.imageSrcs.length == widget.answerOptions.length
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.imageSrcs.length + 1, (imageIndex) {
                    if (imageIndex == widget.imageSrcs.length) {
                      return Container(
                        width: widget.answer.answerValues["index"] == -1 ? 100 : 0,
                        child: Image.asset(widget.defaultImageSrc),
                      );
                    } else {
                      return Container(
                        width: widget.answer.answerValues["index"] == imageIndex ? 100 : 0,
                        child: Image.asset(widget.imageSrcs[imageIndex]),
                      );
                    }
                  }),
                )
              : Container(),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: SliderTheme(
              data: SliderThemeData(
                //showValueIndicator: ShowValueIndicator.never,
                thumbShape: widget.answer.answerValues["index"] == -1 ? null : SliderTooltip(),
              ),
              child: Slider(
                onChangeStart: (double sliderPercent) {
                  // this code also triggers the answer to be set, if the slider was not moved at the beginning and the user only taps the handle to select the first possible answer
                  onValueChange(sliderPercent: sliderPercent);
                },
                onChanged: (double sliderPercent) {
                  // this code triggers when then slider handle is dragged or when the slider is tapped on
                  onValueChange(sliderPercent: sliderPercent);
                },
                onChangeEnd: (double sliderPercent) {
                  // this code triggers when then slider handle is released
                  onValueChange(sliderPercent: sliderPercent);
                },
                value: widget.answer.answerValues["sliderPercent"],
                divisions: widget.answerOptions.length - 1,
                label: labelFn(widget.answer.answerValues["sliderPercent"]),
                inactiveColor: widget.answer.answerValues["index"] == -1 ? Colors.grey.shade300 : Colors.grey,
                activeColor: widget.answer.answerValues["index"] == -1 ? Colors.transparent : MyTheme.col2,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 22, right: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 5,
                  child: Text(
                    widget.answerOptions[0].label,
                    style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Flexible(
                  flex: 5,
                  child: Text(
                    widget.answerOptions[widget.answerOptions.length - 1].label,
                    style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 12),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
