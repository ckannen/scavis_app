import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class Mhi5Questionnaire extends QuestionnaireTemplate {
  @override
  String id = "9_CB_MHI-5";

  @override
  String introduction = "";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "mhi_1", text: "Wie häufig im letzten Monat waren Sie sehr nervös?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 1),
      AnswerOption(label: "Selten", value: 2),
      AnswerOption(label: "Manchmal", value: 3),
      AnswerOption(label: "Oft", value: 4),
      AnswerOption(label: "Immer", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mhi_2", text: "Wie häufig im letzten Monat haben Sie sich ruhig und gelassen gefühlt?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 1),
      AnswerOption(label: "Selten", value: 2),
      AnswerOption(label: "Manchmal", value: 3),
      AnswerOption(label: "Oft", value: 4),
      AnswerOption(label: "Immer", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mhi_3", text: "Wie häufig im letzten Monat haben Sie sich niedergeschlagen und traurig gefühlt?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 1),
      AnswerOption(label: "Selten", value: 2),
      AnswerOption(label: "Manchmal", value: 3),
      AnswerOption(label: "Oft", value: 4),
      AnswerOption(label: "Immer", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mhi_4", text: "Wie häufig im letzten Monat waren Sie sehr glücklich?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 1),
      AnswerOption(label: "Selten", value: 2),
      AnswerOption(label: "Manchmal", value: 3),
      AnswerOption(label: "Oft", value: 4),
      AnswerOption(label: "Immer", value: 5),
    ]),
    QuestionnaireQuestion(
        questionId: "mhi_5",
        text: "Wie häufig im letzten Monat haben Sie sich so niedergeschlagen gefühlt, dass Sie nichts aufheitern konnte?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 1),
          AnswerOption(label: "Selten", value: 2),
          AnswerOption(label: "Manchmal", value: 3),
          AnswerOption(label: "Oft", value: 4),
          AnswerOption(label: "Immer", value: 5),
        ])
  ];
}
