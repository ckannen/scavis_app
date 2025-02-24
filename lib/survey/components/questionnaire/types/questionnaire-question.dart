enum AnswerFieldType {
  RADIOGROUP,
  DROPDOWN,
  MULTILIST,
  SELECTION_SLIDER,
  MULTI_SLIDER,
  NUMBER_SLIDER,
  NUMBER_PICKER,
  DISTANCE_IN_SQUARE,
  TEXT,
  INFO,
}

class AnswerOption {
  String label;
  int index;
  int value;
  bool isGroupTitle;

  AnswerOption({this.label="", this.index=-1, this.value=-1, this.isGroupTitle=false});
}

class QuestionnaireQuestion {
  String questionId;
  AnswerFieldType type;
  String text;
  List<AnswerOption> answerOptions = [];
  dynamic options = {};
  QuestionnaireQuestion({this.questionId = "", this.text = "", this.type=AnswerFieldType.TEXT, this.answerOptions, this.options});
}