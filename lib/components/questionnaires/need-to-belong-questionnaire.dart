import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class NeedToBelongQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "need_to_belong";

  @override
  String introduction = "Wie sehr stimmen Sie der folgenden Aussage zu?";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "ntb_1",
      text: "Ich habe ein starkes Bedürfnis dazuzugehören.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Stimmt nicht", value: 1),
        AnswerOption(label: "Stimmt kaum", value: 2),
        AnswerOption(label: "Stimmt eher", value: 3),
        AnswerOption(label: "Stimmt genau", value: 4),
      ],
    ),
  ];
}
