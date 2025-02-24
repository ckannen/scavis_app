import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class PrismInternetQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "prism_internet";

  @override
  String introduction = "Bitte stellen Sie sich vor, dass das folgende Quadrat Ihr Leben darstellt, wie es im Moment ist. Der Kreis unten rechts stellt Ihre Person dar. Bitte tippen Sie auf die Stelle, wo sich in dem Quadrat das Internet befindet. Wenn das Internet in Ihrem Leben sehr wichtig ist, so könnte das Kreuz z.B. näher am Kreis sein, als wenn es eher wenig Bedeutung für Ihre Person hat.\nIn dem zweiten Quadrat machen Sie bitte das Kreuz so, wie Sie es sich wünschen, wie es in einem Jahr sein sollte.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "prism_internet_1",
      text: "Jetzt",
      type: AnswerFieldType.DISTANCE_IN_SQUARE,
    ),
    QuestionnaireQuestion(
      questionId: "prism_internet_2",
      text: "In einem Jahr",
      type: AnswerFieldType.DISTANCE_IN_SQUARE,
    ),
  ];
}
