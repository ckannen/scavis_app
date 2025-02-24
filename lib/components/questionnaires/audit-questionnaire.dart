import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class AuditQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "15_CB_AUDITC_plus_16_CB_Rauchverhalten";

  @override
  String introduction = "Wir möchten Sie nun zu Ihrem Alkohol- und Nikotinkonsum befragen.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "autidc_1", text: "Wie oft nehmen Sie ein alkoholisches Getränk zu sich?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Niemals", value: 1),
      AnswerOption(label: "1 mal im Monat oder seltener", value: 2),
      AnswerOption(label: "2 bis 4 mal im Monat", value: 3),
      AnswerOption(label: "2 bis 3 mal pro Woche", value: 4),
      AnswerOption(label: "4 mal oder mehrmals in der Woche", value: 5),
    ]),
    QuestionnaireQuestion(
        questionId: "autidc_2",
        text:
            "Wenn Sie alkoholische Getränke zu sich nehmen, wie viel trinken Sie dann typischerweise an einem Tag? Ein alkoholhaltiges Getränk ist z.B. ein kleines Glas oder eine Flasche Bier, ein kleines Glas Wein oder Sekt, ein einfacher Schnaps oder ein Glas Likör.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "1 - 2", value: 1),
          AnswerOption(label: "3 - 4", value: 2),
          AnswerOption(label: "5 - 6", value: 3),
          AnswerOption(label: "7 - 9", value: 4),
          AnswerOption(label: "10 oder mehr", value: 5),
        ]),
    QuestionnaireQuestion(questionId: "autidc_3", text: "Wie oft trinken Sie 6 oder mehr Gläser Alkohol bei einer Gelegenheit?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Niemals", value: 1),
      AnswerOption(label: "Seltener als 1 mal im Monat", value: 2),
      AnswerOption(label: "1 mal im Monat", value: 3),
      AnswerOption(label: "1 mal pro Woche", value: 4),
      AnswerOption(label: "Täglich oder fast täglich", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "smokestatus", text: "Rauchen Sie Zigaretten?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein, noch nie", value: 2),
      AnswerOption(label: "Nein, aber früher habe ich geraucht", value: 3),
      AnswerOption(label: "Keine Angabe", value: 9999),
    ]),
    // Logik: wenn "ja" dann weiter mit "tabak_1", sonst "shisha_1"
    // Das Feld sollte eigentlich ein Textfeld sein
    QuestionnaireQuestion(
        questionId: "tabak_1",
        text: "Wie viele Zigaretten haben Sie in den letzten vier Wochen üblicherweise pro Tag geraucht?",
        type: AnswerFieldType.NUMBER_SLIDER,
        options: {"min": 0, "max": 200, "divisions": null}),
    // Logik: wenn 0 dann shisha_1, sonst tabak_2
    QuestionnaireQuestion(questionId: "tabak_2", text: "Wie bald, nachdem Sie aufwachen, rauchen Sie Ihre erste Zigarette?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Innerhalb von 5 Minuten", value: 0),
      AnswerOption(label: "Innerhalb einer halben Stunde", value: 1),
      AnswerOption(label: "Innerhalb einer Stunde", value: 2),
      AnswerOption(label: "Nach einer Stunde", value: 3),
      AnswerOption(label: "Keine Angabe", value: 9999),
    ]),
    QuestionnaireQuestion(questionId: "shisha_1", text: "Wie oft haben Sie in den letzten 3 Monaten Shisha geraucht?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "1 mal pro Monat oder seltener", value: 1),
      AnswerOption(label: "2-4 mal pro Monat", value: 2),
      AnswerOption(label: "2-3 mal pro Woche", value: 3),
      AnswerOption(label: "4 mal pro Woche oder öfter", value: 4),
      AnswerOption(label: "Keine Angabe", value: 9999),
    ]),
    // Logik: wenn 0 dann e-zigarette, sonst shisha_2
    QuestionnaireQuestion(questionId: "shisha_2", text: "Welchen Tabak verwenden Sie beim Shisha-Rauchen?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Hauptsächlich nikotinfreien", value: 0),
      AnswerOption(label: "Hauptsächlich nikotinhaltigen", value: 1),
      AnswerOption(label: "Weiß nicht", value: 2),
      AnswerOption(label: "Keine Angabe", value: 9999),
    ]),
    QuestionnaireQuestion(questionId: "e-zigarette", text: "Wie oft haben Sie in den letzten 3 Monaten E-Zigaretten oder E-Shishas genutzt?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "1 mal pro Monat oder seltener", value: 1),
      AnswerOption(label: "2-4 mal pro Monat", value: 2),
      AnswerOption(label: "2-3 mal pro Woche", value: 3),
      AnswerOption(label: "4 mal pro Woche oder öfter", value: 4),
      AnswerOption(label: "Keine Angabe", value: 9999),
    ]),
    // Logik: Wenn 0 dann ende, sonst e-zig-liquid
    QuestionnaireQuestion(questionId: "e-zig-liquid", text: "Welches Liquid verwenden Sie für Ihre E-Zigarette oder E-Shisha?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Hauptsächlich nikotinfreien", value: 0),
      AnswerOption(label: "Hauptsächlich nikotinhaltigen", value: 1),
      AnswerOption(label: "Weiß nicht", value: 2),
      AnswerOption(label: "Keine Angabe", value: 9999),
    ])
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    if (answers[currentItemIndex].questionId == "autidc_2") {
      if (this.getAnswerById(answers, "autidc_1")?.answerValues["index"] == 0) return true;
    }

    if (answers[currentItemIndex].questionId == "autidc_3") {
      if (this.getAnswerById(answers, "autidc_1")?.answerValues["index"] == 0) return true;
    }

    if (answers[currentItemIndex].questionId == "tabak_1") {
      if (this.getAnswerById(answers, "smokestatus")?.answerValues["index"] != 0) return true;
    }

    if (answers[currentItemIndex].questionId == "tabak_2") {
      if (this.getAnswerById(answers, "smokestatus")?.answerValues["index"] != 0) return true;
      if (this.getAnswerById(answers, "tabak_1")?.answerValues["value"] == 0) return true;
    }

    if (answers[currentItemIndex].questionId == "shisha_2") {
      if (this.getAnswerById(answers, "shisha_1")?.answerValues["index"] == 0) return true;
    }

    if (answers[currentItemIndex].questionId == "e-zig-liquid") {
      if (this.getAnswerById(answers, "e-zigarette")?.answerValues["index"] == 0) return true;
    }

    return false;
  }
}
