import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';

class Day1IuesIntervention extends ActionFlowTemplate {
  @override
  String id = "day1_intervention_iues";

  // F1 == Avoidance Expectancies
  // F2 == Positive Reinforement
  String iueDecision;

  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();

    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      iueDecision = questionnaireResults["iues"]["computation"]["decision-on-day-1"];
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
              if (iueDecision == "F2 > F1")
                return "f2_fb1";
              else
                return "f1_fb1";
            }),
        FlowQuestionState(id: "f2_fb1", content: "Sie neigen dazu, das Internet zu nutzen, um Spaß zu haben. Das ist etwas, was viele Menschen tun und kann ein vernünftiger Weg sein, um sich gut zu fühlen. Gleichzeitig berichten andere Menschen, dass sie sich mehr mit „offline“-Tätigkeiten beschäftigen wollen (z.B. ein Buch lesen, Freund*innen treffen oder Sport machen). Wie sieht es bei Ihnen aus? Möchten Sie mehr außerhalb des Internets unternehmen?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "f_link"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "f_no"),
        ]),
        FlowQuestionState(id: "f1_fb1", content: "Manchmal nutzt man das Internet, um Freude zu erleben oder Spaß zu haben. Viele Menschen sind im Internet, um sich vom Stress zu befreien oder um sich von Problemen abzulenken. Manche von ihnen sind damit aber unzufrieden, weil sie Dinge aufschieben oder glauben, dass andere Aktivitäten (z.B. lesen, Freund*innen treffen oder Sport) sinnvoller sein könnten. Wie sieht es bei Ihnen aus? Sind Sie zufrieden damit, das Internet oder das Smartphone zu nutzen, um sich von negativen Gefühlen zu befreien?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "f1y"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "f1n"),
        ]),
        FlowQuestionState(id: "f1n", content: "Andere haben dies auch berichtet. Möchten Sie andere Möglichkeiten zur Entspannung ausprobieren?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "f_link"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "f_no"),
        ]),
        FlowQuestionState(id: "f1y", content: "Klingt gut. Möchten Sie andere Möglichkeiten zur Entspannung ausprobieren?", answers: [
          FlowAnswerButton(value: 1, text: "Ja", gotoId: "f_link"),
          FlowAnswerButton(value: 0, text: "Nein", gotoId: "f_no"),
        ]),

        FlowEndState(id: "f_no", content: "Alles klar."),
        FlowEndState(id: "f_link", content: "Klingt gut. Schauen Sie sich das hier mal an", link: "https://www.meine-krankenkasse.de/ratgeber/gesund-leben/wohlbefinden-stressbewaeltigung/stress-entspannungstechniken/"),
      ],
    );

    return true;
  }
}