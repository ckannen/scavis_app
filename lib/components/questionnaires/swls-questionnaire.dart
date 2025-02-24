import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class SwlsQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "SWLS_Satisfaction_With_Life_Scale";

  @override
  String introduction = "Bitte schätzen Sie ein, wie sehr die folgenden Aussagen auf Sie zutreffen.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "swls_1", text: "In den meisten Dingen ist mein Leben nahezu ideal.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Trifft überhaupt nicht zu", value: 1),
      AnswerOption(label: "Trifft eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Trifft eher zu", value: 4),
      AnswerOption(label: "Trifft sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "swls_2", text: "Meine Lebensbedingungen sind hervorragend.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Trifft überhaupt nicht zu", value: 1),
      AnswerOption(label: "Trifft eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Trifft eher zu", value: 4),
      AnswerOption(label: "Trifft sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "swls_3", text: "Ich bin zufrieden mit meinem Leben.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Trifft überhaupt nicht zu", value: 1),
      AnswerOption(label: "Trifft eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Trifft eher zu", value: 4),
      AnswerOption(label: "Trifft sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "swls_4", text: "Die wichtigen Dinge, die ich im Leben will, habe ich weitgehend erreicht.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Trifft überhaupt nicht zu", value: 1),
      AnswerOption(label: "Trifft eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Trifft eher zu", value: 4),
      AnswerOption(label: "Trifft sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "swls_5", text: "Wenn ich mein Leben noch einmal leben könnte, würde ich kaum etwas anders machen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Trifft überhaupt nicht zu", value: 1),
      AnswerOption(label: "Trifft eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Trifft eher zu", value: 4),
      AnswerOption(label: "Trifft sehr zu", value: 5),
    ])
  ];
}