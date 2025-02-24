enum QuestionnaireAnswerStateType {
  ANSWER_MISSING,
  ANSWER_COMPLETE,
  QUESTIONNAIRE_STARTED,
  QUESTIONNAIRE_FINISHED,
}

class QuestionnaireAnswerState {
  QuestionnaireAnswerStateType type;
  int newItemIndex;
  
  QuestionnaireAnswerState({this.type, this.newItemIndex});
}