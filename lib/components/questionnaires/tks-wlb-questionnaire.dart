import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class TksWlbQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "tks_wlb";

  @override
  String introduction = "In den folgenden Fragen geht es um Ihre Work-Life-Balance.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "wlb_1",
      text: "Ich bin zufrieden mit meiner Balance zwischen Arbeit und Privatleben.",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [
        AnswerOption(label: "(1) Stimmt gar nicht", value: 1),
        AnswerOption(label: "(2)", value: 2),
        AnswerOption(label: "(3)", value: 3),
        AnswerOption(label: "(4)", value: 4),
        AnswerOption(label: "(5)", value: 5),
        AnswerOption(label: "(6) Stimmt genau", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "wlb_2",
      text: "Es fällt mir schwer, Berufs- und Privatleben miteinander zu vereinbaren.",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [
        AnswerOption(label: "(1) Stimmt gar nicht", value: 1),
        AnswerOption(label: "(2)", value: 2),
        AnswerOption(label: "(3)", value: 3),
        AnswerOption(label: "(4)", value: 4),
        AnswerOption(label: "(5)", value: 5),
        AnswerOption(label: "(6) Stimmt genau", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "wlb_3",
      text: "Ich kann die Anforderungen aus meinem Privatleben und die Anforderungen aus meinem Berufsleben gleichermaßen gut erfüllen.",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [
        AnswerOption(label: "(1) Stimmt gar nicht", value: 1),
        AnswerOption(label: "(2)", value: 2),
        AnswerOption(label: "(3)", value: 3),
        AnswerOption(label: "(4)", value: 4),
        AnswerOption(label: "(5)", value: 5),
        AnswerOption(label: "(6) Stimmt genau", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "wlb_4",
      text: "Es gelingt mir, einen guten Ausgleich zwischen belastenden und erholsamen Tätigkeiten in meinem Leben zu erreichen.",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [
        AnswerOption(label: "(1) Stimmt gar nicht", value: 1),
        AnswerOption(label: "(2)", value: 2),
        AnswerOption(label: "(3)", value: 3),
        AnswerOption(label: "(4)", value: 4),
        AnswerOption(label: "(5)", value: 5),
        AnswerOption(label: "(6) Stimmt genau", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "wlb_5",
      text: "Ich bin damit zufrieden, wie meine Prioritäten in Bezug auf den Beruf und das Privatleben verteilt sind.",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [
        AnswerOption(label: "(1) Stimmt gar nicht", value: 1),
        AnswerOption(label: "(2)", value: 2),
        AnswerOption(label: "(3)", value: 3),
        AnswerOption(label: "(4)", value: 4),
        AnswerOption(label: "(5)", value: 5),
        AnswerOption(label: "(6) Stimmt genau", value: 6),
      ],
    ),
  ];
}
