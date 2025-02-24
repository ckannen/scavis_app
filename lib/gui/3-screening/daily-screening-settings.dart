import 'package:scavis/components/questionnaires/bergen-work-addiction-scale-questionnaire.dart';
import 'package:scavis/components/questionnaires/cius-questionnaire.dart';
import 'package:scavis/components/questionnaires/decisional-balance-i-questionnaire.dart';
import 'package:scavis/components/questionnaires/f-sozu-k6-questionnaire.dart';
import 'package:scavis/components/questionnaires/fomo-single-and-mood-questionnaire.dart';
import 'package:scavis/components/questionnaires/icat-short-1-questionnaire.dart';
import 'package:scavis/components/questionnaires/icat-short-28-questionnaire.dart';
import 'package:scavis/components/questionnaires/iues-1-questionnaire.dart';
import 'package:scavis/components/questionnaires/iues-22-questionnaire.dart';
import 'package:scavis/components/questionnaires/loneliness-scale-questionnaire.dart';
import 'package:scavis/components/questionnaires/need-to-belong-questionnaire.dart';
import 'package:scavis/components/questionnaires/prism-internet-questionnaire.dart';
import 'package:scavis/components/questionnaires/readiness-self-efficacy-questionnaire.dart';
import 'package:scavis/components/questionnaires/spec-self-efficacy-questionnaire.dart';
import 'package:scavis/components/questionnaires/tks-wlb-questionnaire.dart';
import 'package:scavis/components/questionnaires/whodas-questionnaire.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-1-iues-intervention.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-14-mood-intervention.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-15-fomo-intervention.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-15-readiness-ruler-intervention.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-15-self-efficacy-ruler-intervention.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-22-fomo-intervention.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-22-iues-intervention.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-28-icat-intervention.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-8-decisional-balance.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-8-fomo-intervention.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-8-readiness-ruler.dart';
import 'package:scavis/gui/2b-feedback/intervention/day-8-specific-self-efficacy.dart';
import 'package:scavis/gui/5-finished-group/abort-intervention.group.dart';
import 'package:scavis/survey/components/template/survey-content-template.dart';

class DaySettings {
  int day;
  List<SurveyContentTemplate> questionnaires;
  List<int> expiry;
  String introText;
  String finishText;
  String returnRoute;

  DaySettings({this.day, this.questionnaires, this.expiry, this.introText, this.finishText, this.returnRoute});
}

class DailyScreeningSettings {
  static const String _DEFAULT_INTRO_TEXT = "Herzlich Willkommen zu Ihrer täglichen Abfrage.";
  static const String _DEFAULT_FINISH_TEXT = "Vielen Dank. Sie haben die Abfrage vollständig ausgefüllt. Wir sehen uns morgen.";

  static List<DaySettings> days = [
    DaySettings(
      day: 1,
      questionnaires: [
        IcatShort1Questionnaire(),
        WhodasQuestionnaire(),
        PrismInternetQuestionnaire(),
        Iues1Questionnaire(),
        Day1IuesIntervention(),
        ReadinessSelfEfficacyQuestionnaire(),
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400*27, 86400*27, 86400*21, 86400*21, 86400*14, 86400],
      introText:
          "Herzlich Willkommen zu Ihrer ersten täglichen Abfrage.\nIn den nächsten vier Wochen möchten wir Ihnen täglich einige kurze Fragen stellen. Dabei fragen wir oft die gleichen Dinge, um Ihnen in dieser App Ihre Entwicklung über die Zeit rückmelden zu können.",
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: AbortInterventionGroupScreen.ROUTE,
    ),
    DaySettings(
      day: 2,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 3,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 4,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 5,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 6,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 7,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 8,
      questionnaires: [
        ReadinessSelfEfficacyQuestionnaire(),
        Day8ReadinessRulerIntervention(),
        DecisionalBalanceIQuestionnaire(),
        Day8DecisionalBalanceIntervention(),
        SpecificSelfEfficacyQuestionnaire(),
        Day8SpecificSelfEfficacyIntervention(),
        FomoSingleAndMoodQuestionnaire(),
        Day8FomoIntervention(),
      ],
      expiry: [null, 86400*19, 86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 9,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 10,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 11,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 12,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 13,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 14,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
        Day14MoodIntervention(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 15,
      questionnaires: [
        TksWlbQuestionnaire(),
        ReadinessSelfEfficacyQuestionnaire(),
        Day15ReadinessRulerIntervention(),
        Day15SelfEfficacyRulerIntervention(),
        BergenWorkAddictionScaleQuestionnaire(),
        FomoSingleAndMoodQuestionnaire(),
        Day15FomoIntervention(),
        LonelinessScaleQuestionnaire(),
      ],
      expiry: [null, 86400*12, null, 86400, null],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 16,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 17,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 18,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 19,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 20,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 21,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 22,
      questionnaires: [
        PrismInternetQuestionnaire(),
        Iues22Questionnaire(),
        Day22IuesIntervention(),
        FomoSingleAndMoodQuestionnaire(),
        Day22FomoIntervention(),
        NeedToBelongQuestionnaire(),
        FSozuK6Questionnaire(),
      ],
      expiry: [null, null, 86400, null, null],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 23,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 24,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 25,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 26,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 27,
      questionnaires: [
        FomoSingleAndMoodQuestionnaire(),
      ],
      expiry: [86400],
      introText: _DEFAULT_INTRO_TEXT,
      finishText: _DEFAULT_FINISH_TEXT,
      returnRoute: null,
    ),
    DaySettings(
      day: 28,
      questionnaires: [
        IcatShort28Questionnaire(),
        Day28IcatIntervention(),
        WhodasQuestionnaire(),
        FomoSingleAndMoodQuestionnaire(),
        ReadinessSelfEfficacyQuestionnaire(),
        CiusQuestionnaire(),
        DecisionalBalanceIQuestionnaire(),
      ],
      expiry: [null, null, null, null, null, null],
      introText: "Herzlich Willkommen zu Ihrer letzten täglichen Abfrage.",
      finishText: "Vielen Dank. Sie haben die Abfrage vollständig ausgefüllt. Sollten Sie das optionale Tracking aktiviert haben, so endet dieses automatisch heute Abend um 23 Uhr.",
      returnRoute: null,
    ),
  ];
}