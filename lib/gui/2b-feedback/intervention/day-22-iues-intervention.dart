import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';

class Day22IuesIntervention extends ActionFlowTemplate {
  @override
  String id = "day22_intervention_iues";

  // F1 == Avoidance Expectancies
  // F2 == Positive Reinforement
  String iueDecision;

  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();
    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      iueDecision = questionnaireResults["iues"]["computation"]["decision-on-day-22"];
      if (iueDecision == null) throw ("value not found");
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
      initialStateId: "IUE",
      states: [
        FlowDecision(
            id: "IUE",
            decide: () {
              // Change to F1
              if (iueDecision == "Change to F1") return "f1_1";
              // Change to F2
              if (iueDecision == "Change to F2") return "f2_1";
              // Unchanged
              if (iueDecision == "Unchanged") return "fu_1";
            }),
        // Change to F1
        FlowQuestionState(
            id: "f1_1",
            content:
                "Im Vergleich zu vor drei Wochen neigen Sie zunehmend dazu, das Internet zu nutzen, um negativen Gefühlen zu entkommen oder sich von Problemen abzulenken. Das tun viele Menschen und das ist okay, solange es sich nicht unangenehm anfühlt und Sie lieber andere Mittel zum Stressabbau ausprobieren möchten. Wie sieht es heute bei Ihnen aus? Wie geht es Ihnen dabei? Fühlt es sich für Sie unangenehm an?",
            answers: [
              FlowAnswerButton(value: 1, text: "Ja", gotoId: "f1y"),
              FlowAnswerButton(value: 0, text: "Nein", gotoId: "f1n"),
            ]),
        FlowQuestionState(id: "f1y", content: "Möchten Sie sich alternative Aktivitäten zum Stressabbau anschauen?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "link_end"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "f1n1"),
        ]),
        FlowQuestionState(id: "f1n1", content: "Das ist okay. Vielleicht haben Sie eigene Ideen, was für Sie am besten passt. Diese können Sie hier aufschreiben.", answers: [
          FlowAnswerText(id: "f1n1_text"),
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "f1n1_end"),
          FlowAnswerButton(value: 0, text: "Nein, danke.", gotoId: "f1n1_end"),
        ]),
        FlowQuestionState(id: "f1n", content: "Möchten Sie sich alternative Aktivitäten zum Stressabbau anschauen?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "link_end"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "f1nn"),
        ]),
        // Change to F2
        FlowQuestionState(
            id: "f2_1",
            content:
                "Im Vergleich zu vor drei Wochen neigen Sie vermehrt dazu, das Internet zu nutzen, um Spaß zu haben. Das ist okay, wenn es sich für Sie gut anfühlt. Dennoch sollten Sie sich vor Augen halten, wie lohnend Aktivitäten außerhalb des Internets sind. Wenn Sie uns sagen möchten, was das Schönste wäre, was Sie in nächster Zeit „offline“ tun könnten, dann schreiben Sie es hier auf. Wir sind gespannt!",
            answers: [
              FlowAnswerText(id: "f2_text"),
              FlowAnswerButton(value: 1, text: "Weiter", gotoId: "f2_text_end"),
            ]),
        // Unchanged
        FlowQuestionState(
            id: "fu_1",
            content:
                "Im Vergleich zu vor drei Wochen hat sich Ihre Tendenz, das Internet zu nutzen, um vor negativen Gefühlen zu flüchten oder sich von Problemen abzulenken, nicht verändert. Das kann in Ordnung sein, es sei denn, es fühlt sich für Sie unangenehm an und Sie möchten lieber andere Wege zum Stressabbau ausprobieren. Wie sieht es bei Ihnen aus? Fühlen Sie sich wohl bei der Nutzung des Internets oder Ihres Smartphones?",
            answers: [
              FlowAnswerButton(value: 1, text: "Ja", gotoId: "fuy"),
              FlowAnswerButton(value: 0, text: "Nein", gotoId: "funo"),
            ]),
        FlowQuestionState(
            id: "fuy",
            content: "Das klingt, als ob Sie damit gut zurechtkommen. Nach einiger Zeit suchen manche Menschen nach Alternativen. Sind Sie daran interessiert, was andere ausprobiert haben?",
            answers: [
              FlowAnswerButton(value: 1, text: "Ja", gotoId: "link_end"),
              FlowAnswerButton(value: 0, text: "Nein", gotoId: "fuy_end"),
            ]),
        FlowQuestionState(id: "funo", content: "Möchten Sie sich alternative Aktivitäten zum Stressabbau anschauen?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "link_end"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "fuy_end"),
        ]),

        // End States
        FlowEndState(
            id: "link_end",
            content: "Schauen Sie sich doch mal diese alternativen Aktivitäten an. Sie haben sie vielleicht schon einmal gesehen, aber manchmal macht der zweite Blick den Unterschied.",
            link: "https://www.meine-krankenkasse.de/ratgeber/gesund-leben/wohlbefinden-stressbewaeltigung/stress-entspannungstechniken/"),
        FlowEndState(id: "f1nn", content: "In Ordnung."),
        FlowEndState(id: "f2_text_end", content: "Vielen Dank für Ihre Antwort!"),
        FlowEndState(id: "fuy_end", content: "In Ordnung."),
        FlowEndState(id: "f1n1_end", content: ""),
      ],
    );

    return true;
  }
}