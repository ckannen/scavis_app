import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';

class Day8DecisionalBalanceIntervention extends ActionFlowTemplate {
  @override
  String id = "day8_intervention_decisional_balance";

  var dbqDecision;

  String option1 = "Nachteil 1";
  String option2 = "Nachteil 2";
  String option3 = "Nachteil 3";

  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();

    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      (questionnaireResults as Map).keys.forEach((key) {
      });
      dbqDecision = questionnaireResults["decisionalBalance"]["computation"]["decision-on-day-8"];
      if (dbqDecision == null) throw ("value not found");
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
      initialStateId: "DBQ",
      states: [
        FlowDecision(
          id: "DBQ",
          decide: () {
            if (dbqDecision == "High")
              return "db_high1";
            else
              return "db_low1";
          },
        ),

        // path from db_sum to se_sum
        FlowQuestionState(id: "db_high1", content: "Vielen Dank für Ihre Antworten! Verglichen mit anderen Befragten nehmen Sie die negativen Aspekte der Internetnutzung stärker wahr. Was wäre für Sie der wichtigste Grund, weniger online zu sein?", answers: [
          FlowAnswerButton(value: 1, text: "$option1", gotoId: "db_high_o"),
          FlowAnswerButton(value: 2, text: "$option2", gotoId: "db_high_o"),
          FlowAnswerButton(value: 3, text: "$option3", gotoId: "db_high_o"),
        ]),
        FlowQuestionState(id: "db_low1", content: "Vielen Dank für Ihre Antworten! Im Vergleich zu anderen stehen für Sie die negativen Aspekte der Internetnutzung weniger im Vordergrund. Was könnte Ihre Meinung dazu ändern? Was wäre für Sie der wichtigste Grund, weniger online zu sein?", answers: [
          FlowAnswerText(id: "db_low1_res"),
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "db_low2"),
        ]),
        FlowQuestionState(id: "db_low2", content: "Was würde sich für Sie positiv verändern, wenn Sie weniger online wären?", answers: [
          FlowAnswerText(id: "db_low2_res"),
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "db_low2_o"),
        ]),

        FlowEndState(id: "db_high_o", content: "Das klingt nach einem wichtigen Grund. Schauen wir uns noch an, wie sicher Sie sich sind, Ihre Smartphonenutzung ändern zu können."),
        FlowEndState(id: "db_low2_o", content: "Danke für Ihre Antwort! Schauen wir uns noch an, wie sicher Sie sich sind, Ihre Smartphonenutzung ändern zu können."),
      ],
    );

    return true;
  }
}
