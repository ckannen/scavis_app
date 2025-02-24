import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class HomeOffice1Questionnaire extends QuestionnaireTemplate {
  @override
  String id = "17_CB_COVID_Home-Office_Teil1";

  @override
  String introduction = "Uns interessiert auch der Einfluss der aktuellen COVID-19 Pandemie auf Ihr Leben. Wie belastet sind Sie durch die COVID-19 Pandemie in folgenden Bereichen?";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "homeOffice_1_1", text: "Arbeit", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (überhaupt nicht belastet)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (sehr stark belastet)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "homeOffice_1_2", text: "Finanzen", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (überhaupt nicht belastet)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (sehr stark belastet)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "homeOffice_1_3", text: "Gesundheit", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (überhaupt nicht belastet)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (sehr stark belastet)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "homeOffice_1_4", text: "Familie", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (überhaupt nicht belastet)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (sehr stark belastet)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "homeOffice_1_5", text: "Freund*innen / Bekannte", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (überhaupt nicht belastet)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (sehr stark belastet)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "homeOffice_1_6", text: "Allgemein", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "0 (überhaupt nicht belastet)", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5", value: 5),
      AnswerOption(label: "6", value: 6),
      AnswerOption(label: "7", value: 7),
      AnswerOption(label: "8", value: 8),
      AnswerOption(label: "9", value: 9),
      AnswerOption(label: "10 (sehr stark belastet)", value: 10)
    ]),
    QuestionnaireQuestion(questionId: "homeOffice_1_7", text: "Hat sich durch die COVID-19 Pandemie Ihre Internetnutzung verändert? ", type: AnswerFieldType.SELECTION_SLIDER, answerOptions: [
      AnswerOption(label: "-5 (weniger geworden)", value: -5),
      AnswerOption(label: "-4", value: -4),
      AnswerOption(label: "-3", value: -3),
      AnswerOption(label: "-2", value: -2),
      AnswerOption(label: "-1", value: -1),
      AnswerOption(label: "0", value: 0),
      AnswerOption(label: "1", value: 1),
      AnswerOption(label: "2", value: 2),
      AnswerOption(label: "3", value: 3),
      AnswerOption(label: "4", value: 4),
      AnswerOption(label: "5 (mehr geworden)", value: 5),
    ]),
    QuestionnaireQuestion(
      questionId: "homeOffice_1_8",
      text: "Wurde bei Ihnen bereits COVID-19 diagnostiziert?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "homeOffice_1_9",
      text: "Wurden Sie bereits gegen COVID-19 geimpft?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja, ich habe bereits alle nötigen Impfungen erhalten", value: 1),
        AnswerOption(label: "Ja, ich habe bereits eine der nötigen Impfungen erhalten", value: 2),
        AnswerOption(label: "Nein, aber ich möchte mich impfen lassen", value: 3),
        AnswerOption(label: "Nein, ich möchte auch nicht geimpft werden", value: 4),
      ],
    ),
  ];
}
