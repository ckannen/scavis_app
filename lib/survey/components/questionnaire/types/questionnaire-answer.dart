import 'dart:convert';

class QuestionnaireAnswer {
  String questionId;
  String _dt;
  bool complete = false;
  dynamic _answerValues;

  dynamic get answerValues {
    return _answerValues;
  }
  set answerValues(dynamic answerValues) {
    _dt = DateTime.now().toIso8601String();
    _answerValues = answerValues;
  }

  String get dt {
    return _dt;
  }

  QuestionnaireAnswer({this.questionId});

  @override
  String toString() {
    dynamic answer;
    try {
      answer = jsonEncode(answerValues);
    } catch (e) {
      print("could not access data");
    }
    
    return "QuestionnaireAnswer(questionId: $questionId, dt: $dt, complete: $complete, answer: $answer)";
  }

  toJson() {
    dynamic json = {
      "questionId": questionId,
      "dt": dt,
      "complete": complete,
      "answerValues": answerValues,
    };
    return json;
  }

  static QuestionnaireAnswer fromJson(dynamic json) {
    if (json == null) return null;
    QuestionnaireAnswer answer = QuestionnaireAnswer(questionId: json["questionId"]);
    answer._dt = json["dt"];
    answer.complete = json["complete"];
    answer.answerValues = json["answerValues"];
    return answer;
  }
}