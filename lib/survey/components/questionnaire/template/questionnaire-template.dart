import 'package:flutter/material.dart';
import 'package:scavis/components/input-elements/distance-in-square.dart';
import 'package:scavis/components/input-elements/info.dart';
import 'package:scavis/components/input-elements/input-element-template.dart';
import 'package:scavis/components/input-elements/multi-slider.dart';
import 'package:scavis/components/input-elements/dropdown.dart';
import 'package:scavis/components/input-elements/multilist.dart';
import 'package:scavis/components/input-elements/number-picker.dart';
import 'package:scavis/components/input-elements/number-slider.dart';
import 'package:scavis/components/input-elements/radiogroup.dart';
import 'package:scavis/components/input-elements/selection-slider.dart';
import 'package:scavis/components/input-elements/text.dart';
import 'package:scavis/survey/components/template/survey-content-template.dart';
import '../types/questionnaire-answer.dart';
import '../types/questionnaire-question.dart';

import '../types/questionnaire-answer-state.dart';

class QuestionnaireTemplate extends SurveyContentTemplate {
  @override
  String id = "";
  String introduction = "";

  List<QuestionnaireQuestion> questions = [];
  List<QuestionnaireAnswer> answers;
  int totalQuestionCount = 0;
  Function(int index, QuestionnaireAnswer answer, bool keepState) callback;

  InputElementTemplate inputElement;
  List<UniqueKey> inputElementKeys = [];

  QuestionnaireTemplate({this.callback}) {
    this.answers = this.createAnswerList();
    this.answers.forEach((element) {
      inputElementKeys.add(UniqueKey());
    });
  }

  createAnswerList() {
    List<QuestionnaireAnswer> answers = [];
    // create an answer entry for each question
    this.totalQuestionCount = this.questions.length;
    for (int i = 0; i < questions.length; i++) {
      answers.add(QuestionnaireAnswer(questionId: this.questions[i].questionId));
    }
    return answers;
  }

  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    return false;
  }

  QuestionnaireAnswer getAnswerById(List<QuestionnaireAnswer> answers, String questionId) {
    for (int i = 0; i < answers.length; i++) {
      if (answers[i].questionId == questionId) {
        return answers[i];
      }
    }
    return null;
  }

  Widget createQuestionTextWidget(int index) {
    Widget widget = Container();
    if (index >= 0) {
      widget = Container(
        width: double.infinity,
        child: Text(
          this.questions[index].text,
          style: TextStyle(fontSize: 20),
        ),
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      );
    }
    return widget;
  }

  List<Widget> createItemsForIndex(int index) {
    List<Widget> items = [];
    if (answers == null) {
      return items;
    }

    inputElement = null;

    // all elements are represented by a slider with the same answer scale
    if (index >= 0) {
      // add question text
      items.add(createQuestionTextWidget(index));

      if (this.questions[index].type == AnswerFieldType.TEXT) {
        inputElement = MyText(
          key: inputElementKeys[index],
          answer: answers[index],
          textType: "text",
          validation: this.questions[index].options["validation"],
        );
      }
      if (this.questions[index].type == AnswerFieldType.SELECTION_SLIDER) {
        inputElement = SelectionSlider(
          key: inputElementKeys[index],
          answer: answers[index],
          answerOptions: this.questions[index].answerOptions,
          imageSrcs: this.questions[index].options != null && this.questions[index].options['images'] != null ? this.questions[index].options['images'] : null,
          defaultImageSrc: this.questions[index].options != null && this.questions[index].options['defaultImage'] != null ? this.questions[index].options['defaultImage'] : null,
        );
      }
      if (this.questions[index].type == AnswerFieldType.MULTI_SLIDER) {
        inputElement = MultiSlider(
          key: inputElementKeys[index],
          answer: answers[index],
          masterSlider: {
            "showMasterSlider": this.questions[index].options["showMasterSlider"],
            "masterSliderText": "Dies ist der Master Slider Text",
            "sliderMin": this.questions[index].options["min"],
            "sliderMax": this.questions[index].options["max"],
            "sliderDivisions": this.questions[index].options["divisions"],
            "currentMasterSliderValue": 100,
          },
          subSlider: List.generate(this.questions[index].options["answerOptions"].length, (subSliderIndex) {
            return {
              "sliderText": this.questions[index].options["answerOptions"][subSliderIndex],
              "currentSliderValue": 0.0,
            };
          }),
        );
      }
      if (this.questions[index].type == AnswerFieldType.MULTILIST) {
        inputElement = Multilist(
          key: inputElementKeys[index],
          answer: answers[index],
          answerOptions: this.questions[index].answerOptions,
        );
      }
      if (this.questions[index].type == AnswerFieldType.RADIOGROUP) {
        inputElement = Radiogroup(
          key: inputElementKeys[index],
          answer: answers[index],
          answerOptions: this.questions[index].answerOptions,
          imageSrcs: this.questions[index].options != null && this.questions[index].options['radioImages'] != null ? this.questions[index].options['radioImages'] : null,
        );
      }
      if (this.questions[index].type == AnswerFieldType.DROPDOWN) {
        inputElement = Dropdown(
          key: inputElementKeys[index],
          answer: answers[index],
          answerOptions: this.questions[index].answerOptions,
        );
      }
      if (this.questions[index].type == AnswerFieldType.NUMBER_SLIDER) {
        inputElement = NumberSlider(
          key: inputElementKeys[index],
          answer: answers[index],
          numberType: this.questions[index].options["numberType"] ?? NumberSliderNumberType.INT,
          min: this.questions[index].options["min"],
          max: this.questions[index].options["max"],
          divisions: this.questions[index].options["divisions"],
          trailing: this.questions[index].options["trailing"],
        );
      }
      if (this.questions[index].type == AnswerFieldType.NUMBER_PICKER) {
        inputElement = NumberPicker(
          key: inputElementKeys[index],
          answer: answers[index],
          min: this.questions[index].options["min"],
          max: this.questions[index].options["max"],
          step: this.questions[index].options["step"],
          trailing: this.questions[index].options["trailing"],
          messageAsFirstElement: this.questions[index].options["messageAsFirstElement"],
        );
      }
      if (this.questions[index].type == AnswerFieldType.DISTANCE_IN_SQUARE) {
        inputElement = DistanceInSquare(
          key: inputElementKeys[index],
          answer: answers[index],
        );
      }
      if (this.questions[index].type == AnswerFieldType.INFO) {
        inputElement = Info(
          key: inputElementKeys[index],
          answer: answers[index],
        );
      }
    }

    if (inputElement != null) items.add(inputElement);

    return items;
  }

  // evaluates the answer for the current question(s)
  // this is called by the parent widget when the next button is pressed
  // at this time, saveAnswer() was already called and the answer was already saved to the parent
  // then the answer is passed back here and evaluated how it is needed for this particular questionnaire
  QuestionnaireAnswerState evaluateAnswer(int itemIndex) {
    if (itemIndex == -1) {
      return QuestionnaireAnswerState(type: QuestionnaireAnswerStateType.QUESTIONNAIRE_STARTED, newItemIndex: 0);
    } else {
      if (!answers[itemIndex].complete) {
        return QuestionnaireAnswerState(type: QuestionnaireAnswerStateType.ANSWER_MISSING, newItemIndex: itemIndex);
      } else {
        if (itemIndex + 1 < this.questions.length) {
          return QuestionnaireAnswerState(type: QuestionnaireAnswerStateType.ANSWER_COMPLETE, newItemIndex: itemIndex + 1);
        } else {
          return QuestionnaireAnswerState(type: QuestionnaireAnswerStateType.QUESTIONNAIRE_FINISHED, newItemIndex: itemIndex + 1);
        }
      }
    }
  }
}
