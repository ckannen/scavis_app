import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class SofalizingQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "6_CB_Sofalizing_Scale";

  @override
  String introduction = "Im Folgenden interessiert uns Ihre Einschätzung zu Sozialen Medien und zu Ihren Freund*innen.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "sofalizing_1", text: "Ich treffe mich lieber online mit meinen Freund*innen als persönlich.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(
        questionId: "sofalizing_2",
        text: "Meine Freund*innen in Sozialen Medien zu treffen ist das gleiche, wie sie persönlich zu treffen.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(questionId: "sofalizing_3", text: "Wenn ich mit meinen Freund*innen draußen bin, wünschte ich, ich wäre zu Hause.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(
        questionId: "sofalizing_4",
        text: "Die meisten Dinge, die ich mit meinen Freund*innen mache, können wir auch im Online-Kontext tun.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "sofalizing_5",
        text: "Es ist einfacher, Gespräche über Soziale Medien zu führen als sich im echten Leben zu treffen.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(questionId: "sofalizing_6", text: "Wenn ich allein bin, verbringe ich Zeit in Sozialen Medien.", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Nie", value: 0),
      AnswerOption(label: "Selten", value: 1),
      AnswerOption(label: "Manchmal", value: 2),
      AnswerOption(label: "Häufig", value: 3),
      AnswerOption(label: "Sehr häufig", value: 4),
    ]),
    QuestionnaireQuestion(
        questionId: "sofalizing_7",
        text: "Ich denke, dass die Gruppen, denen ich in Sozialen Medien beitrete, eine Bedeutung für mein soziales Leben haben.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "sofalizing_8",
        text: "Selbst wenn ich mich im wirklichen Leben nicht mit meiner Familie und meinen Freund*innen treffen kann, fühle ich mich ihnen aufgrund der Sozialen Medien immer noch nahe.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "sofalizing_9",
        text: "Ich habe das Gefühl, soziale Kontakte zu pflegen, während ich im Online-Kontext kommuniziere.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "sofalizing_10",
        text: "Auch wenn ich im wirklichen Leben tatsächlich allein bin, sobald ich mich bei den Sozialen Medien einlogge, fühle ich mich nicht allein.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ]),
    QuestionnaireQuestion(
        questionId: "sofalizing_11",
        text: "Ich gleiche meine Bedürfnisse nach Kommunikation und Zusammensein mit anderen über Soziale Medien aus.",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Nie", value: 0),
          AnswerOption(label: "Selten", value: 1),
          AnswerOption(label: "Manchmal", value: 2),
          AnswerOption(label: "Häufig", value: 3),
          AnswerOption(label: "Sehr häufig", value: 4),
        ])
  ];
}
