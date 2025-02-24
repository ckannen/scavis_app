import 'package:scavis/components/input-elements/number-slider.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class Iues1Questionnaire extends QuestionnaireTemplate {
  // Iues for day 1 and day 22 are slightly different in wording, but share the same id, also for the backend calculation
  @override
  String id = "iues";

  @override
  String introduction = "Bitte lesen Sie die folgenden Feststellungen aufmerksam durch und wählen Sie die Antwortalternative aus, die für Sie am zutreffendsten ist.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "estimate",
      text: "Was glauben Sie, wie lange Sie sich täglich durchschnittlich mit Ihrem Smartphone beschäftigen?",
      type: AnswerFieldType.NUMBER_SLIDER,
      options: {"numberType": NumberSliderNumberType.DOUBLE, "min": 0, "max": 1440, "trailing": " Minute(n)"},
    ),
    QuestionnaireQuestion(
      questionId: "iues_1",
      text: "Ich nutze das Internet, weil es mir ermöglicht / erleichtert, Freude zu erleben.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Stimme gar nicht zu", value: 1),
        AnswerOption(label: "Stimme nicht zu", value: 2),
        AnswerOption(label: "Stimme eher nicht zu", value: 3),
        AnswerOption(label: "Stimme eher zu", value: 4),
        AnswerOption(label: "Stimme zu", value: 5),
        AnswerOption(label: "Stimme voll und ganz zu", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "iues_2",
      text: "Ich nutze das Internet, weil es mir ermöglicht / erleichtert, Problemen aus dem Weg zu gehen.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Stimme gar nicht zu", value: 1),
        AnswerOption(label: "Stimme nicht zu", value: 2),
        AnswerOption(label: "Stimme eher nicht zu", value: 3),
        AnswerOption(label: "Stimme eher zu", value: 4),
        AnswerOption(label: "Stimme zu", value: 5),
        AnswerOption(label: "Stimme voll und ganz zu", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "iues_3",
      text: "Ich nutze das Internet, weil es mir ermöglicht / erleichtert, Spaß zu haben.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Stimme gar nicht zu", value: 1),
        AnswerOption(label: "Stimme nicht zu", value: 2),
        AnswerOption(label: "Stimme eher nicht zu", value: 3),
        AnswerOption(label: "Stimme eher zu", value: 4),
        AnswerOption(label: "Stimme zu", value: 5),
        AnswerOption(label: "Stimme voll und ganz zu", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "iues_4",
      text: "Ich nutze das Internet, weil es mir ermöglicht / erleichtert, Gefühle der Einsamkeit zu vermeiden.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Stimme gar nicht zu", value: 1),
        AnswerOption(label: "Stimme nicht zu", value: 2),
        AnswerOption(label: "Stimme eher nicht zu", value: 3),
        AnswerOption(label: "Stimme eher zu", value: 4),
        AnswerOption(label: "Stimme zu", value: 5),
        AnswerOption(label: "Stimme voll und ganz zu", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "iues_5",
      text: "Ich nutze das Internet, weil es mir ermöglicht / erleichtert, mich gut zu fühlen.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Stimme gar nicht zu", value: 1),
        AnswerOption(label: "Stimme nicht zu", value: 2),
        AnswerOption(label: "Stimme eher nicht zu", value: 3),
        AnswerOption(label: "Stimme eher zu", value: 4),
        AnswerOption(label: "Stimme zu", value: 5),
        AnswerOption(label: "Stimme voll und ganz zu", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "iues_6",
      text: "Ich nutze das Internet, weil es mir ermöglicht / erleichtert, vor der Realität zu flüchten.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Stimme gar nicht zu", value: 1),
        AnswerOption(label: "Stimme nicht zu", value: 2),
        AnswerOption(label: "Stimme eher nicht zu", value: 3),
        AnswerOption(label: "Stimme eher zu", value: 4),
        AnswerOption(label: "Stimme zu", value: 5),
        AnswerOption(label: "Stimme voll und ganz zu", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "iues_7",
      text: "Ich nutze das Internet, weil es mir ermöglicht / erleichtert, positive Gefühle zu erreichen.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Stimme gar nicht zu", value: 1),
        AnswerOption(label: "Stimme nicht zu", value: 2),
        AnswerOption(label: "Stimme eher nicht zu", value: 3),
        AnswerOption(label: "Stimme eher zu", value: 4),
        AnswerOption(label: "Stimme zu", value: 5),
        AnswerOption(label: "Stimme voll und ganz zu", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "iues_8",
      text: "Ich nutze das Internet, weil es mir ermöglicht / erleichtert, lästige Aufgaben zu vermeiden.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Stimme gar nicht zu", value: 1),
        AnswerOption(label: "Stimme nicht zu", value: 2),
        AnswerOption(label: "Stimme eher nicht zu", value: 3),
        AnswerOption(label: "Stimme eher zu", value: 4),
        AnswerOption(label: "Stimme zu", value: 5),
        AnswerOption(label: "Stimme voll und ganz zu", value: 6),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "estimate_hours",
      text: "Was glauben Sie, wie lange Sie sich täglich durchschnittlich mit Ihrem Smartphone beschäftigen?",
      type: AnswerFieldType.NUMBER_SLIDER,
      options: {"numberType": NumberSliderNumberType.DOUBLE, "min": 0, "max": 24, "divisions": 96, "trailing": " Stunde(n)"},
    ),
  ];
}
