import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class ActQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "act_more";

  @override
  String introduction = """""";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "act_more_0", text: "Benutzen Sie einige Internetanwendungen mehr, als Ihnen guttut?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 0),
    ]),
    // Logik: wenn ja, dann weiter mit act_more, wenn nein, "end".
    QuestionnaireQuestion(questionId: "act_more", text: "Wenn ja, welche sind diese? (Mehrfachantworten möglich)", type: AnswerFieldType.MULTILIST, answerOptions: [
      AnswerOption(label:"Soziale Netzwerke und Chatten (z.B. WhatsApp, Facebook, Instagram, Snapchat, etc.)", value: 1),
      AnswerOption(label:"Online-Spiele (z.B. Fortnite, World of Tanks, Forge of Empires, Candy Crush)", value: 2),
      AnswerOption(label:"Glücksspiele (Spiele mit Geldeinsatz, z.B. Poker, Wetten, Internetcasino, etc.)", value: 3),
      AnswerOption(label:"Shoppen und Verkaufen", value: 4),
      AnswerOption(label:"Videoportale (z.B. YouTube, Twitch)", value: 5),
      AnswerOption(label:"Streamingdienste (z.B. Netflix, Spotify)", value: 10),
      AnswerOption(label:"Erotik und Pornografie", value: 6),
      AnswerOption(label:"Recherchieren oder Informationen suchen", value: 7),
      AnswerOption(label:"Partnerschaftsbörsen besuchen (z.B. Tinder, Parship, etc.)", value: 8),
      AnswerOption(label:"Downloaden von Dateien", value: 9),
      AnswerOption(label:"Internet-(Video-)Telefonie (z.B. Skype, Zoom)", value: 11),
    ])
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    if (answers[currentItemIndex].questionId == "act_more") {
      if (this.getAnswerById(answers, "act_more_0")?.answerValues["index"] != 0) return true;
    }

    return false;
  }
}
