import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class GamesQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "5_CB_Games";

  @override
  String introduction = "Im Folgenden geht es speziell um Gaming. Unter Gaming verstehen wir alle Arten von digitalen Spielen, die Sie online oder offline, auf dem Computer, der Konsole, dem Tablet oder dem Smartphone spielen können.\nBeantworten Sie die folgenden Fragen bitte in Bezug auf Online- sowie Offline-Gaming in den letzten 3 Monaten.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "cb_games_0", text: "Nutzen Sie Online- oder Offline-Spiele?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
    QuestionnaireQuestion(questionId: "cb_games_1", text: "Waren Sie oft nicht in der Lage, mit dem Spielen aufzuhören, obwohl Sie es hätten tun sollen?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
    QuestionnaireQuestion(questionId: "cb_games_2", text: "Haben Sie oft länger gespielt, als Sie vor Beginn des Spielens geplant hatten?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
    QuestionnaireQuestion(
        questionId: "cb_games_3",
        text: "Ist Ihnen aufgefallen, dass Sie wegen des Spielens deutlich das Interesse an wichtigen Aktivitäten wie Sport, Hobbys oder Treffen mit Freund*innen oder Verwandten verloren haben?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Ja", value: 1),
          AnswerOption(label: "Nein", value: 0),
        ]),
    QuestionnaireQuestion(questionId: "cb_games_4", text: "Ist das Spielen der wichtigste Teil Ihres täglichen Lebens?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
    QuestionnaireQuestion(questionId: "cb_games_5", text: "Haben sich Ihre schulischen oder beruflichen Leistungen aufgrund des Spielens verschlechtert?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
    QuestionnaireQuestion(
        questionId: "cb_games_6",
        text: "Haben Sie durch das Spielen eine Verschiebung von Tag und Nacht oder eine Tendenz zur Verschiebung von Tag und Nacht (an mindestens 8 Tagen während der letzten 3 Monate) erlebt?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Ja", value: 1),
          AnswerOption(label: "Nein", value: 0),
        ]),
    QuestionnaireQuestion(
        questionId: "cb_games_7",
        text: "Haben Sie weiterhin gespielt, obwohl Sie Ihre Ausbildung gefährdet oder Ihre Arbeit wegen des Spielens riskiert oder verloren haben?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Ja", value: 1),
          AnswerOption(label: "Nein", value: 0),
        ]),
    QuestionnaireQuestion(
        questionId: "cb_games_8",
        text: "Haben Sie weiterhin gespielt, obwohl Sie durch das Spielen psychische Probleme hatten, z.B. depressiv oder ängstlich geworden sind oder Schlafprobleme hatten?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Ja", value: 1),
          AnswerOption(label: "Nein", value: 0),
        ]),
    QuestionnaireQuestion(
      questionId: "cb_games_9",
      text: "Wie viele Stunden verbringen Sie ungefähr an einem typischen Wochentag (Mo-Fr) mit Spielen?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Weniger als 2 Stunden", value: 0),
        AnswerOption(label: "Mindestens 2 Stunden, aber weniger als 6 Stunden", value: 1),
        AnswerOption(label: "6 Stunden oder länger", value: 2),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "cb_games_10",
      text: "Wie viele Stunden verbringen Sie ungefähr an einem typischen Tag des Wochenendes (Sa, So) mit Spielen?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Weniger als 2 Stunden", value: 0),
        AnswerOption(label: "Mindestens 2 Stunden, aber weniger als 6 Stunden", value: 1),
        AnswerOption(label: "6 Stunden oder länger", value: 2),
      ],
    ),
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    if (answers[currentItemIndex].questionId != "cb_games_0") {
      if (this.getAnswerById(answers, "cb_games_0")?.answerValues["index"] == 1) return true;
    }

    return false;
  }
}
