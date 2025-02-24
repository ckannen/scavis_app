import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/theme/my-theme.dart';

import 'input-element-template.dart';

class Multilist extends InputElementTemplate {
  final Key key;
  final _MultilistState state = _MultilistState();

  final List<AnswerOption> answerOptions = [];
  final QuestionnaireAnswer answer;

  final bool displayError;

  Multilist({this.key, List<dynamic> answerOptions, this.displayError = false, this.answer}) {
    // convert answer options
    for (int i = 0; i < answerOptions.length; i++) {
      this.answerOptions.add(AnswerOption(label: answerOptions[i].label, index: i, value: answerOptions[i].value, isGroupTitle: answerOptions[i].isGroupTitle));
    }
  }

  @override
  _MultilistState createState() => state;
}

class _MultilistState extends InputElementTemplateState<Multilist> {
  @override
  void initState() {
    super.initState();
    this.initAnswerStructure();
  }

  @override
  void initAnswerStructure() {
    if (widget.answer.answerValues == null) {
      List<dynamic> multilist = [];
      for (int i = 0; i < widget.answerOptions.length; i++) {
        multilist.add({"index": i, "checked": false, "label": widget.answerOptions[i].label, "value": widget.answerOptions[i].value});
      }
      widget.answer.answerValues = {"multilist": multilist};
    }
  }

  void onValueChange({int index, bool checked, bool fireCallback = true}) {
    if (mounted) {
      setState(() {
        widget.answer.answerValues["multilist"][index] = {"index": index, "checked": checked, "label": widget.answerOptions[index].label, "value": widget.answerOptions[index].value};
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
        children: List.generate(widget.answerOptions.length, (index) {
          return Container(
            margin: EdgeInsets.only(right: 20, bottom: 10),
            child: Row(
              children: [
                Container(width: 10),
                Transform.scale(
                  scale: 1.8,
                  child: Checkbox(
                    value: widget.answer.answerValues["multilist"][index]["checked"],
                    activeColor: MyTheme.col2,
                    onChanged: (bool value) {
                      onValueChange(index: index, checked: value);
                    },
                  ),
                ),
                InkWell(
                  child: Container(
                    width: mqd.size.width - 100,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      widget.answerOptions[index].label,
                      //style: TextStyle(color: index == this.selectedIndex ? MyTheme.col2 : MyTheme.textColor, fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    onValueChange(index: index, checked: !widget.answer.answerValues["multilist"][index]["checked"]);
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
