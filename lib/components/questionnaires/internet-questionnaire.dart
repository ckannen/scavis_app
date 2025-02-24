import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class InternetQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "internet_activity";

  @override
  String introduction = "Games, Social Media und andere Online-Aktivitäten sind ein schöner Zeitvertreib und in unserem Alltag nicht mehr wegzudenken. Deshalb interessiert uns, was Sie in Ihrer Freizeit im Internet tun. Dazu gehören alle Online-Aktivitäten, die Sie zu privaten Zwecken ausüben. Egal ob über Smartphone, Computer, Laptop, Tablet oder Ähnliches.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
        questionId: "activity",
        text: "Geben Sie für alle Anwendungsformen an, wie viel Prozent Ihrer Online-Aktivitäten diese Anwendungen einnehmen. Insgesamt können Sie mit allen Slidern 100% auswählen.",
        type: AnswerFieldType.MULTI_SLIDER,
        options: {
          "showMasterSlider": false,
          "min": 0.0,
          "max": 100.0,
          "divisions": 100,
          "startvalue": 100,
          "answerOptions": [
            "Soziale Netzwerke und Chatten (z.B. WhatsApp, Facebook, Instagram, Snapchat, Twitter, TikTok, etc.)",
            "Online-Spiele (z.B. Fortnite, World of Tanks, Forge of Empires, Candy Crush, etc.)",
            "Glücksspiele (Spiele mit Geldeinsatz, z.B. Poker, Wetten, Internetcasino, etc.)",
            "Shoppen und Verkaufen",
            "Videoportale (z.B. YouTube, Twitch, etc.)",
            "Streamingdienste (z.B. Netflix, Spotify, etc.)",
            "Erotik und Pornografie",
            "Recherchieren oder Informationen suchen",
            "Datingportale (z.B. Tinder, Parship, etc.)",
            "Downloaden von Dateien",
            "Internet-(Video-)Telefonie (z.B. Skype, Zoom, etc.)",
          ]
        }),
    QuestionnaireQuestion(
        questionId: "activity_tool",
        text: "Welches Gerät nutzen Sie hauptsächlich, um online zu sein? Wählen Sie bitte nur eine Antwortmöglichkeit.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "PC", value: 1),
          AnswerOption(label: "Laptop", value: 2),
          AnswerOption(label: "Tablet", value: 3),
          AnswerOption(label: "Smartphone", value: 4),
          AnswerOption(label: "Sonstiges", value: 5),
        ])
  ];
}
