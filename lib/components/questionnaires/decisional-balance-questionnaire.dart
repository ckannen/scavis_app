import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class DecisionalBalanceQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "decisional_balance";

  @override
  String introduction = "Das Internet kann Vor- und Nachteile haben. Wie sehen Sie das für sich selber? Wie hat das Internet Ihr Leben beeinflusst? Bitte geben Sie bei den folgenden Fragen an, inwieweit sich Ihr Leben in folgenden Bereichen geändert und welchen Einfluss das auf Ihre Internetnutzung hat.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "ausw_r_01", text: "Durch meine Internetnutzung ist meine Beziehung zu anderen Familienmitgliedern ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Viel schlechter geworden", value: 1),
      AnswerOption(label: "Eher schlechter geworden", value: 2),
      AnswerOption(label: "Gleich geblieben", value: 3),
      AnswerOption(label: "Eher besser geworden", value: 4),
      AnswerOption(label: "Viel besser geworden", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "db_01", text: "Dies ist für meine Überlegung, das Internet weniger zu nutzen, ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Überhaupt nicht wichtig", value: 1),
      AnswerOption(label: "Nicht wichtig", value: 2),
      AnswerOption(label: "Egal", value: 3),
      AnswerOption(label: "Wichtig", value: 4),
      AnswerOption(label: "Sehr wichtig", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "ausw_r_02", text: "Durch meine Internetnutzung ist mein allgemeines Wohlbefinden ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Viel schlechter geworden", value: 1),
      AnswerOption(label: "Eher schlechter geworden", value: 2),
      AnswerOption(label: "Gleich geblieben", value: 3),
      AnswerOption(label: "Eher besser geworden", value: 4),
      AnswerOption(label: "Viel besser geworden", value: 5),
      
    ]),
    QuestionnaireQuestion(questionId: "db_02", text: "Dies ist für meine Überlegung, das Internet weniger zu nutzen, ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Überhaupt nicht wichtig", value: 1),
      AnswerOption(label: "Nicht wichtig", value: 2),
      AnswerOption(label: "Egal", value: 3),
      AnswerOption(label: "Wichtig", value: 4),
      AnswerOption(label: "Sehr wichtig", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "ausw_r_03", text: "Durch meine Internetnutzung ist meine Gesundheit und Fitness ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Viel schlechter geworden", value: 1),
      AnswerOption(label: "Eher schlechter geworden", value: 2),
      AnswerOption(label: "Gleich geblieben", value: 3),
      AnswerOption(label: "Eher besser geworden", value: 4),
      AnswerOption(label: "Viel besser geworden", value: 5),
      
    ]),
    QuestionnaireQuestion(questionId: "db_03", text: "Dies ist für meine Überlegung, das Internet weniger zu nutzen, ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Überhaupt nicht wichtig", value: 1),
      AnswerOption(label: "Nicht wichtig", value: 2),
      AnswerOption(label: "Egal", value: 3),
      AnswerOption(label: "Wichtig", value: 4),
      AnswerOption(label: "Sehr wichtig", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "ausw_r_04", text: "Durch meine Internetnutzung ist meine Ernährung bzw. mein Essverhalten ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Viel schlechter geworden", value: 1),
      AnswerOption(label: "Eher schlechter geworden", value: 2),
      AnswerOption(label: "Gleich geblieben", value: 3),
      AnswerOption(label: "Eher besser geworden", value: 4),
      AnswerOption(label: "Viel besser geworden", value: 5),
      
    ]),
    QuestionnaireQuestion(questionId: "db_04", text: "Dies ist für meine Überlegung, das Internet weniger zu nutzen, ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Überhaupt nicht wichtig", value: 1),
      AnswerOption(label: "Nicht wichtig", value: 2),
      AnswerOption(label: "Egal", value: 3),
      AnswerOption(label: "Wichtig", value: 4),
      AnswerOption(label: "Sehr wichtig", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "ausw_r_05", text: "Durch meine Internetnutzung ist meine Erledigung von Pflichten und Aufgaben ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Viel schlechter geworden", value: 1),
      AnswerOption(label: "Eher schlechter geworden", value: 2),
      AnswerOption(label: "Gleich geblieben", value: 3),
      AnswerOption(label: "Eher besser geworden", value: 4),
      AnswerOption(label: "Viel besser geworden", value: 5),
      
    ]),
    QuestionnaireQuestion(questionId: "db_05", text: "Dies ist für meine Überlegung, das Internet weniger zu nutzen, ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Überhaupt nicht wichtig", value: 1),
      AnswerOption(label: "Nicht wichtig", value: 2),
      AnswerOption(label: "Egal", value: 3),
      AnswerOption(label: "Wichtig", value: 4),
      AnswerOption(label: "Sehr wichtig", value: 5),
    ]),
    QuestionnaireQuestion(
        questionId: "ausw_r_06",
        text: "Durch meine Internetnutzung ist mein nervlicher und seelischer Zustand (z.B. Gefühle, Laune) ...",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Viel schlechter geworden", value: 1),
          AnswerOption(label: "Eher schlechter geworden", value: 2),
          AnswerOption(label: "Gleich geblieben", value: 3),
          AnswerOption(label: "Eher besser geworden", value: 4),
          AnswerOption(label: "Viel besser geworden", value: 5),
          
        ]),
    QuestionnaireQuestion(questionId: "db_06", text: "Dies ist für meine Überlegung, das Internet weniger zu nutzen, ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Überhaupt nicht wichtig", value: 1),
      AnswerOption(label: "Nicht wichtig", value: 2),
      AnswerOption(label: "Egal", value: 3),
      AnswerOption(label: "Wichtig", value: 4),
      AnswerOption(label: "Sehr wichtig", value: 5),
    ]),
    QuestionnaireQuestion(questionId: "ausw_r_07", text: "Durch meine Internetnutzung ist mein Freizeitleben ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Viel schlechter geworden", value: 1),
      AnswerOption(label: "Eher schlechter geworden", value: 2),
      AnswerOption(label: "Gleich geblieben", value: 3),
      AnswerOption(label: "Eher besser geworden", value: 4),
      AnswerOption(label: "Viel besser geworden", value: 5),
      
    ]),
    QuestionnaireQuestion(questionId: "db_07", text: "Dies ist für meine Überlegung, das Internet weniger zu nutzen, ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Überhaupt nicht wichtig", value: 1),
      AnswerOption(label: "Nicht wichtig", value: 2),
      AnswerOption(label: "Egal", value: 3),
      AnswerOption(label: "Wichtig", value: 4),
      AnswerOption(label: "Sehr wichtig", value: 5),
    ]),
    QuestionnaireQuestion(
        questionId: "ausw_r_08",
        text: "Durch meine Internetnutzung ist mein Kontakt zu Real-Welt-Freund*innen (Leute, die Sie persönlich und nicht nur im Internet treffen) ...",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Viel schlechter geworden", value: 1),
          AnswerOption(label: "Eher schlechter geworden", value: 2),
          AnswerOption(label: "Gleich geblieben", value: 3),
          AnswerOption(label: "Eher besser geworden", value: 4),
          AnswerOption(label: "Viel besser geworden", value: 5),
          
        ]),
    QuestionnaireQuestion(questionId: "db_08 _08", text: "Dies ist für meine Überlegung, das Internet weniger zu nutzen, ...", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Überhaupt nicht wichtig", value: 1),
      AnswerOption(label: "Nicht wichtig", value: 2),
      AnswerOption(label: "Egal", value: 3),
      AnswerOption(label: "Wichtig", value: 4),
      AnswerOption(label: "Sehr wichtig", value: 5),
    ]),
  ];
}