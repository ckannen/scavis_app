import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class SmarbQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "12_CB_SMARB";

  @override
  String introduction = "In den folgenden Fragen interessiert uns, welche Rolle Ihr Mobiltelefon / Smartphone in Ihrem beruflichen und privaten Alltag spielt.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "smarb_1", text: "Haben Sie ein dienstliches Mobiltelefon / Smartphone von Ihrer/Ihrem Arbeitgeber*in zur Verfügung gestellt bekommen?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 2),
      
    ]),
    // Logik: wenn "Ja", dann "smarb_1_1", sonst "smarb_2"
    QuestionnaireQuestion(questionId: "smarb_1_1", text: "Nutzen Sie Ihr dienstliches Mobiltelefon / Smartphone auch privat?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 2),
      
    ]),
    // Logik: Nach smarb_1_1 weiter zu smarb_3
    QuestionnaireQuestion(
        questionId: "smarb_2",
        text: "Nutzen Sie Ihr privates Mobiltelefon / Smartphone auch für arbeitsbezogene Zwecke (z.B. Kalender, Nachrichten, E-Mails)?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 2),
      
        ]),
    QuestionnaireQuestion(questionId: "smarb_3", text: "Dürfen Sie Ihr Mobiltelefon / Smartphone für private Zwecke während der Arbeitszeit / am Arbeitsplatz nutzen?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja, ich kann es jederzeit nutzen", value: 1),
      AnswerOption(label: "Ja, ich darf es aber nur in den Pausen nutzen", value: 2),
      AnswerOption(label: "Nein, eine Nutzung für private Zwecke ist nicht erlaubt", value: 3),
      AnswerOption(label: "Es gibt keine festgelegten Regeln", value: 5),
      
    ]),
    QuestionnaireQuestion(questionId: "smarb_4", text: "Wo befindet sich Ihr Mobiltelefon / Smartphone während der Arbeitszeit?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ich trage es immer bei mir / es liegt direkt neben mir", value: 1),
      AnswerOption(label: "Es ist im gleichen Raum, aber nicht direkt an meinem Arbeitsplatz (z.B. in der Tasche)", value: 2),
      AnswerOption(label: "Es ist nicht im gleichen Raum wie ich (z.B. verstaut in meinem Schrank / Spind)", value: 3),
      
    ]),
    QuestionnaireQuestion(questionId: "smarb_5", text: "Ist Ihr Mobiltelefon / Smartphone während der Arbeitszeit angeschaltet?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Es ist immer angeschaltet und der Ton ist angestellt", value: 1),
      AnswerOption(label: "Es ist immer angeschaltet, aber für Meetings stelle ich den Ton aus", value: 2),
      AnswerOption(label: "Es ist immer angeschaltet, aber auf Vibration gestellt", value: 3),
      AnswerOption(label: "Es ist immer angeschaltet, aber auf lautlos gestellt", value: 4),
      AnswerOption(label: "Während der Arbeitszeit stelle ich es aus oder nutze den Flugmodus", value: 5),
      
    ]),
    QuestionnaireQuestion(
        questionId: "smarb_6",
        text: "Wie viel Prozent Ihrer täglichen Online-Zeit verbringen Sie mit beruflichen Aktivitäten?",
        type: AnswerFieldType.NUMBER_SLIDER,
        options: {"min": 0, "max": 100, "divisions": 10, "trailing": "%"}),
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    if (answers[currentItemIndex].questionId == "smarb_1_1") {
      if (this.getAnswerById(answers, "smarb_1")?.answerValues["index"] != 0) return true;
    }

    if (answers[currentItemIndex].questionId == "smarb_2") {
      if (this.getAnswerById(answers, "smarb_1")?.answerValues["index"] == 0) return true;
    }

    return false;
  }
}
