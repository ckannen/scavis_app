import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class WhodasQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "whodas";

  @override
  String introduction = "Bei den nächsten Fragen geht es um Schwierigkeiten, die aufgrund von intensiver Internet- oder Smartphonenutzung entstehen können.\nDenken Sie an die letzten 30 Tage und beantworten Sie die folgenden Fragen im Hinblick darauf, wie viele Schwierigkeiten Sie bei der Durchführung der nachfolgenden Aktivitäten hatten.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
        questionId: "impair_1",
        text: "Wie viele Schwierigkeiten hatten Sie in den letzten 30 Tagen wegen Ihrer Internet- oder Smartphonenutzung, Ihren Haushaltspflichten nachzukommen?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Keine", value: 0),
          AnswerOption(label: "Geringe", value: 1),
          AnswerOption(label: "Mäßige", value: 2),
          AnswerOption(label: "Starke", value: 3),
          AnswerOption(label: "Sehr starke / nicht möglich", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "impair_2",
        text:
            "Wie viele Schwierigkeiten hatten Sie in den letzten 30 Tagen wegen Ihrer Internet- oder Smartphonenutzung an gesellschaftlichen Aktivitäten (wie z.B. Festlichkeiten, religiöse oder andere Aktivitäten) in der gleichen Art und Weise teilzunehmen wie jeder andere?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Keine", value: 0),
          AnswerOption(label: "Geringe", value: 1),
          AnswerOption(label: "Mäßige", value: 2),
          AnswerOption(label: "Starke", value: 3),
          AnswerOption(label: "Sehr starke / nicht möglich", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "impair_3",
        text: "Wie viele Schwierigkeiten hatten Sie in den letzten 30 Tagen wegen Ihrer Internet- oder Smartphonenutzung, sich für 10 Minuten auf etwas zu konzentrieren?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Keine", value: 0),
          AnswerOption(label: "Geringe", value: 1),
          AnswerOption(label: "Mäßige", value: 2),
          AnswerOption(label: "Starke", value: 3),
          AnswerOption(label: "Sehr starke / nicht möglich", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "impair_4",
        text: "Wie viele Schwierigkeiten hatten Sie in den letzten 30 Tagen wegen Ihrer Internet- oder Smartphonenutzung, eine Freundschaft zu knüpfen oder aufrechtzuerhalten?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Keine", value: 0),
          AnswerOption(label: "Geringe", value: 1),
          AnswerOption(label: "Mäßige", value: 2),
          AnswerOption(label: "Starke", value: 3),
          AnswerOption(label: "Sehr starke / nicht möglich", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "impair_5",
        text: "Wie viele Schwierigkeiten hatten Sie in den letzten 30 Tagen wegen Ihrer Internet- oder Smartphonenutzung bei der Bewältigung Ihres Arbeits-/Schulalltags?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Keine", value: 0),
          AnswerOption(label: "Geringe", value: 1),
          AnswerOption(label: "Mäßige", value: 2),
          AnswerOption(label: "Starke", value: 3),
          AnswerOption(label: "Sehr starke / nicht möglich", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "impair_6",
        text: "Wie sehr wurden Sie in den letzten 30 Tagen durch Ihre intensive Internet- oder Smartphonenutzung emotional belastet?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Gar nicht", value: 0),
          AnswerOption(label: "Wenig", value: 1),
          AnswerOption(label: "Weder noch", value: 2),
          AnswerOption(label: "Stark", value: 3),
          AnswerOption(label: "Sehr stark", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "impair_7",
        text: "An wie vielen Tagen traten diese Schwierigkeiten während der letzten 30 Tage auf?",
        type: AnswerFieldType.NUMBER_SLIDER,
        options: {"min": 1, "max": 30, "divisions": null, "trailing": " Tag(e)"}),
    QuestionnaireQuestion(
        questionId: "impair_8",
        text: "An ungefähr wie vielen Tagen in den letzten 30 Tagen waren Sie wegen Ihrer Internet- und Smartphonenutzung absolut unfähig, alltägliche Aktivitäten oder Ihre Arbeit zu verrichten?",
        type: AnswerFieldType.NUMBER_SLIDER,
        options: {"min": 0, "max": 30, "divisions": null, "trailing": " Tag(e)"}),
    QuestionnaireQuestion(
        questionId: "impair_9",
        text: "An ungefähr wie vielen Tagen in den letzten 30 Tagen mussten Sie wegen Ihrer Internet- oder Smartphonenutzung alltägliche Aktivitäten oder Ihre Arbeit reduzieren?",
        type: AnswerFieldType.NUMBER_SLIDER,
        options: {"min": 0, "max": 30, "divisions": null, "trailing": " Tag(e)"}),
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    if (answers[currentItemIndex].questionId == "impair_7") {
      if (sumUpAnswers() == 0) return true;
    }
    if (answers[currentItemIndex].questionId == "impair_8") {
      if (sumUpAnswers() == 0) return true;
    }
    if (answers[currentItemIndex].questionId == "impair_9") {
      if (sumUpAnswers() == 0) return true;
    }

    return false;
  }

  int sumUpAnswers() {
    var impair_1 = this.getAnswerById(answers, "impair_1")?.answerValues["value"];
    var impair_2 = this.getAnswerById(answers, "impair_2")?.answerValues["value"];
    var impair_3 = this.getAnswerById(answers, "impair_3")?.answerValues["value"];
    var impair_4 = this.getAnswerById(answers, "impair_4")?.answerValues["value"];
    var impair_5 = this.getAnswerById(answers, "impair_5")?.answerValues["value"];
    var impair_6 = this.getAnswerById(answers, "impair_6")?.answerValues["value"];
    int sum = impair_1 + impair_2 + impair_3 + impair_4 + impair_5 + impair_6;
    return sum;
  }
}
