import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';

class Day15SelfEfficacyRulerIntervention extends ActionFlowTemplate {
  @override
  String id = "day15_intervention_self_efficacy_ruler";

  String selfEfficacyDecision;

  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();

    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      selfEfficacyDecision = questionnaireResults["selfEfficacyRuler"]["computation"]["decision-on-day-15"];
      if (selfEfficacyDecision == null) throw ("value not found");
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
      initialStateId: "Self-efficacy",
      states: [
        FlowDecision(
          id: "Self-efficacy",
          decide: () {
            // Higher
            if (selfEfficacyDecision == "Higher") return "Higher";
            // Lower/Same
            if (selfEfficacyDecision == "Lower_Same") return "Lower_Same";
          },
        ),
        // Higher
        FlowQuestionState(
            id: "Higher",
            content: "Im Vergleich zur letzten Woche ist Ihre Sicherheit, Ihr Online-Verhalten verändern zu können, gestiegen. Das klingt gut. Was hat Ihre Meinung geändert?",
            answers: [
              FlowAnswerButton(value: 1, text: "Es ist mir wichtiger geworden, ein ausgewogenes Online-/Offline-Leben zu führen.", gotoId: "seh2_1"),
              FlowAnswerButton(value: 2, text: "Ich weiß es nicht. Vielleicht habe ich ein bisschen mehr darüber nachgedacht, wie ich meine Zeit verbringen möchte.", gotoId: "seh2_2"),
              FlowAnswerButton(value: 3, text: "Meine Zuversicht hat vielleicht zugenommen, aber ich mache mir nicht allzu viele Gedanken darüber. ", gotoId: "seh2_3"),
            ]),
        FlowQuestionState(id: "seh2_1", content: "Das ist eine gute Nachricht und könnte Ihnen helfen, die nächsten Schritte zu gehen.", answers: [
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "se2"),
        ]),
        FlowQuestionState(id: "seh2_2", content: "Ja, manchmal ist es nicht so klar, warum sich Ansichten ändern. Vielleicht hilft es, mehr darüber nachzudenken.", answers: [
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "se2"),
        ]),
        FlowQuestionState(id: "seh2_3", content: "Alles klar. Das ist verständlich.", answers: [
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "se2"),
        ]),
        FlowQuestionState(id: "se2", content: "Möchten Sie wissen, was andere Menschen zuversichtlicher macht?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "se_yes"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "se_no"),
        ]),
        FlowQuestionState(id: "se_yes", content: "Schauen Sie sich diese Liste an und markieren Sie, was für Sie hilfreich sein könnte.", answers: [
          FlowAnswerCheckbox(id: "se_yes_checkbox_1", label: "Das Smartphone in einem anderen Raum aufbewahren"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_2", label: "Sich mit Personen verabreden, die Sie eine Weile nicht getroffen haben"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_3", label: "Sport machen oder sich mehr bewegen"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_4", label: "Mit jemandem über diese Themen sprechen"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_5", label: "Erfolge täglich im Blick haben"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_6", label: "Das Ziel mithilfe kleiner Schritte erreichen"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_7", label: "Sich selbst belohnen"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_8", label: "Eine Person finden, die auch ihre Internetnutzung verändern möchte"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_9", label: "Zeiten und Orte festlegen, an denen Sie Ihr Smartphone nicht nutzen"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_10", label: "Ein Selfie machen, wenn Sie schöne Offline-Aktivitäten durchführen"),
          FlowAnswerCheckbox(id: "se_yes_checkbox_11", label: "Technische Unterstützung wie Erinnerungen oder Ermutigungen erhalten"),
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "se_yes_end"),
        ]),
        // Lower_Same
        FlowQuestionState(id: "Lower_Same", content: "Im Vergleich zur letzten Woche ist Ihre Sicherheit, Ihr Online-Verhalten verändern zu können, gesunken. Möchten Sie Ihre Zuversicht zur Verhaltensänderung steigern, um ein ausgewogenes Online-/Offline-Leben zu führen?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "lls1"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "se_no"),
        ]),
        FlowQuestionState(id: "lls1", content: "Wollen Sie wissen, was andere Menschen zuversichtlicher macht?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "lls_yes"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "lls_no"),
        ]),

        // End states
        FlowEndState(id: "se_no", content: "Alles klar. Wenn Sie wollen, können Sie sich das später anschauen."),
        FlowEndState(id: "lls_yes", content: "Dann sehen Sie sich das hier mal an:", link: "https://www.geo.de/wissen/gesundheit/21302-rtkl-positives-denken-mit-diesen-strategien-kann-es-jeder-trainieren"),
        FlowEndState(id: "lls_no", content: "Das ist okay."),
        FlowEndState(id: "se_yes_end", content: "Vielen Dank für Ihre Antwort!"),
      ],
    );

    return true;
  }
}