import 'package:flutter/material.dart';
import 'package:scavis/theme/my-theme.dart';

class SurveyIntroduction extends StatelessWidget {
  final String text;
  final bool isFirstQuestionnairePage;
  final introductionVisibleWhileAnswering;

  SurveyIntroduction(this.text, this.isFirstQuestionnairePage, this.introductionVisibleWhileAnswering);

  @override
  Widget build(BuildContext context) {
    return isFirstQuestionnairePage || introductionVisibleWhileAnswering
        ? Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: AnimatedDefaultTextStyle(
              child: Text(this.text),
              duration: Duration(milliseconds: 250),
              style: isFirstQuestionnairePage ? TextStyle(fontSize: 20, color: MyTheme.textColor) : TextStyle(fontSize: 14, color: MyTheme.TEXT_COLOR_LIGHT,),
            ),
            padding: EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade200, width: 1),
                bottom: BorderSide(color: isFirstQuestionnairePage ? Colors.transparent : Colors.grey.shade200, width: 1),
              ),
            ),
            margin: EdgeInsets.only(left: 15, right: 15),
          )
        : Container();
  }
}
