import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';

class Day8SpecificSelfEfficacyIntervention extends ActionFlowTemplate {
  @override
  String id = "day8_intervention_specific_self_efficacy";

  String seqDecision;

  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();

    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      seqDecision = questionnaireResults["specificSelfEfficacy"]["computation"]["decision-on-day-8"];
      if (seqDecision == null) throw ("value not found");
    } catch (e) {
      print("could not access data");
      return false;
    }
    return true;
  }

  @override
  Future<bool> init() async {
    await super.init();

    // load the results data from the database
    bool success = await loadFromDb();
    if (!success) return false;
    
    flow = ActionFlow(
      initialStateId: "SEQ",
      states: [
        FlowDecision(
          id: "SEQ",
          decide: () {
            if (seqDecision == "High")
              return "se_high1";
            else
              return "se_low1";
          },
        ),

        // path from se_sum to se_high_end
        FlowQuestionState(id: "se_high1", content: "Großartig, Sie haben gute Erfolgsaussichten, um eine Veränderung zu erreichen. Manche Menschen finden persönliche Stärken hilfreich, um die Zuversicht für eine Änderung des eigenen Verhaltens zu steigern. Persönliche Stärken können zum Beispiel Durchhaltevermögen, Unterstützung durch andere oder die Erinnerung an vergangene Erfolge sein. Was hilft Ihnen dabei, Ihre Selbstsicherheit zu stärken, dass Sie in der Lage sind, sich zu ändern?", answers: [
          FlowAnswerText(id: "se_high1_res"),
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "se_high2"),
        ]),
        FlowQuestionState(id: "se_high2", content: "Danke für Ihre Antwort! Andere haben gesagt, dass es ihre Zuversicht stärken würde, wenn sie (A) einfach damit anfangen und erleben, dass sie erfolgreich sein können; (B) alternative Aktivitäten finden können; (C) technische Unterstützung wie Erinnerungen oder Ermutigungen bekommen. Welche Alternative wäre für Sie am vielversprechendsten?", answers: [
          FlowAnswerButton(value: 1, text: "(A) Einfach anfangen und erleben, damit erfolgreich zu sein", gotoId: "se_high_end"),
          FlowAnswerButton(value: 2, text: "(B) Alternative Aktivitäten zur Internetnutzung finden", gotoId: "se_high_end"),
          FlowAnswerButton(value: 3, text: "(C) Technische Unterstützung wie Erinnerungen bekommen", gotoId: "se_high_end"),
        ]),
        FlowQuestionState(id: "se_high_end", content: "Gute Wahl. Möchten Sie mehr Informationen dazu?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "se_high_end_yes"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "se_high_end_no"),
        ]),

        FlowQuestionState(id: "se_low1", content: "Es scheint, als hätten Sie bereits ein gewisses Vertrauen in sich selbst, benötigen aber noch ein paar hilfreiche Bedingungen, um es zu schaffen. Was könnte Ihnen helfen, Ihr Selbstvertrauen zu stärken?", answers: [
          FlowAnswerButton(value: 1, text: "(A) Der Glaube an meine persönlichen Stärken", gotoId: "se_low1_abc"),
          FlowAnswerButton(value: 2, text: "(B) Unterstützung durch andere", gotoId: "se_low1_abc"),
          FlowAnswerButton(value: 3, text: "(C) Der Blick auf vergangene Erfolge", gotoId: "se_low1_abc"),
          FlowAnswerButton(value: 3, text: "(D) Keine der Möglichkeiten", gotoId: "se_low2"),
        ]),

        FlowQuestionState(id: "se_low2", content: "Was könnte sonst noch hilfreich sein? Im Textfeld können Sie Ihre Ideen eintragen. Machen Sie sich keine Sorgen, falls Sie im Moment keine Idee haben. Das ändert sich möglicherweise, wenn Sie diese App weiter nutzen.", answers: [
          FlowAnswerText(id: "se_low2_res"),
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "se_low3"),
        ]),
        FlowQuestionState(id: "se_low3", content: "Vielen Dank! Interessiert es Sie, was für andere hilfreich war?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "se_high2"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "se_low3_no"),
        ]),

        FlowEndState(id: "se_high_end_yes", content: "Los geht's!", link: "https://www.geo.de/wissen/gesundheit/21302-rtkl-positives-denken-mit-diesen-strategien-kann-es-jeder-trainieren"),
        FlowEndState(id: "se_high_end_no", content: "Okay, kein Problem. Dann lassen Sie uns zum nächsten Thema übergehen."),
        FlowEndState(id: "se_low3_no", content: "Okay, kein Problem. Dann lassen Sie uns zum nächsten Thema übergehen."),
        FlowEndState(id: "se_low1_abc", content: "Ausgezeichnet! Das ist genau das, was andere auch als hilfreich erachtet haben."),
      ],
    );

    return true;
  }
}