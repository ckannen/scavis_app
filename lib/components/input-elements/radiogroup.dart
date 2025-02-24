import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/theme/my-theme.dart';

import 'input-element-template.dart';

class Radiogroup extends InputElementTemplate {
  final Key key;
  final _RadiogroupState state = _RadiogroupState();
  final List<AnswerOption> answerOptions = [];
  final List<String> imageSrcs = [];
  final QuestionnaireAnswer answer;
  final bool displayError;

  Radiogroup({this.key, List<dynamic> answerOptions, this.displayError = false, this.answer, List<String> imageSrcs}) {
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
  _RadiogroupState createState() => state;
}

class _RadiogroupState extends InputElementTemplateState<Radiogroup> {
  @override
  void initState() {
    super.initState();
    initAnswerStructure();
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
    MediaQueryData mqd = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: List.generate(widget.answerOptions.length, (radioButtonIndex) {
          return Container(
            margin: EdgeInsets.only(right: 20, bottom: 10),
            child: widget.answerOptions[radioButtonIndex].isGroupTitle
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Text(
                      widget.answerOptions[radioButtonIndex].label,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  )
                : Row(
                    children: [
                      Container(width: 10),
                      Transform.scale(
                        scale: 1.8,
                        child: Radio(
                            groupValue: radioButtonIndex,
                            value: widget.answer.answerValues["index"] == -1 ? null : widget.answer.answerValues["index"],
                            activeColor: MyTheme.col2,
                            onChanged: (_) {
                              onValueChange(index: radioButtonIndex);
                            }),
                      ),
                      // add image if one is provided
                      widget.imageSrcs.length > radioButtonIndex
                          ? InkWell(
                              child: Container(
                                width: 50,
                                child: Image.asset(widget.imageSrcs[radioButtonIndex]),
                              ),
                              onTap: () {
                                onValueChange(index: radioButtonIndex);
                              },
                            )
                          : Container(),
                      InkWell(
                        child: Container(
                          width: mqd.size.width - 100 - (widget.imageSrcs.length > radioButtonIndex ? 50 : 0),
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            widget.answerOptions[radioButtonIndex].label,
                            style: TextStyle(color: radioButtonIndex == widget.answer.answerValues["index"] ? MyTheme.col2 : MyTheme.textColor, fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          onValueChange(index: radioButtonIndex);
                        },
                      ),
                    ],
                  ),
          );
        }),
      ),
    );
  }
}
