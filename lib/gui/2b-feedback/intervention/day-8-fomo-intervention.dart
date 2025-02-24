import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';

class Day8FomoIntervention extends ActionFlowTemplate {
  @override
  String id = "day8_intervention_fomo";

  String fomoDecision;

  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();

    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      fomoDecision = questionnaireResults["dailyFoMO"]["computation"]["decision-on-day-8"];
      if (fomoDecision == null) throw ("value not found");
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
      initialStateId: "FoMo",
      states: [
        FlowDecision(
            id: "FoMo",
            decide: () {
              if (fomoDecision == "Low")
                return "f_low";
              else
                return "fh1";
            }),
        FlowQuestionState(
            id: "fh1",
            content:
                "Ihren Angaben zufolge neigen Sie dazu, oft online zu sein, und machen sich Sorgen, online etwas Wichtiges zu verpassen. Dies wird 'Fear of Missing Out' oder 'FoMO' genannt. Davon haben Sie vielleicht schon gehört. Für manche Menschen kann sich das stressig anfühlen. Wie ist es bei Ihnen? Sind Sie nervös oder angespannt beim Gedanken, dass Sie online etwas verpassen könnten?",
            answers: [
              FlowAnswerButton(value: 1, text: "Ja", gotoId: "fh1y"),
              FlowAnswerButton(value: 0, text: "Nein", gotoId: "fh_no"),
            ]),
        FlowQuestionState(id: "fh1y", content: "Andere Personen, die diese Erfahrung gemacht haben, fühlten sich motiviert, ihr Online-Verhalten zu ändern. Wie sieht es bei Ihnen aus?", answers: [
          FlowAnswerButton(value: 1, text: "Ja, es wäre sinnvoll, weniger online zu sein.", gotoId: "fh1yy"),
          FlowAnswerButton(value: 0, text: "Nein, dazu sehe ich keine Veranlassung.", gotoId: "fh1yn"),
        ]),
        FlowEndState(
            id: "f_low",
            content:
                "Ihren Angaben zufolge sind Sie nicht allzu oft online aktiv und machen sich nicht so viele Sorgen, online etwas Wichtiges zu verpassen. Das ist eine gute Nachricht, da Sie dadurch entspannter sein können. Andere erleben manchmal 'Fear of Missing Out' oder 'FoMO', also die Angst, online etwas zu verpassen. Sie haben vielleicht schon davon gehört. Ihre 'FoMO' ist eher gering. Bleiben Sie so, wie Sie sind!"),
        FlowEndState(id: "fh_no", content: "Wenn Sie damit zufrieden sind, ist das absolut okay."),
        FlowEndState(
            id: "fh1yy",
            content: "Gute Idee! Versuchen Sie es doch mal!"),
        FlowEndState(id: "fh1yn", content: "Wenn Sie damit zufrieden sind, ist das absolut okay."),
      ],
    );

    return true;
  }
}