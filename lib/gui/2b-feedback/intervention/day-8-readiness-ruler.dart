import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow/action-flow.dart';

class Day8ReadinessRulerIntervention extends ActionFlowTemplate {
  @override
  String id = "day8_intervention_readiness_ruler";

  String rrqDecision;

  Future<bool> loadFromDb() async {
    ScavisCouchbase db = ScavisCouchbase();

    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      rrqDecision = questionnaireResults["readinessRuler"]["computation"]["decision-on-day-8"];
      if (rrqDecision == null) throw ("value not found");
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
      initialStateId: "RRQ",
      states: [
        FlowDecision(
          id: "RRQ",
          decide: () {
            if (rrqDecision == "High")
              return "r_sum_high";
            else
              return "r_sum_low";
          },
        ),
        
        // path from db_sum to se_sum
        FlowQuestionState(id: "r_sum_high", content: "Das klingt gut. Es scheint, als gäbe es für Sie bereits eine Reihe von Gründen, die wichtig sein könnten, um Ihr Verhalten zu ändern. Wollen Sie einen Versuch wagen oder sich die Vor- und Nachteile Ihrer Internet-/Smartphonenutzung ansehen?", answers: [
          FlowAnswerButton(value: 1, text: "Ich möchte es versuchen.", gotoId: "try1"),
          FlowAnswerButton(value: 2, text: "Ich möchte mir die Vor- und Nachteile ansehen.", gotoId: "rsh_db_end"),
        ]),
        FlowQuestionState(id: "try1", content: "Versuchen Sie es einmal: Welche Aktivität stört Sie am meisten?", answers: [
          FlowAnswerButton(value: 1, text: "Soziale Netzwerke und Chatten (z.B. WhatsApp, Facebook, Instagram, Snapchat, etc.)", gotoId: "try2"),
          FlowAnswerButton(value: 2, text: "Online-Spiele (z.B. Fortnite, World of Tanks, Forge of Empires)", gotoId: "try2"),
          FlowAnswerButton(value: 3, text: "Glücksspiele (Spiele mit Geldeinsatz, z.B. Poker, Wetten, Internetcasino, etc.)", gotoId: "try2"),
          FlowAnswerButton(value: 4, text: "Shoppen und Verkaufen", gotoId: "try2"),
          FlowAnswerButton(value: 5, text: "Videoportale (z.B. YouTube, Twitch)", gotoId: "try2"),
          FlowAnswerButton(value: 6, text: "Streamingdienste (z.B. Netflix, Spotify)", gotoId: "try2"),
          FlowAnswerButton(value: 7, text: "Erotik und Pornografie", gotoId: "try2"),
          FlowAnswerButton(value: 8, text: "Recherchieren oder Informationen suchen", gotoId: "try2"),
          FlowAnswerButton(value: 9, text: "Datingportale (z.B. Tinder, Parship, etc.)", gotoId: "try2"),
          FlowAnswerButton(value: 10, text: "Downloaden von Dateien", gotoId: "try2"),
          FlowAnswerButton(value: 11, text: "Internet-(Video-)Telefonie (z.B. Skype, Zoom)", gotoId: "try2"),
        ]),
        FlowQuestionState(id: "try2", content: "Andere haben versucht, ihre Online-Aktivitäten um 20 % zu reduzieren. Wie wäre es damit?", answers: [
          FlowAnswerButton(value: 1, text: "Das ist eine gute Idee!", gotoId: "try2a_ok"),
          FlowAnswerButton(value: 2, text: "Das ist mir zu viel.", gotoId: "try3"),
          FlowAnswerButton(value: 3, text: "Das ist mir zu wenig, ich möchte gerne mehr versuchen.", gotoId: "try3"),
          FlowAnswerButton(value: 4, text: "Ich möchte meine Smartphonenutzung nicht reduzieren.", gotoId: "try_no"),
        ]),
        FlowQuestionState(id: "try3", content: "Welchen Vorschlag haben Sie?", answers: [
          FlowAnswerText(id: "try3_res"),
          FlowAnswerButton(value: 1, text: "Weiter", gotoId: "try3_end"),
        ]),

        // go to dbq questionnaire afterwards
        FlowEndState(id: "r_sum_low", content: "Das klingt gut. Sie haben offenbar bereits über die angenehmen und weniger angenehmen Aspekte Ihrer Aktivitäten im Internet nachgedacht. Lassen Sie uns das mal gemeinsam anschauen."),
        FlowEndState(id: "rsh_db_end", content: "", autoClose: true),
        // go to seq afterwards and skip dbq questionnaire + intervention
        FlowEndState(id: "try3_end", content: "Ausgezeichnet! Los geht's! Schauen wir uns noch an, wie sicher Sie sich sind, Ihre Smartphonenutzung ändern zu können."),
        FlowEndState(id: "try2a_ok", content: "Gute Entscheidung! Sie können es ja mal ausprobieren! Schauen wir uns noch an, wie sicher Sie sich sind, Ihre Smartphonenutzung ändern zu können."),
        FlowEndState(id: "try_no", content: "Das ist absolut okay, wenn Sie das im Moment nicht möchten. Sie können sich das jederzeit überlegen. Schauen wir uns noch an, wie sicher Sie sich sind, Ihre Smartphonenutzung ändern zu können."),
      ],
    );

    return true;
  }
}