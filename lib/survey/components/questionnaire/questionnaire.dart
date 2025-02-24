import 'package:flutter/material.dart';
import 'package:scavis/theme/my-theme.dart';
import 'components/headline.dart';
import 'components/introduction.dart';


enum QuestionnaireButton { START, NEXT, FINISH }

class Questionnaire extends StatefulWidget {
  final Key key;
  final String headline;
  final bool bigHeadline;
  final String introduction;
  final bool bigIntroduction;
  final List<Widget> children;
  final QuestionnaireButton button;
  final Function onNext;

  final int currentItemIndex;
  final bool hasErrors;

  Questionnaire({
    this.key,
    this.headline = "",
    this.bigHeadline = false,
    this.introduction = "",
    this.bigIntroduction = false,
    @required this.children,
    this.hasErrors,
    this.currentItemIndex,
    this.button = QuestionnaireButton.NEXT,
    this.onNext,
  });

  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  bool introductionVisibleWhileAnswering = false;
  @override
  void initState() {
    super.initState();
  }

  Widget createWidgets(BuildContext context) {
    // create list of widgets and add the headline and introduction
    List<Widget> widgets = [
      Headline(this.widget.headline, this.widget.bigHeadline, introductionVisibleWhileAnswering, () {
        setState(() {
          introductionVisibleWhileAnswering = !introductionVisibleWhileAnswering;
        });
      }),
      SurveyIntroduction(this.widget.introduction, this.widget.bigIntroduction, introductionVisibleWhileAnswering),
    ];
    widgets.addAll(widget.children);
    // add error message
    if (widget.hasErrors) {
      widgets.add(
        Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          color: Colors.red,
          child: Text(
            "Bitte beantworten Sie die Frage.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    // add button
    widgets.add(
      Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          child: Text(
            this.widget.button == QuestionnaireButton.START
                ? "Loslegen"
                : this.widget.button == QuestionnaireButton.NEXT
                    ? "Weiter"
                    : this.widget.button == QuestionnaireButton.FINISH
                        ? "Fertig"
                        : "undefiniert",
          ),
          style: ElevatedButton.styleFrom(
            primary: 1 == 1 ? MyTheme.col1 : Colors.grey.shade300,
            onPrimary: 1 == 1 ? Colors.white : Colors.black,
            padding: EdgeInsets.all(15),
          ),
          onPressed: () {
            widget.onNext();
          },
        ),
      ),
    );

    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return createWidgets(context);
  }
}
