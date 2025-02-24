import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class GesundheitQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "14_CB_Gesundheitszustand";

  @override
  String introduction = "";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "ges_1", text: "Wie würden Sie Ihren Gesundheitszustand im Allgemeinen beschreiben?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Schlecht", value: 1),
      AnswerOption(label: "Weniger gut", value: 2),
      AnswerOption(label: "Gut", value: 3),
      AnswerOption(label: "Sehr gut", value: 4),
      AnswerOption(label: "Ausgezeichnet", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "ges_2", text: "Wie wichtig ist Ihnen Ihre Gesundheit?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Gar nicht wichtig", value: 1),
      AnswerOption(label: "Etwas wichtig", value: 2),
      AnswerOption(label: "Relativ wichtig", value: 3),
      AnswerOption(label: "Sehr wichtig", value: 4),
      AnswerOption(label: "Äußerst wichtig", value: 5),
    ]),
  ];
}
