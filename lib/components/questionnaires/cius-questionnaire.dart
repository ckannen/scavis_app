import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class CiusQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "CIUS_Compulsive_Internet_Use_Scale";

  @override
  String introduction =
      "Bei einigen Menschen kann die Beschäftigung mit dem Internet überhand nehmen, wodurch negative Folgen auftreten können. Bitte beantworten Sie die folgenden Fragen zu den Folgen Ihrer privaten Internet- und Smartphonenutzung in den letzten 4 Wochen.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "cius_1", text: "Wie häufig finden Sie es schwierig, mit den Online-Aktivitäten aufzuhören?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(
        questionId: "cius_2",
        text: "Wie häufig setzen Sie Ihre Online-Aktivitäten fort, obwohl Sie eigentlich aufhören wollten?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "cius_3",
        text: "Wie häufig sagen Ihnen andere Menschen (z.B. Partner*in, Kinder, Eltern, Freund*innen), dass Sie weniger online sein sollten?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "cius_4",
        text: "Wie häufig bevorzugen Sie Ihre Online-Aktivitäten statt Zeit mit anderen zu verbringen (z.B. Partner*in, Kinder, Eltern, Freund*innen)?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(questionId: "cius_5", text: "Wie häufig schlafen Sie zu wenig wegen Ihrer Online-Aktivitäten?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(questionId: "cius_6", text: "Wie häufig denken Sie an Ihre Online-Aktivitäten, auch wenn Sie gerade nicht online sind?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(questionId: "cius_7", text: "Wie oft freuen Sie sich bereits auf Ihre Online-Aktivitäten?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(questionId: "cius_8", text: "Wie häufig denken Sie darüber nach, dass Sie weniger Zeit online verbringen sollten?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(questionId: "cius_9", text: "Wie häufig haben Sie erfolglos versucht, weniger Zeit online zu verbringen?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(
        questionId: "cius_10",
        text: "Wie häufig erledigen Sie Ihre Aufgaben zuhause hastig, damit Sie früher online sein können?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "cius_11",
        text: "Wie häufig vernachlässigen Sie Ihre Alltagsverpflichtungen (z.B. Arbeit, Schule, Familienleben), weil Sie lieber online sind?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(questionId: "cius_12", text: "Wie häufig gehen Sie online, wenn Sie sich niedergeschlagen fühlen?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(
        questionId: "cius_13",
        text: "Wie häufig nutzen Sie Ihre Online-Aktivitäten, um Ihren Sorgen zu entkommen oder um sich von einer negativen Stimmung zu entlasten?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "cius_14",
        text: "Wie häufig fühlen Sie sich unruhig, frustriert oder gereizt, wenn Sie nicht online sein können?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
  ];
}
