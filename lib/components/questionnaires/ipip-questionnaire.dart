import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class IpipQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "20-CB-Mini-IPIP";

  @override
  String introduction = "Im Folgenden geht es darum, wie Sie sich selbst sehen.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "mini_ipip_1", text: "Ich bringe Leben in eine Party.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_2", text: "Ich interessiere mich nicht für die Probleme anderer Leute.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_3", text: "Ich verpfusche die Dinge.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_4", text: "Ich bin schnell stressgeplagt.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_5", text: "Ich habe Schwierigkeiten abstrakte Ideen zu verstehen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_6", text: "Ich halte mich im Hintergrund.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_7", text: "Ich kann die Emotionen anderer nachempfinden.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_8", text: "Ich erledige Hausarbeit sofort.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_9", text: "Ich bin die meiste Zeit entspannt.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_10", text: "Ich habe eine lebhafte Vorstellungskraft.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_11", text: "Auf Partys unterhalte ich mich mit vielen verschiedenen Leuten.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_12", text: "Ich interessiere mich nicht wirklich für andere.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_13", text: "Ich vergesse oft, Dinge wieder an den richtigen Platz zurück zu bringen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_14", text: "Ich fühle mich selten traurig.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_15", text: "Ich interessiere mich nicht für abstrakte Ideen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_16", text: "Ich rede nicht viel.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_17", text: "Ich kann die Gefühle anderer nachfühlen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_18", text: "Ich mag Ordnung.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_19", text: "Meine Laune ändert sich häufig.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "mini_ipip_20", text: "Ich habe hervorragende Ideen.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Sehr unzutreffend", value: 1),
      AnswerOption(label: "Unzutreffend", value: 2),
      AnswerOption(label: "Neutral", value: 3),
      AnswerOption(label: "Zutreffend", value: 4),
      AnswerOption(label: "Sehr zutreffend", value: 5),
    ])
  ];
}
