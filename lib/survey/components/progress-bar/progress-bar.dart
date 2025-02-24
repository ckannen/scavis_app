import 'package:flutter/material.dart';
import 'package:scavis/theme/my-theme.dart';

class SurveyProgressBar extends StatelessWidget {
  final double width;
  final double height;
  final int total;
  final int finished;
  final bool hideQuestionCount;

  SurveyProgressBar({this.width=0, this.height=40, this.total=0, this.finished=0, this.hideQuestionCount=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: double.infinity,
      color: MyTheme.col1,
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width / 3,
            child: LinearProgressIndicator(
              value: total > 0 ? finished / total : 0,
              valueColor: AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.white.withOpacity(0.5),
            ),
          ),
          Text(
            hideQuestionCount ? "" : "Frage ${finished + 1} von $total",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}