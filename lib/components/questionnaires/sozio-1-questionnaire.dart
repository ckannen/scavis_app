import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class Sozio1Questionnaire extends QuestionnaireTemplate {
  @override
  String id = "SOZIODEMOGRAPHIE_SCAVIS";

  @override
  String introduction = "Um Ihnen später ein bestmögliches Feedback geben zu können, benötigen wir zu Beginn einige persönliche Angaben von Ihnen.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "origin2", text: "Wie sind Sie auf unsere Studie und die dazugehörige App aufmerksam geworden?", type: AnswerFieldType.DROPDOWN, answerOptions: [
      AnswerOption(label: "Durch einen Aktionstag in meiner Firma", value: 1),
      AnswerOption(label: "Durch eine E-Mail meiner Firma", value: 2),
      AnswerOption(label: "Durch den betriebsärztlichen Dienst", value: 3),
      AnswerOption(label: "Durch meine Krankenkasse", value: 4),
      AnswerOption(label: "Durch Arbeitskolleg*innen", value: 5),
      AnswerOption(label: "Durch Freund*innen oder Bekannte", value: 6),
      AnswerOption(label: "Über das Internet", value: 7),
    ]),
    // Logik: Wenn "Über das Internet", dann origin2_dropdown
    QuestionnaireQuestion(questionId: "origin2_dropdown", text: "Bitte grenzen Sie Ihre Angabe weiter ein.", type: AnswerFieldType.DROPDOWN, answerOptions: [
      AnswerOption(label: "Facebook", value: 1),
      AnswerOption(label: "Instagram", value: 2),
      AnswerOption(label: "Webseite", value: 3),
      AnswerOption(label: "Appstore/Playstore", value: 4),
    ]),
    QuestionnaireQuestion(questionId: "sex", text: "Welches Geschlecht haben Sie?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Männlich", value: 1),
      AnswerOption(label: "Weiblich", value: 2),
      AnswerOption(label: "Divers", value: 3),
    ]),
    QuestionnaireQuestion(questionId: "age", text: "Und wie alt sind Sie?", type: AnswerFieldType.NUMBER_PICKER, options: {"min": 16, "max": 67, "step": null, "trailing": "Jahre", "messageAsFirstElement": true}),
    QuestionnaireQuestion(questionId: "soz_1", text: "Welchen Familienstand haben Sie [im juristischen Sinne]?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Verheiratet und leben mit Ihrem/Ihrer Ehepartner*in zusammen", value: 1),
      AnswerOption(label: "Verheiratet und leben von Ihrem/Ihrer Ehepartner*in getrennt [im juristischen Sinne]", value: 2),
      AnswerOption(label: "In einer eingetragenen Lebensgemeinschaft lebend", value: 3),
      AnswerOption(label: "Geschieden", value: 4),
      AnswerOption(label: "Verwitwet", value: 5),
      AnswerOption(label: "Ledig", value: 6),
    ]),
    // Logik: Wenn "Verheiratet und leben mit Ihrem/Ihrer Ehepartner*in zusammen" dann weiter mit soz2_1, ansonsten ERST soz_1_2. DANACH soz_2_1
    QuestionnaireQuestion(questionId: "soz_1_2", text: "Leben Sie derzeit in einer festen Partnerschaft?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 2),
    ]),
    QuestionnaireQuestion(questionId: "soz_2_1", text: "Sind Sie in Deutschland geboren?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 2),
    ]),
    QuestionnaireQuestion(questionId: "soz_2_1_sprache", text: "Verstehen Sie Deutsch so gut, dass Sie allgemeine Texte gut verstehen können?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 2),
    ]),
    QuestionnaireQuestion(questionId: "soz_2_2", text: "Ist Ihre Mutter in Deutschland geboren?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 2),
    ]),
    QuestionnaireQuestion(questionId: "soz_2_3", text: "Ist Ihr Vater in Deutschland geboren?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja", value: 1),
      AnswerOption(label: "Nein", value: 2),
    ])
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    if (answers[currentItemIndex].questionId == "origin2_dropdown") {
      if (this.getAnswerById(answers, "origin2")?.answerValues["index"] != 6) return true;
    }

    if (answers[currentItemIndex].questionId == "soz_1_2") {
      if (this.getAnswerById(answers, "soz_1")?.answerValues["index"] == 0) return true;
    }

    if (answers[currentItemIndex].questionId == "soz_2_1_sprache") {
      if (this.getAnswerById(answers, "soz_2_1")?.answerValues["index"] == 0) return true;
    }

    return false;
  }
}
