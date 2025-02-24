import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class LonelinessScaleQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "loneliness_scale";

  @override
  String introduction = "Bitte beantworten Sie, wie sehr die folgenden Aussagen auf Sie zutreffen.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "loneliness_scale_1",
      text: "Mir fehlen soziale Kontakte.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Trifft gar nicht zu", value: 1),
        AnswerOption(label: "Trifft nicht zu", value: 2),
        AnswerOption(label: "Neutral", value: 3),
        AnswerOption(label: "Trifft zu", value: 4),
        AnswerOption(label: "Trifft sehr zu", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "loneliness_scale_2",
      text: "Ich fühle mich außen vorgelassen.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Trifft gar nicht zu", value: 1),
        AnswerOption(label: "Trifft nicht zu", value: 2),
        AnswerOption(label: "Neutral", value: 3),
        AnswerOption(label: "Trifft zu", value: 4),
        AnswerOption(label: "Trifft sehr zu", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "loneliness_scale_3",
      text: "Ich fühle mich von anderen isoliert.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Trifft gar nicht zu", value: 1),
        AnswerOption(label: "Trifft nicht zu", value: 2),
        AnswerOption(label: "Neutral", value: 3),
        AnswerOption(label: "Trifft zu", value: 4),
        AnswerOption(label: "Trifft sehr zu", value: 5),
      ],
    ),
  ];
}
