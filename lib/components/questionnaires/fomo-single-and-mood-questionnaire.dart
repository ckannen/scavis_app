import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class FomoSingleAndMoodQuestionnaire extends QuestionnaireTemplate {
  @override
  String id = "fomo_single_and_mood";

  @override
  String introduction = "Bitte beantworten Sie in den folgenden Fragen, wie Sie den heutigen Tag erlebt haben.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(
      questionId: "mood",
      text: "Wie würden Sie Ihre Stimmung heute beschreiben?",
      type: AnswerFieldType.SELECTION_SLIDER,
      answerOptions: [
        AnswerOption(label: "Sehr schlecht", value: 1),
        AnswerOption(label: "Schlecht", value: 2),
        AnswerOption(label: "Neutral", value: 3),
        AnswerOption(label: "Gut", value: 4),
        AnswerOption(label: "Sehr gut", value: 5),
      ],
      options: {
        "images": [
          "assets/questionnaires/images/smiley-1.png",
          "assets/questionnaires/images/smiley-2.png",
          "assets/questionnaires/images/smiley-3.png",
          "assets/questionnaires/images/smiley-4.png",
          "assets/questionnaires/images/smiley-5.png",
        ],
        "defaultImage": "assets/questionnaires/images/smiley-0.png",
      },
    ),
    QuestionnaireQuestion(
      questionId: "fomo_si1",
      text: "Ich hatte heute Angst, in meinem sozialen Umfeld etwas zu verpassen.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Sehr unzutreffend", value: 1),
        AnswerOption(label: "Unzutreffend", value: 2),
        AnswerOption(label: "Teils / teils", value: 3),
        AnswerOption(label: "Zutreffend", value: 4),
        AnswerOption(label: "Sehr zutreffend", value: 5),
      ],
    ),
    QuestionnaireQuestion(
      questionId: "fomo_si2",
      text: "Ich hatte heute Angst, auf Social Media etwas zu verpassen.",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Sehr unzutreffend", value: 1),
        AnswerOption(label: "Unzutreffend", value: 2),
        AnswerOption(label: "Teils / teils", value: 3),
        AnswerOption(label: "Zutreffend", value: 4),
        AnswerOption(label: "Sehr zutreffend", value: 5),
      ],
    ),
  ];
}