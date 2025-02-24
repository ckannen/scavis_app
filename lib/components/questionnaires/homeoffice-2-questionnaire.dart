import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class HomeOffice2Questionnaire extends QuestionnaireTemplate {
  @override
  String id = "19_CB_COVID_Home-Office_Teil2";

  @override
  String introduction =
      "Im Folgenden geht es noch einmal um die Auswirkungen der COVID-19 Pandemie in Deutschland. Bitte beschreiben Sie, wie die COVID-19 Pandemie seit März 2020 Ihr Leben und Ihr Empfinden beeinflusst hat.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "corona_1", text: "Ich habe Angst, mich mit dem Coronavirus anzustecken.", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (völlig unzutreffend)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (völlig zutreffend)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "corona_2", text: "Ich habe Angst, andere Menschen anzustecken.", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (völlig unzutreffend)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (völlig zutreffend)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "corona_3", text: "Ich habe Angst, durch die Pandemie meine Arbeit zu verlieren.", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (völlig unzutreffend)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (völlig zutreffend)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "corona_4", text: "Ich habe Angst, durch die Pandemie hohe finanzielle Verluste zu erleiden.", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (völlig unzutreffend)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (völlig zutreffend)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "corona_5", text: "Ich habe Angst vor einem weiteren Lockdown.", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (völlig unzutreffend)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (völlig zutreffend)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "corona_6", text: "Ich habe Angst vor weiteren einschränkenden Corona-Maßnahmen.", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (völlig unzutreffend)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (völlig zutreffend)", value: 10)
    ]),

    QuestionnaireQuestion(questionId: "corona_7", text: "Wie bewerten Sie die Maßnahmen zur Bekämpfung der COVID-19 Pandemie?", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (sehr übertrieben)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (sehr angemessen)", value: 10)
    ]),
    // Inhaltliche Anmerkung: Zur Verfügung gestellt wird der Versuchsperson eine Ratingskala von 0-10 sehr übertrieben - sehr angemessen. Aber was soll die VP antworten, wenn sie die Maßnahmen nicht übertrieben oder angemessen, sondern vielmehr noch zu wenig fand? "Angemessen" ist nicht das Gegenstück von "sehr übertrieben", sondern ein neutraler Wert, ein Wert in der Mitte der Antwortmöglichkeiten. "-5 sehr übertrieben" ,[...], "0 (angemessen)", [...], "5 (noch zu wenig)". Wenn die Frage so bleibt wie sie ist, dann können Personen, die der Ansicht sind, die Maßnahmen seien nicht ausreichend, nicht ehrlich antworten. Ich habe z.B. Meinungen gelesen, dass Corona viel zu sehr auf die leichte Schulter genommen werde, und Bars, Restaurants und andere nicht-essenzielle Veranstaltungen nicht so schnell wieder hätten geöffnet werden sollen.

    QuestionnaireQuestion(
        questionId: "corona_8",
        text: "Für wie wahrscheinlich halten Sie es, dass Sie aufgrund der Auswirkungen der COVID-19 Pandemie in den nächsten 12 Monaten arbeitslos werden?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Überhaupt nicht wahrscheinlich", value: 1),
          AnswerOption(label: "Wenig wahrscheinlich", value: 2),
          AnswerOption(label: "Mäßig wahrscheinlich", value: 3),
          AnswerOption(label: "Ziemlich wahrscheinlich", value: 4),
          AnswerOption(label: "Sehr wahrscheinlich", value: 5),
          AnswerOption(label: "Ich bin bereits arbeitslos.", value: 6),
        ]),

    QuestionnaireQuestion(
        questionId: "home_office_1",
        text: "Unterscheidet sich Ihre aktuelle Beschäftigungssituation von Ihrer Beschäftigungssituation vor Beginn der COVID-19 Pandemie?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Ja, hat sich verbessert", value: 1),
          AnswerOption(label: "Ja, hat sich verschlechtert", value: 2),
          AnswerOption(label: "Nein, hat sich nicht verändert", value: 0),
        ]),
// Logik: Wenn "Ja", dann weiter mit home_office_2, sonst weiter mit home_office_3
    QuestionnaireQuestion(questionId: "home_office_2", text: "Wie sieht Ihre aktuelle Beschäftigungssituation aus?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ich arbeite im bisherigen Umfang vor Ort.", value: 1),
      AnswerOption(label: "Ich arbeite ausschließlich im Homeoffice im bisherigen Umfang.", value: 2),
      AnswerOption(label: "Ich arbeitet teils vor Ort, teils im Homeoffice.", value: 3),
      AnswerOption(label: "Ich bin in Kurzarbeit oder selbstständig mit reduzierter Arbeit.", value: 4),
      AnswerOption(label: "Ich habe eine Freistellung mit Lohn.", value: 5),
      AnswerOption(label: "Ich habe eine Freistellung ohne Lohn oder bin selbstständig ohne Arbeit.", value: 6),
      AnswerOption(label: "Ich bin arbeitslos geworden.", value: 7),
      AnswerOption(label: "Ich habe die Arbeitsstelle gewechselt.", value: 8),
      AnswerOption(label: "Ich habe aus meiner Arbeitslosigkeit heraus eine Anstellung gefunden.", value: 9),
    ]),
    QuestionnaireQuestion(questionId: "home_office_3", text: "Wie zufrieden sind Sie mit Ihrer aktuellen Beschäftigungssituation?", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (ganz und gar nicht zufrieden)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (voll und ganz zufrieden)", value: 10)
    ]),

    QuestionnaireQuestion(questionId: "urbanitaet_1", text: "Wo sind Sie geboren?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "In einer Stadt mit mehr als 100.000 Einwohner*innen", value: 1),
      AnswerOption(label: "In einer Stadt mit mehr als 10.000 Einwohner*innen", value: 2),
      AnswerOption(label: "In einer ländlichen Gegend (kleiner/gleich 10.000 Einwohner*innen)", value: 3),
    ]),

    QuestionnaireQuestion(
        questionId: "urbanitaet_2_info", text: "Wie viele Jahre haben Sie bis zu Ihrem 15. Lebensjahr (inkl. dem 15. Lebensjahr) in einer Stadt gelebt mit ...", type: AnswerFieldType.INFO),
//  Für die nächsten 3 Antwortmöglichkeiten: sollen wir doubles (3,5 Jahre) erlauben?
    QuestionnaireQuestion(questionId: "urbanitaet_2_1", text: "... mehr als 100.000 Einwohner*innen?", type: AnswerFieldType.TEXT, options: {"keyboard": "number"}),
    QuestionnaireQuestion(questionId: "urbanitaet_2_2", text: "... mehr als 10.000 Einwohner*innen?", type: AnswerFieldType.TEXT, options: {"keyboard": "number"}),
    QuestionnaireQuestion(questionId: "urbanitaet_2_3", text: "... gleich/weniger als 10.000 Einwohner*innen?", type: AnswerFieldType.TEXT, options: {"keyboard": "number"}),
    QuestionnaireQuestion(questionId: "urbanitaet_3", text: "Leben Sie aktuell ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "In einer Stadt mit mehr als 100.000 Einwohner*innen", value: 1),
      AnswerOption(label: "In einer Stadt mit mehr als 10.000 Einwohner*innen", value: 2),
      AnswerOption(label: "In einer ländlichen Gegend (kleiner/gleich 10.000 Einwohner*innen)", value: 3),
    ]),

    QuestionnaireQuestion(questionId: "haushalt_1", text: "Leben Sie in einer festen Partnerschaft?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
// Logik: Wenn "Nein", dann weiter mit haushalt_3, sonst normal weiter mit nächster Frage
    QuestionnaireQuestion(questionId: "haushalt_2", text: "Wie sieht die aktuelle Beschäftigungssituation Ihres Partners / Ihrer Partnerin aus?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Er/sie arbeitet im bisherigen Umfang vor Ort.", value: 1),
      AnswerOption(label: "Er/sie arbeitet ausschließlich im Homeoffice im bisherigen Umfang.", value: 2),
      AnswerOption(label: "Er/sie arbeitet teils vor Ort, teils im Homeoffice.", value: 3),
      AnswerOption(label: "Er/sie ist in Kurzarbeit oder selbstständig mit reduzierter Arbeit.", value: 4),
      AnswerOption(label: "Er/sie hat eine Freistellung mit Lohn.", value: 5),
      AnswerOption(label: "Er/sie hat eine Freistellung ohne Lohn oder ist selbstständig ohne Arbeit.", value: 6),
      AnswerOption(label: "Er/sie ist arbeitslos geworden.", value: 7),
      AnswerOption(label: "Er/sie ist bereits vor der COVID-19 Pandemie arbeitslos gewesen.", value: 8),
      AnswerOption(label: "Er/sie hat die Arbeitsstelle gewechselt.", value: 9),
      AnswerOption(label: "Er/sie hat aus der Arbeitslosigkeit heraus eine Anstellung gefunden.", value: 10),
    ]),

    QuestionnaireQuestion(
        questionId: "haushalt_3", text: "Wie viele Personen leben außer Ihnen in Ihrem Haushalt?", type: AnswerFieldType.TEXT, options: {"keyboard": "number", "validation": "positive-integer"}),
    QuestionnaireQuestion(
        questionId: "haushalt_4", text: "Wie viele Kinder leben in Ihrem Haushalt?", type: AnswerFieldType.TEXT, options: {"keyboard": "number", "validation": "positive-integer"}),
// Logik: Wenn Kinder >0, dann weiter mit haushalt_5, sonst weiter mit haushalt_9
    QuestionnaireQuestion(
        questionId: "haushalt_5",
        text: "Unterscheidet sich Ihre Kinderbetreuung von der Kinderbetreuung vor Beginn der COVID-19 Pandemie?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Ja", value: 1),
          AnswerOption(label: "Nein", value: 0),
        ]),
// Logik: wenn "ja", dann weiter mit haushalt_6, sonst weiter mit haushalt_7
    QuestionnaireQuestion(questionId: "haushalt_6", text: "Wer übernimmt in Ihrem Haushalt aktuell die Kinderbetreuung?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Kindergarten, Kindertagesstätte oder Tagesmutter", value: 1),
      AnswerOption(label: "Personen aus Haushalt", value: 2),
      AnswerOption(label: "Notfallbetreuung", value: 3),
      AnswerOption(label: "Externe Personen <60", value: 4),
      AnswerOption(label: "Externe Personen 60+", value: 5),
      AnswerOption(label: "Keine Betreuung", value: 6),
    ]),

    QuestionnaireQuestion(
        questionId: "haushalt_7",
        text: "Durch die Kinderbetreuung zu Hause während der COVID-19 Pandemie hat meine Arbeit gelitten.",
        type: AnswerFieldType.SELECTION_SLIDER,
        answerOptions: [
          AnswerOption(label: "0 (gar nicht)", value: 0),
          AnswerOption(label: "1", value: 1),
          AnswerOption(label: "2", value: 2),
          AnswerOption(label: "3", value: 3),
          AnswerOption(label: "4", value: 4),
          AnswerOption(label: "5", value: 5),
          AnswerOption(label: "6", value: 6),
          AnswerOption(label: "7", value: 7),
          AnswerOption(label: "8", value: 8),
          AnswerOption(label: "9", value: 9),
          AnswerOption(label: "10 (sehr stark)", value: 10)
        ]),

    QuestionnaireQuestion(
      questionId: "haushalt_8",
      text: "Durch die Kinderbetreuung zu Hause während der COVID-19 Pandemie hat die Beziehung zu meiner/m Partner*in gelitten.",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [AnswerOption(label: "0 (gar nicht)", value: 0),
          AnswerOption(label: "1", value: 1),
          AnswerOption(label: "2", value: 2),
          AnswerOption(label: "3", value: 3),
          AnswerOption(label: "4", value: 4),
          AnswerOption(label: "5", value: 5),
          AnswerOption(label: "6", value: 6),
          AnswerOption(label: "7", value: 7),
          AnswerOption(label: "8", value: 8),
          AnswerOption(label: "9", value: 9),
          AnswerOption(label: "10 (sehr stark)", value: 10)],
    ),
// Logik: Nur anzeigen wenn "Leben Sie in einer festen Partnerschaft?" mit "ja" beantwortet wurde

    QuestionnaireQuestion(
      questionId: "haushalt_9",
      text: "Wie sehr leiden Sie darunter, sich von anderen sozial distanzieren zu müssen?",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [AnswerOption(label: "0 (gar nicht)", value: 0),
          AnswerOption(label: "1", value: 1),
          AnswerOption(label: "2", value: 2),
          AnswerOption(label: "3", value: 3),
          AnswerOption(label: "4", value: 4),
          AnswerOption(label: "5", value: 5),
          AnswerOption(label: "6", value: 6),
          AnswerOption(label: "7", value: 7),
          AnswerOption(label: "8", value: 8),
          AnswerOption(label: "9", value: 9),
          AnswerOption(label: "10 (sehr stark)", value: 10)],
    ),

    QuestionnaireQuestion(questionId: "haushalt_10_info", text: "Welche der folgenden Hygieneregeln halten Sie ein?", type: AnswerFieldType.INFO),
    QuestionnaireQuestion(questionId: "haushalt_10_11", text: "Abstandhalten - mind. 1,5 Meter", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
    QuestionnaireQuestion(questionId: "haushalt_10_12", text: "Hygiene - häufiges Händewaschen und Niesen/Husten in die Armbeuge", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
    QuestionnaireQuestion(questionId: "haushalt_10_13", text: "Maske tragen", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    if (answers[currentItemIndex].questionId == "home_office_2") {
      if (this.getAnswerById(answers, "home_office_1")?.answerValues["index"] == 2) return true;
    }

    if (answers[currentItemIndex].questionId == "haushalt_2") {
      if (this.getAnswerById(answers, "haushalt_1")?.answerValues["index"] != 0) return true;
    }

    if (answers[currentItemIndex].questionId == "haushalt_5") {
      if (this.getAnswerById(answers, "haushalt_4")?.answerValues["value"] == "0") return true;
    }

    if (answers[currentItemIndex].questionId == "haushalt_6") {
      if (this.getAnswerById(answers, "haushalt_4")?.answerValues["value"] == "0") return true;
      if (this.getAnswerById(answers, "haushalt_5")?.answerValues["index"] != 0) return true;
    }

    if (answers[currentItemIndex].questionId == "haushalt_7") {
      if (this.getAnswerById(answers, "haushalt_4")?.answerValues["value"] == "0") return true;
    }

    if (answers[currentItemIndex].questionId == "haushalt_8") {
      if (this.getAnswerById(answers, "haushalt_4")?.answerValues["value"] == "0") return true;
      if (this.getAnswerById(answers, "haushalt_1")?.answerValues["index"] != 0) return true;
    }

    return false;
  }
}
