import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';


class Day15ReadinessRulerIntervention extends ActionFlowTemplate {
  @override
  String id = "day15_intervention_readiness_ruler";

  String readinessRulerDecision;

  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();

    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      readinessRulerDecision = questionnaireResults["readinessRuler"]["computation"]["decision-on-day-15"];
      if (readinessRulerDecision == null) throw ("value not found");
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
      initialStateId: "Readiness Ruler",
      states: [
        FlowDecision(
            id: "Readiness Ruler",
            decide: () {
              // Higher
              if (readinessRulerDecision == "Higher")
                return "Higher";
              // Lower
              if (readinessRulerDecision == "Lower")
                return "rl_end";
              // Same
              if (readinessRulerDecision == "Same")
                return "rs_end";
            }),
        FlowQuestionState(id: "Higher", content: "Im Vergleich zur letzten Woche ist Ihre Bereitschaft, Ihr Online-Verhalten zu ändern, gestiegen. Das klingt gut. Was hat Ihre Meinung geändert?", answers: [
          FlowAnswerButton(value: 1, text: "Mir ist es wichtiger, ein ausgeglichenes Online-/Offline-Leben zu führen.", gotoId: "rh1_end"),
          FlowAnswerButton(value: 2, text: "Ich weiß es nicht. Vielleicht habe ich ein bisschen mehr darüber nachgedacht, wie ich meine Zeit verbringen möchte.", gotoId: "rh2_end"),
          FlowAnswerButton(value: 3, text: "Meine Bereitschaft hat vielleicht zugenommen, aber ich mache mir darüber nicht zu viele Gedanken. ", gotoId: "rh3_end"),
        ]),

        FlowEndState(id: "rs_end", content: "Im Vergleich zur letzten Woche hat sich Ihre Bereitschaft, Ihr Online-Verhalten zu ändern, nicht sehr verändert. Bleiben Sie dran und Sie erhalten interessantes Feedback!"),
        FlowEndState(id: "rl_end", content: "Im Vergleich zur letzten Woche ist Ihre Bereitschaft, Ihr Online-Verhalten zu ändern, gesunken. Dieses Thema scheint für Sie noch nicht oder nicht mehr so wichtig zu sein. Trotzdem: Bleiben Sie dran! Wir haben interessante Rückmeldungen für Sie."),
        FlowEndState(id: "rh1_end", content: "Das ist eine gute Entwicklung, bleiben Sie dran! Wir helfen Ihnen dabei."),
        FlowEndState(id: "rh2_end", content: "Das ist eine gute Idee! Dabei helfen wir Ihnen gerne, bleiben Sie dran."),
        FlowEndState(id: "rh3_end", content: "Das ist okay, das braucht Zeit. Versuchen Sie dranzubleiben, wir helfen Ihnen gerne dabei."),
      ],
    );

    return true;
  }
}