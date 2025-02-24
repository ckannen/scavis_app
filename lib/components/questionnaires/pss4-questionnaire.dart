import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class Pss4Questionnaire extends QuestionnaireTemplate {
  @override
  String id = "10_CB_pss-4";

  @override
  String introduction = "Stress ist etwas, das uns in vielen Lebensbereichen begegnen kann. Bei den folgenden Fragen geht es darum, wie Sie mit Stress umgehen.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
        questionId: "pss_1",
        text: "Wie oft hatten Sie im letzten Monat das Gefühl, wichtige Dinge in Ihrem Leben nicht beeinflussen zu können?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Niemals", value: 1),
          AnswerOption(label: "Selten", value: 2),
          AnswerOption(label: "Manchmal", value: 3),
          AnswerOption(label: "Oft", value: 4),
          AnswerOption(label: "Sehr oft", value: 5),
        ]),
    QuestionnaireQuestion(
        questionId: "pss_2",
        text: "Wie oft hatten Sie sich im letzten Monat sicher im Umgang mit persönlichen Aufgaben und Problemen gefühlt?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Niemals", value: 1),
          AnswerOption(label: "Selten", value: 2),
          AnswerOption(label: "Manchmal", value: 3),
          AnswerOption(label: "Oft", value: 4),
          AnswerOption(label: "Sehr oft", value: 5),
        ]),
    QuestionnaireQuestion(
        questionId: "pss_4",
        text: "Wie oft hatten Sie im letzten Monat das Gefühl, dass sich die Dinge nach Ihren Vorstellungen entwickeln?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Niemals", value: 1),
          AnswerOption(label: "Selten", value: 2),
          AnswerOption(label: "Manchmal", value: 3),
          AnswerOption(label: "Oft", value: 4),
          AnswerOption(label: "Sehr oft", value: 5),
        ]),
    QuestionnaireQuestion(
        questionId: "pss_3",
        text: "Wie oft hatten Sie im letzten Monat das Gefühl, dass sich die Probleme so aufgestaut haben, dass Sie diese nicht mehr bewältigen können?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Niemals", value: 1),
          AnswerOption(label: "Selten", value: 2),
          AnswerOption(label: "Manchmal", value: 3),
          AnswerOption(label: "Oft", value: 4),
          AnswerOption(label: "Sehr oft", value: 5),
        ])
  ];
}
