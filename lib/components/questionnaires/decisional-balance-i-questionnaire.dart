import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class DecisionalBalanceIQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "decisional_balance_i";

  @override
  String introduction = "Wie wichtig sind für Sie zum jetzigen Zeitpunkt die folgenden Aussagen in Bezug auf Ihre privaten Online-Aktivitäten?";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "dbq-i_1", text: "Meine Online-Aktivitäten führen dazu, dass meine Beziehung zu anderen schlechter geworden ist.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_2", text: "Online zu sein hilft gegen Langeweile.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_3", text: "Meine Online-Aktivitäten führen dazu, dass ich Aufgaben zu Hause und/oder bei der Arbeit nicht mehr gut erledige.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_4", text: "Durch meine Online-Aktivitäten kann ich besser mit meinen Sorgen umgehen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_5", text: "Meine Online-Aktivitäten führen zu einer Verschlechterung meines seelischen Zustands (z.B. Gefühle, Laune).", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_6", text: "Meine Online-Aktivitäten helfen mir dabei, Spaß und Kontakt mit anderen zu haben.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_7", text: "Meine Online-Aktivitäten verursachen Probleme mit anderen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_8", text: "Zeit online zu verbringen hilft mir dabei, Kraft zu schöpfen und weiterzumachen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_9", text: "Meine Online-Aktivitäten führen dazu, dass ich andere Freizeitaktivitäten vernachlässige, die mir wichtig sind.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_10", text: "Ohne Internet wäre mein Leben stumpfsinnig und langweilig.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_11", text: "Meine Online-Aktivitäten führen dazu, dass ich weniger auf Ernährung und Fitness achte.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "dbq-i_12", text: "Meine Online-Aktivitäten helfen mir, mich zu entspannen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "stimme überhaupt nicht zu", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "stimme sehr zu", value: 5),
    ]),
  ];
}