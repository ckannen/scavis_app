import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class ReadinessSelfEfficacyQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "readiness_self_efficacy";

  @override
  String introduction = "";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "rr_1",
      text: "Wie wichtig wäre es Ihnen auf einer Skala von 1 bis 10, Ihr Internetnutzungsverhalten zu ändern?",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [
        AnswerOption(label: "Überhaupt nicht wichtig (1)", value: 1),
        AnswerOption(label: "(2)", value: 2),
        AnswerOption(label: "(3)", value: 3),
        AnswerOption(label: "(4)", value: 4),
        AnswerOption(label: "(5)", value: 5),
        AnswerOption(label: "(6)", value: 6),
        AnswerOption(label: "(7)", value: 7),
        AnswerOption(label: "(8)", value: 8),
        AnswerOption(label: "(9)", value: 9),
        AnswerOption(label: "Sehr wichtig (10)", value: 10),
        
      ],
    ),
    QuestionnaireQuestion(
      questionId: "rr_2",
      text: "Wie sicher sind Sie auf einer Skala von 1 bis 10, Ihr Internetnutzungsverhalten ändern zu können?",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [
        AnswerOption(label: "Überhaupt nicht sicher (1)", value: 1),
        AnswerOption(label: "(2)", value: 2),
        AnswerOption(label: "(3)", value: 3),
        AnswerOption(label: "(4)", value: 4),
        AnswerOption(label: "(5)", value: 5),
        AnswerOption(label: "(6)", value: 6),
        AnswerOption(label: "(7)", value: 7),
        AnswerOption(label: "(8)", value: 8),
        AnswerOption(label: "(9)", value: 9),
        AnswerOption(label: "Sehr sicher (10)", value: 10),
        
      ],
    ),
    QuestionnaireQuestion(
      questionId: "rr_3",
      text: "Welche der folgenden Aussagen beschreibt am besten Ihre derzeitige Einstellung zum Internet?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Über eine Reduzierung meiner Internetnutzung denke ich nicht nach", value: 1),
        AnswerOption(label: "Manchmal denke ich, ich sollte meine Internetnutzung reduzieren", value: 2),
        AnswerOption(label: "Ich habe mich dazu entschieden, meine Internetnutzung zu reduzieren", value: 3),
        AnswerOption(label: "Ich versuche bereits, meine Internetnutzung zu reduzieren", value: 4),
        AnswerOption(label: "Ich habe meine Internetnutzung reduziert", value: 5),
        
      ],
    ),
  ];
}
