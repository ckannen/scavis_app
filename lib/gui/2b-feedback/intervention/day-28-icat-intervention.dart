import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';

class Day28IcatIntervention extends ActionFlowTemplate {
  @override
  String id = "day28_intervention_icat";

  String icatDecision;

  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();
    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      icatDecision = questionnaireResults["icat"]["computation"]["decision-on-day-28"];
      if (icatDecision == null) throw ("value not found");
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
      initialStateId: "I-CAT",
      states: [
        FlowDecision(
            id: "I-CAT",
            decide: () {
              // Decreased
              if (icatDecision == "Decreased")
                return "dec1";
              // Same/Increased
              if (icatDecision == "Same/Increased")
                return "sam1";
            }),
        FlowQuestionState(id: "dec1", content: "Sie haben in den letzten Wochen Ihr Online-Verhalten erfolgreich verändert. Herzlichen Glückwunsch!", answers: [
          FlowAnswerButton(value: 1, text: "Wir möchten Ihnen gerne weitere Unterstützung anbieten. Sie erhalten die Möglichkeit, eine telefonische Beratung in Anspruch zu nehmen, die zweimal 50 Minuten umfasst.", gotoId: "counseling"),
          FlowAnswerButton(value: 0, text: "Wenn Sie sich dennoch unwohl damit fühlen, können Sie die App weiter nutzen. Demnächst werden weitere Inhalte für Sie freigeschaltet. Wir kontaktieren Sie in fünf Monaten zu einer weiteren Befragung, für die Sie einen Amazon-Gutschein in Höhe von 30,- € erhalten.", gotoId: "autoclose"),
        ]),
        FlowQuestionState(id: "sam1", content: "In den letzten Wochen hat sich Ihr Online-Verhalten nicht stark geändert.", answers: [
          FlowAnswerButton(value: 1, text: "Wir möchten Ihnen gerne weitere Unterstützung anbieten. Sie erhalten die Möglichkeit, eine telefonische Beratung in Anspruch zu nehmen, die zweimal 50 Minuten umfasst.", gotoId: "counseling"),
          FlowAnswerButton(value: 0, text: "Wenn Sie sich dennoch unwohl damit fühlen, können Sie die App weiter nutzen. Demnächst werden weitere Inhalte für Sie freigeschaltet. Wir kontaktieren Sie in fünf Monaten zu einer weiteren Befragung, für die Sie einen Amazon-Gutschein in Höhe von 30,- € erhalten.", gotoId: "autoclose"),
        ]),

        FlowQuestionState(id: "counseling", content: "", answers: [
          FlowAnswerButton(value: 1, text: "Ja, ich möchte an der telefonischen Beratung teilnehmen.", gotoId: "hy_end"),
          FlowAnswerButton(value: 0, text: "Nein, ich möchte nicht an der telefonischen Beratung teilnehmen.", gotoId: "hn_end"),
        ]),
        
        // End States
        FlowEndState(id: "autoclose", content: "", autoClose: true),
        FlowEndState(id: "hy_end", content: "Sie brauchen sich um nichts Weiteres zu kümmern. Sie werden von uns zur weiteren Absprache telefonisch kontaktiert."),
        FlowEndState(id: "hn_end", content: "Das scheint für Sie nicht zu passen. In diesem Fall erhalten Sie weitere Tipps und Hinweise in der smart@net-App. Wir kontaktieren Sie in fünf Monaten zu einer weiteren Befragung, für die Sie einen Amazon-Gutschein in Höhe von 30,- Euro erhalten."),
      ],
    );

    return true;
  }
}