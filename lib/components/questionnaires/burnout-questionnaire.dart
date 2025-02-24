import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class BurnoutQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "11_CB_Burnout";

  @override
  String introduction = "Wenn man beruflich lange Zeit sehr gestresst oder überfordert ist, kann ein Zustand tiefer emotionaler, körperlicher und geistiger Erschöpfung entstehen. Das nennt man Burnout. Betroffene können sich schlecht konzentrieren, sind sehr erschöpft und (auch in der Freizeit) nicht mehr in der Lage abzuschalten. Auch Gefühle mangelnder Anerkennung, Distanziertheit oder Depressivität können Symptome sein.\n\nWählen Sie im Folgenden die Aussage aus, die am meisten auf Sie zutrifft.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "burnout", text: "", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ich genieße meine Arbeit. Ich habe keine Symptome eines Burnout.", value: 1),
      AnswerOption(label: "Gelegentlich stehe ich unter Stress und ich habe nicht immer so viel Energie wie früher, aber ich fühle mich nicht ausgebrannt.", value: 2),
      AnswerOption(label: "Ich bin definitiv ausgebrannt und habe ein oder mehrere Burnout-Symptome, wie körperliche und emotionale Erschöpfung.", value: 3),
      AnswerOption(label: "Die Symptome des Burnout, die ich erlebe, gehen nicht weg. Ich denke viel über Enttäuschungen bei der Arbeit nach.", value: 4),
      AnswerOption(label: "Ich fühle mich völlig ausgebrannt und frage mich oft, ob ich weitermachen kann. Ich bin an dem Punkt angelangt, an dem ich vielleicht einige Veränderungen brauche oder Hilfe suchen muss.", value: 5),
    ])
  ];
}
