import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class IcatShort28Questionnaire extends QuestionnaireTemplate {
  // Icat for day 1 and day 28 are slightly different in wording, but share the same id, also for the backend calculation
  @override
  String id = "icat_short";

  @override
  String introduction =
      "Die folgenden Fragen beziehen sich auf Ihre Online-Aktivitäten in den letzten 4 Wochen. Das beinhaltet alles, was Sie zu privaten Zwecken online über einen Computer, einen Laptop, ein Smartphone oder andere internetfähige Geräte tun. Zu Online-Aktivitäten zählen dabei z.B. Online-Spiele, soziale Netzwerke oder Kommunikation (z.B. WhatsApp, Facebook, Snapchat, Instagram) oder Anwendungen wie YouTube sowie die Nutzung anderer Programme und Angebote. NICHT gemeint ist jedoch das Hören von Musik, Podcasts oder Hörbüchern!";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "icat001",
      text: "Wie viele Stunden verbrachten Sie in den letzten 4 Wochen gewöhnlich an einem Tag in der Woche (Mo-Fr) privat im Internet?",
      type: AnswerFieldType.NUMBER_SLIDER,
      options: {"min": 0, "max": 24, "divisions": null, "trailing": " Stunde(n)"},
    ),
    QuestionnaireQuestion(
      questionId: "icat002",
      text: "Wie viele Stunden verbrachten Sie in den letzten 4 Wochen gewöhnlich an einem Tag des Wochenendes (Sa-So) privat im Internet?",
      type: AnswerFieldType.NUMBER_SLIDER,
      options: {"min": 0, "max": 24, "divisions": null, "trailing": " Stunde(n)"},
    ),
    QuestionnaireQuestion(
      questionId: "icat003",
      text: "Was ist Ihre Haupttätigkeit in den letzten 4 Wochen gewesen, wenn Sie das Internet über Computer, Laptop, Smartphone oder andere internetfähige Geräte zu privaten Zwecken nutzten?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Soziale Netzwerke und Chatten (z.B. WhatsApp, Facebook, Instagram, Snapchat, Twitter, TikTok, etc.)", value: 1),
        AnswerOption(label: "Online-Spiele (z.B. Fortnite, World of Tanks, Forge of Empires, Candy Crush)", value: 2),
        AnswerOption(label: "Glücksspiele (Spiele mit Geldeinsatz, z.B. Poker, Wetten, Internetcasino, etc.)", value: 3),
        AnswerOption(label: "Shoppen und Verkaufen", value: 4),
        AnswerOption(label: "Videoportale (z.B. YouTube, Twitch)", value: 5),
        AnswerOption(label: "Streamingdienste (z.B. Netflix, Spotify)", value: 6),
        AnswerOption(label: "Erotik und Pornografie", value: 7),
        AnswerOption(label: "Recherchieren oder Informationen suchen", value: 8),
        AnswerOption(label: "Datingportale (z.B. Tinder, Parship, etc.)", value: 9),
        AnswerOption(label: "Downloaden von Dateien", value: 10),
        AnswerOption(label: "Internet-(Video-)Telefonie (z.B. Skype, Zoom)", value: 11),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat004",
      text:
          "Haben Sie in den letzten 4 Wochen Ihre Online-Aktivitäten in gleicher Weise fortgesetzt, obwohl Sie deswegen Wichtiges versäumten (z.B. bei der Arbeit, in der Schule oder eine Verabredung)?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat005",
      text:
          "Haben Sie in den letzten 4 Wochen Ihre Online-Aktivitäten in gleicher Weise fortgesetzt, obwohl Sie deswegen finanzielle Schwierigkeiten bekamen (z.B. beim Shopping, durch In-App-Käufe oder durch den Kauf von Spielen, Add-Ons, Spielehardware, Abos, Apps)?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat006",
      text:
          "Haben Sie in den letzten 4 Wochen Ihre Online-Aktivitäten in gleicher Weise fortgesetzt, obwohl Sie deswegen eine wichtige Beziehung riskiert oder verloren haben (z.B. Partnerschaft, Freundschaft oder zu einer anderen nahestehenden Person)?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat007",
      text:
          "Haben Sie in den letzten 4 Wochen Ihre Online-Aktivitäten in gleicher Weise fortgesetzt, obwohl Sie deswegen Ihren Arbeitsplatz riskiert oder verloren, eine wichtige berufliche Aufstiegschance vertan oder Ihre Aus- bzw. Weiterbildung gefährdet haben?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat008",
      text:
          "Gab es in den letzten 4 Wochen eine Zeit, in der Sie wiederholt versuchten, vor Ihrer Familie, Ihren Freund*innen oder anderen zu verheimlichen, wie viel Zeit Sie mit Online-Aktivitäten verbrachten?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat009",
      text:
          "Haben Sie in den letzten 4 Wochen mehrfach ohne Erfolg versucht, bestimmte Online-Aktivitäten ganz zu beenden oder die Nutzungszeit einzuschränken, da Sie fanden, dass Sie zu viel online sind? ",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat010",
      text:
          "Haben Sie in den letzten 4 Wochen den anhaltenden Wunsch verspürt, bestimmte Online-Aktivitäten ganz zu beenden oder die Nutzung einzuschränken, da Sie fanden, dass Sie zu viel online sind?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat011",
      text: "Haben Sie in den letzten 4 Wochen bemerkt, dass Sie aufgrund der Online-Aktivitäten Ihr Interesse an anderen Aktivitäten wie Sport, Hobbys oder Treffen mit Freund*innen verloren haben? ",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat012",
      text:
          "Hatten Sie in den letzten 4 Wochen Phasen, in denen Sie sehr viel Zeit damit verbrachten, an Ihre Online-Aktivitäten zu denken, während Sie über andere Dinge hätten nachdenken oder andere Dinge tun sollen? ",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat013",
      text: "Gab es in den letzten 4 Wochen eine Zeit, in der Sie Online-Aktivitäten oftmals dazu benutzten, um vor negativen Gefühlen (z.B. Hilflosigkeit, Schuld, Angst) zu fliehen? ",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat014",
      text:
          "Haben Sie in den letzten 4 Wochen Ihre Online-Aktivitäten in gleicher Weise fortgesetzt, obwohl Sie deswegen psychische Probleme bekamen (z.B. Depressionen, Angstzustände, Schlafprobleme, o.Ä.)?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat015",
      text:
          "Haben Sie in den letzten 4 Wochen Ihre Online-Aktivitäten in gleicher Weise fortgesetzt, obwohl sie körperliche Probleme verursachten oder verschlimmerten (z.B. Rücken-, Augen- oder Kopfschmerzen, Gelenkprobleme, deutliches Über- oder Untergewicht)?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat016",
      text: "Haben Sie in den letzten 4 Wochen an sich bemerkt, dass Sie deutlich länger oder häufiger als früher Online-Aktivitäten nutzen mussten, um genauso zufrieden zu sein wie üblich?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat017",
      text:
          "Als Sie in den letzten 4 Wochen einmal weniger oder gar nicht online aktiv sein durften oder wollten, bemerkten Sie da irgendwelche körperlichen oder psychischen Probleme (z.B. Unruhe, Angstgefühle, Nervosität, Gereiztheit, Traurigkeit)?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat018",
      text: "Sind Sie in den letzten 4 Wochen ins Internet gegangen, um solche Probleme von vornherein zu vermeiden?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat019",
      text: "Bei den vorangegangenen Fragen zu Problemen im Zusammenhang mit der Internetnutzung haben Sie mindestens bei einer mit 'Ja' geantwortet. Sind diese Probleme hauptsächlich auf eine einzelne Anwendung zurückzuführen?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein, das gilt für mehrere Anwendungen", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat020",
      text: "Auf welche einzelne Anwendung trifft dies zu?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Soziale Netzwerke und Chatten (z.B. WhatsApp, Facebook, Instagram, Snapchat, Twitter, TikTok, etc.)", value: 1),
        AnswerOption(label: "Online-Spiele (z.B. Fortnite, World of Tanks, Forge of Empires, Candy Crush)", value: 2),
        AnswerOption(label: "Glücksspiele (Spiele mit Geldeinsatz, z.B. Poker, Wetten, Internetcasino, etc.)", value: 3),
        AnswerOption(label: "Shoppen und Verkaufen", value: 4),
        AnswerOption(label: "Videoportale (z.B. YouTube, Twitch)", value: 5),
        AnswerOption(label: "Streamingdienste (z.B. Netflix, Spotify)", value: 6),
        AnswerOption(label: "Erotik und Pornografie", value: 7),
        AnswerOption(label: "Recherchieren oder Informationen suchen", value: 8),
        AnswerOption(label: "Datingportale (z.B. Tinder, Parship, etc.)", value: 9),
        AnswerOption(label: "Downloaden von Dateien", value: 10),
        AnswerOption(label: "Internet-(Video-)Telefonie (z.B. Skype, Zoom)", value: 11),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "icat021",
      text: "Auf welche Anwendungen trifft dies zu?",
      type: AnswerFieldType.MULTILIST,
      answerOptions: [
        AnswerOption(label: "Soziale Netzwerke und Chatten (z.B. WhatsApp, Facebook, Instagram, Snapchat, Twitter, TikTok, etc.)", value: 1),
        AnswerOption(label: "Online-Spiele (z.B. Fortnite, World of Tanks, Forge of Empires, Candy Crush)", value: 2),
        AnswerOption(label: "Glücksspiele (Spiele mit Geldeinsatz, z.B. Poker, Wetten, Internetcasino, etc.)", value: 3),
        AnswerOption(label: "Shoppen und Verkaufen", value: 4),
        AnswerOption(label: "Videoportale (z.B. YouTube, Twitch)", value: 5),
        AnswerOption(label: "Streamingdienste (z.B. Netflix, Spotify)", value: 6),
        AnswerOption(label: "Erotik und Pornografie", value: 7),
        AnswerOption(label: "Recherchieren oder Informationen suchen", value: 8),
        AnswerOption(label: "Datingportale (z.B. Tinder, Parship, etc.)", value: 9),
        AnswerOption(label: "Downloaden von Dateien", value: 10),
        AnswerOption(label: "Internet-(Video-)Telefonie (z.B. Skype, Zoom)", value: 11),
      ],
    ),
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    // if questions 1-18 are all "no", skip question 19-21
    if (answers[currentItemIndex].questionId == "icat019" || answers[currentItemIndex].questionId == "icat020" || answers[currentItemIndex].questionId == "icat021") {
      bool icatBefore19AnswersYes = false;
      if (this.getAnswerById(answers, "icat001")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat002")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat003")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat004")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat005")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat006")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat007")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat008")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat009")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat010")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat011")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat012")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat013")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat014")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat015")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat016")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat017")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (this.getAnswerById(answers, "icat018")?.answerValues["index"] == 0) icatBefore19AnswersYes = true;
      if (!icatBefore19AnswersYes) {
        return true;
      }
    }
    
    if (answers[currentItemIndex].questionId == "icat020") {
      if (this.getAnswerById(answers, "icat019")?.answerValues != null && this.getAnswerById(answers, "icat019")?.answerValues["index"] != 0) return true;
    }
    if (answers[currentItemIndex].questionId == "icat021") {
      if (this.getAnswerById(answers, "icat019")?.answerValues != null && this.getAnswerById(answers, "icat019")?.answerValues["index"] != 1) return true;
    }

    return false;
  }
}
