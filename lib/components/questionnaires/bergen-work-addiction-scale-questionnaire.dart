import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class BergenWorkAddictionScaleQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "bergen_work_addiction_scale";

  @override
  String introduction = "Wie oft im letzten Jahr …";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "bergen_1",
      text: "… haben Sie darüber nachgedacht, wie Sie mehr Zeit für Ihre Arbeit freimachen könnten?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Nie", value: 1),
        AnswerOption(label: "Selten", value: 2),
        AnswerOption(label: "Manchmal", value: 3),
        AnswerOption(label: "Oft", value: 4),
        AnswerOption(label: "Immer", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "bergen_2",
      text: "… haben Sie viel mehr Zeit mit der Arbeit verbracht, als ursprünglich beabsichtigt?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Nie", value: 1),
        AnswerOption(label: "Selten", value: 2),
        AnswerOption(label: "Manchmal", value: 3),
        AnswerOption(label: "Oft", value: 4),
        AnswerOption(label: "Immer", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "bergen_3",
      text: "… haben Sie gearbeitet, um Gefühle von Schuld, Angst, Hilflosigkeit und Depression zu reduzieren?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Nie", value: 1),
        AnswerOption(label: "Selten", value: 2),
        AnswerOption(label: "Manchmal", value: 3),
        AnswerOption(label: "Oft", value: 4),
        AnswerOption(label: "Immer", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "bergen_4",
      text: "… wurden Sie von anderen aufgefordert, Ihre Arbeit zu reduzieren, ohne darauf zu hören?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Nie", value: 1),
        AnswerOption(label: "Selten", value: 2),
        AnswerOption(label: "Manchmal", value: 3),
        AnswerOption(label: "Oft", value: 4),
        AnswerOption(label: "Immer", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "bergen_5",
      text: "… waren Sie gestresst, wenn Sie nicht arbeiten durften?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Nie", value: 1),
        AnswerOption(label: "Selten", value: 2),
        AnswerOption(label: "Manchmal", value: 3),
        AnswerOption(label: "Oft", value: 4),
        AnswerOption(label: "Immer", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "bergen_6",
      text: "… haben Sie Hobbys, Freizeitaktivitäten und Sport aufgrund der Arbeit hinten angestellt?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Nie", value: 1),
        AnswerOption(label: "Selten", value: 2),
        AnswerOption(label: "Manchmal", value: 3),
        AnswerOption(label: "Oft", value: 4),
        AnswerOption(label: "Immer", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "bergen_7",
      text: "… haben Sie so viel gearbeitet, dass es Ihre Gesundheit negativ beeinflusst hat?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Nie", value: 1),
        AnswerOption(label: "Selten", value: 2),
        AnswerOption(label: "Manchmal", value: 3),
        AnswerOption(label: "Oft", value: 4),
        AnswerOption(label: "Immer", value: 5),
      ],
    ),
  ];
}
