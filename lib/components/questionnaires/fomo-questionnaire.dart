import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class FomoQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "FoMO";

  @override
  String introduction = "Hier sind einige Aussagen über Ihre alltäglichen Erfahrungen.\nGeben Sie an, wie sehr jede Aussage auf Ihre persönliche Erfahrung zutrifft.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "fomo_01", text: "Ich habe Angst, dass andere lohnendere Erfahrungen machen als ich.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "Stimme eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Stimme eher zu", value: 4),
      AnswerOption(label: "Stimme voll und ganz zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "fomo_02", text: "Ich habe Angst, dass meine Freund*innen lohnendere Erfahrungen machen als ich.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "Stimme eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Stimme eher zu", value: 4),
      AnswerOption(label: "Stimme voll und ganz zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "fomo_03", text: "Ich mache mir Gedanken, wenn ich herausfinde, dass meine Freund*innen ohne mich Spaß haben.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "Stimme eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Stimme eher zu", value: 4),
      AnswerOption(label: "Stimme voll und ganz zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "fomo_04", text: "Ich fühle mich verunsichert, wenn ich nicht weiß, was meine Freund*innen vorhaben.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "Stimme eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Stimme eher zu", value: 4),
      AnswerOption(label: "Stimme voll und ganz zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "fomo_05", text: "Wenn ich ein geplantes Treffen verpasse, ärgert mich das.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "Stimme eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Stimme eher zu", value: 4),
      AnswerOption(label: "Stimme voll und ganz zu", value: 5),
    ]),
    QuestionnaireQuestion(
        questionId: "fomo_06",
        text: "Wenn ich Spaß habe, ist es mir wichtig, Einzelheiten davon online zu teilen (z.B. mit einem Status-Update).",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
          AnswerOption(label: "Stimme eher nicht zu", value: 2),
          AnswerOption(label: "Weder noch", value: 3),
          AnswerOption(label: "Stimme eher zu", value: 4),
          AnswerOption(label: "Stimme voll und ganz zu", value: 5),
        ]),
    QuestionnaireQuestion(questionId: "fomo_07", text: "Wenn ich in den Urlaub fahre, behalte ich weiterhin im Auge, was meine Freund*innen gerade tun.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "Stimme eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Stimme eher zu", value: 4),
      AnswerOption(label: "Stimme voll und ganz zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "fomo_08", text: "Ich habe Angst, in meinen Sozialen Netzwerken nicht immer auf dem Laufenden zu sein.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "Stimme eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Stimme eher zu", value: 4),
      AnswerOption(label: "Stimme voll und ganz zu", value: 5),
    ]),
    QuestionnaireQuestion(
        questionId: "fomo_09",
        text: "Es ist mir wichtig, über aktuelle Inhalte in meinen sozialen Netzwerken mitreden zu können (Videos, Bilder, Post, etc.).",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
          AnswerOption(label: "Stimme eher nicht zu", value: 2),
          AnswerOption(label: "Weder noch", value: 3),
          AnswerOption(label: "Stimme eher zu", value: 4),
          AnswerOption(label: "Stimme voll und ganz zu", value: 5),
        ]),
    QuestionnaireQuestion(questionId: "fomo_10", text: "Ich bin ständig online, damit ich nichts verpasse.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "Stimme eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Stimme eher zu", value: 4),
      AnswerOption(label: "Stimme voll und ganz zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "fomo_11", text: "Ich schaue ständig auf mein Handy, damit ich nichts verpasse.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "Stimme eher nicht zu", value: 2),
      AnswerOption(label: "Weder noch", value: 3),
      AnswerOption(label: "Stimme eher zu", value: 4),
      AnswerOption(label: "Stimme voll und ganz zu", value: 5),
    ]),
    QuestionnaireQuestion(
        questionId: "fomo_12",
        text: "Es ist mir wichtig, den Internetslang zu verstehen, den meine Freund*innen benutzen (Ausdrücke wie LOL, etc.).",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Stimme überhaupt nicht zu", value: 1),
          AnswerOption(label: "Stimme eher nicht zu", value: 2),
          AnswerOption(label: "Weder noch", value: 3),
          AnswerOption(label: "Stimme eher zu", value: 4),
          AnswerOption(label: "Stimme voll und ganz zu", value: 5),
        ]),
  ];
}
