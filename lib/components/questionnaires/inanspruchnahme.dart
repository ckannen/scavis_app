import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class InanspruchnahmeQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "CB_Inanspruchnahme";

  @override
  String introduction = "";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "inan_01", text: "Haben Sie in den letzten 4 Wochen Hilfsangebote für psychische oder seelische Probleme genutzt?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
      AnswerOption(label: "Keine Angabe", value: 9999),
    ]),
    QuestionnaireQuestion(questionId: "inan_02", text: "Welche Hilfsangebote für psychische oder seelische Probleme haben Sie in den letzten 4 Wochen genutzt?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Psychologischer Psychotherapeut", value: 1),
      AnswerOption(label: "Psychiater", value: 2),
      AnswerOption(label: "Psychosoziale Beratungsstelle", value: 3),
      AnswerOption(label: "Sozialarbeiter", value: 4),
      AnswerOption(label: "Beratung im Betrieb/in der Schule", value: 5),
      AnswerOption(label: "Selbsthilfegruppe", value: 6),
      AnswerOption(label: "Psychiatrische Klinik/Ambulanz", value: 7),
      AnswerOption(label: "Anderes", value: 8),
      AnswerOption(label: "Keine Angabe", value: 9999),
    ]),
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    if (answers[currentItemIndex].questionId == "inan_02") {
      if (this.getAnswerById(answers, "inan_01")?.answerValues["index"] != 1) return true;
    }

    return false;
  }
}
