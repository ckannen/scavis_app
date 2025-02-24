import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class FSozuK6Questionnaire extends QuestionnaireTemplate {
  @override
  String id = "f_sozu_k_6";

  @override
  String introduction = "Nun geht es um Ihre Beziehungen zu Menschen, die Ihnen wichtig sind, also zur/zum Partner*in, Freund*innen, Kolleg*innen, Nachbar*innen. Wir möchten erfahren, wie Sie diese Beziehungen im Allgemeinen erleben und einschätzen. Bitte klicken Sie an, inwieweit die jeweilige Feststellung auf Sie zutrifft.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "fsozuk6_1",
      text: "Ich erfahre von anderen viel Verständnis und Geborgenheit.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Trifft nicht zu", value: 1),
        AnswerOption(label: "Trifft eher nicht zu", value: 2),
        AnswerOption(label: "Trifft teilweise zu", value: 3),
        AnswerOption(label: "Trifft zu", value: 4),
        AnswerOption(label: "Trifft genau zu", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "fsozuk6_2",
      text: "Ich habe einen sehr vertrauten Menschen, mit dessen Hilfe ich immer rechnen kann.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Trifft nicht zu", value: 1),
        AnswerOption(label: "Trifft eher nicht zu", value: 2),
        AnswerOption(label: "Trifft teilweise zu", value: 3),
        AnswerOption(label: "Trifft zu", value: 4),
        AnswerOption(label: "Trifft genau zu", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "fsozuk6_3",
      text: "Bei Bedarf kann ich mir ohne Probleme bei Freund*innen oder Nachbar*innen etwas ausleihen.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Trifft nicht zu", value: 1),
        AnswerOption(label: "Trifft eher nicht zu", value: 2),
        AnswerOption(label: "Trifft teilweise zu", value: 3),
        AnswerOption(label: "Trifft zu", value: 4),
        AnswerOption(label: "Trifft genau zu", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "fsozuk6_4",
      text: "Ich kenne mehrere Menschen, mit denen ich gerne etwas unternehme.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Trifft nicht zu", value: 1),
        AnswerOption(label: "Trifft eher nicht zu", value: 2),
        AnswerOption(label: "Trifft teilweise zu", value: 3),
        AnswerOption(label: "Trifft zu", value: 4),
        AnswerOption(label: "Trifft genau zu", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "fsozuk6_5",
      text: "Wenn ich krank bin, kann ich ohne Zögern Freund*innen / Angehörige bitten, wichtige Dinge für mich zu erledigen.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Trifft nicht zu", value: 1),
        AnswerOption(label: "Trifft eher nicht zu", value: 2),
        AnswerOption(label: "Trifft teilweise zu", value: 3),
        AnswerOption(label: "Trifft zu", value: 4),
        AnswerOption(label: "Trifft genau zu", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "fsozuk6_6",
      text: "Wenn ich mal sehr bedrückt bin, weiß ich, zu wem ich damit ohne Weiteres gehen kann.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Trifft nicht zu", value: 1),
        AnswerOption(label: "Trifft eher nicht zu", value: 2),
        AnswerOption(label: "Trifft teilweise zu", value: 3),
        AnswerOption(label: "Trifft zu", value: 4),
        AnswerOption(label: "Trifft genau zu", value: 5),
      ],
    ),
  ];
}
