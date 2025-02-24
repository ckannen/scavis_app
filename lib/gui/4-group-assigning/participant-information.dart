import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/gui/1-login/init-study.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/gui/4-group-assigning/control-group.dart';
import 'package:scavis/gui/4-group-assigning/intervention.group.dart';
import 'package:scavis/gui/4-group-assigning/prevention-group.dart';
import 'package:scavis/theme/my-theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ParticipantInformationScreen extends StatefulWidget {
  static const String ROUTE = "/participant-information/";
  @override
  _ParticipantInformationScreenState createState() => _ParticipantInformationScreenState();
}

class _ParticipantInformationScreenState extends State<ParticipantInformationScreen> {
  int currentBoxIndex = 0;
  bool networkWarningVisible = false;
  bool contactDataServerErrorMessageVisible = false;
  bool contactDataMissingrErrorMessageVisible = false;
  String htmlString = "";

  String htmlText = "";

  int consentAnswer = -1;
  int insuranceDataAnswer = -1;

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerEmailAddress = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerInsuranceNumber = TextEditingController();
  int addressMaxLines = 1;

  @override
  initState() {
    super.initState();
    _controllerAddress.addListener(() {
      int linesCount = 1;
      _controllerAddress.text.characters.forEach((char) {
        if (char == "\n") linesCount++;
      });
      setState(() {
        addressMaxLines = linesCount + 1;
      });
    });

    AppStateManager appStateManager = AppStateManager();
    if (appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] != StateValues.PENDING) {
      setState(() {
        currentBoxIndex = 1;
      });
    }
  }

  giveConsent(int value) async {
    AppStateManager appStateManager = AppStateManager();
    if (value == 0) {
      // change app state
      appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] = StateValues.NO;
      appStateManager.appState[AppStateNames.TRACKING_CONSENT] = StateValues.NO;
      appStateManager.storeAppState();

      // change assigned group in participant schedule (switch to prevention)
      await appStateManager.loadParticipantSchedule();
      appStateManager.participantSchedule["previousGroup"] = appStateManager.participantSchedule["group"];
      appStateManager.participantSchedule["group"] = AssignedGroupValues.PREVENTION;
      await appStateManager.storeParticipantSchedule();
      Navigator.pushReplacementNamed(context, AssignToPreventionGroupScreen.ROUTE);
    }
    if (value == 1) {
      // change app state
      appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] = StateValues.YES;
      appStateManager.appState[AppStateNames.TRACKING_CONSENT] = StateValues.YES;
      appStateManager.storeAppState();
    }
    if (value == 2) {
      // change app state
      appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] = StateValues.YES;
      appStateManager.appState[AppStateNames.TRACKING_CONSENT] = StateValues.NO;
      appStateManager.storeAppState();
    }

    setState(() {
      this.consentAnswer = value;
      currentBoxIndex = 1;
    });
  }

  setInsuranceDataAnswer(int value) async {
    setState(() {
      this.insuranceDataAnswer = value;
      currentBoxIndex = 2;
    });
  }

  setContactDataAnswer() async {
    setState(() {
      contactDataServerErrorMessageVisible = false;
      contactDataMissingrErrorMessageVisible = false;
    });

    // check whether data is missing
    bool dataMissing = false;
    if (_controllerEmailAddress.text == "") dataMissing = true;
    if (_controllerName.text == "") dataMissing = true;
    if (_controllerPhoneNumber.text == "") dataMissing = true;
    if (dataMissing) {
      setState(() {
        contactDataMissingrErrorMessageVisible = true;
      });
      return;
    }

    // get a database connection to load the participant id and code
    ScavisCouchbase database = ScavisCouchbase();

    // send the data to the server
    try {
      const String URL = "https://app.scavis.net/app-api/save-participant-contact-data.php";
      Response response = await Dio().post(URL, data: {
        "participantId": database.couchbaseUser.participantId,
        "participantCode": database.couchbaseUser.participantCode,
        "emailAddress": _controllerEmailAddress.text,
        "name": _controllerName.text,
        "phoneNumber": _controllerPhoneNumber.text,
        "address": _controllerAddress.text,
        "insuranceNumber": _controllerInsuranceNumber.text
      });
      dynamic jsonRespnse = jsonDecode(response.data);
      if (jsonRespnse["status"] == "ok") {
        gotoGroupAssigning();
      } else {
        setState(() {
          contactDataServerErrorMessageVisible = true;
        });
      }
    } on Exception catch (e) {
      setState(() {
        contactDataServerErrorMessageVisible = true;
      });
      print("$runtimeType.setContactDataAnswer: $e");
    }
  }

  gotoGroupAssigning() async {
    // change app state
    AppStateManager appStateManager = AppStateManager();
    appStateManager.appState[AppStateNames.CONTACT_DATA_ENTERED] = true;
    appStateManager.storeAppState();

    // get assigned group and go to welcome screen for that group
    await appStateManager.loadParticipantSchedule();
    String group = appStateManager.participantSchedule["group"];
    if (group == AssignedGroupValues.INTERVENTION) {
      Navigator.pushReplacementNamed(context, AssignToInterventionGroupScreen.ROUTE);
    } else if (group == AssignedGroupValues.CONTROL) {
      Navigator.pushReplacementNamed(context, AssignToControlGroupScreen.ROUTE);
    } else {
      Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE);
    }
  }

  createConsentDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Teilnahme"),
            content: Text("Hiermit bestätige ich, dass ich die Information gelesen habe und damit einverstanden bin."),
            backgroundColor: MyTheme.BACKGROUND_COLOR,
            actions: [
              MaterialButton(
                  child: Text("Ja"),
                  onPressed: () async {
                    // storing the variable appStateManager.appState[AppStateNames.APP_CONSENT_GIVEN] = true;
                    // could happen here, but since the participant id is not known at this point,
                    // the flag is stored on the init study screen, after the participant information were created and loaded form the server
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, InitStudyScreen.ROUTE);
                  }),
              MaterialButton(
                  child: Text("Nein"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Step> stepperSteps = [];

    stepperSteps.add(Step(title: Container(child: Text(currentBoxIndex == 0 ? "Information" : "")), isActive: currentBoxIndex == 0, content: buildParticipantInformation()));
    stepperSteps.add(Step(title: Container(child: Text(currentBoxIndex == 1 ? "Versicherung" : "")), isActive: currentBoxIndex == 1, content: buildSocialDataInformation()));
    stepperSteps.add(Step(title: Container(child: Text(currentBoxIndex == 2 ? "Ihre Daten" : "")), isActive: currentBoxIndex == 2, content: buildDataForm()));

    return Scaffold(
      appBar: MyAppBar.createDefaultAppBar(),
      backgroundColor: MyTheme.BACKGROUND_COLOR,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stepper(
              steps: stepperSteps,
              type: StepperType.horizontal,
              onStepContinue: () {},
              onStepTapped: (int stepIndex) {},
              onStepCancel: () {},
              controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Container();
              },
              currentStep: currentBoxIndex,
            );
          },
        ),
      ),
    );

    return Scaffold(
      appBar: MyAppBar.createDefaultAppBar(),
      backgroundColor: MyTheme.BACKGROUND_COLOR,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (this.consentAnswer == -1) return buildParticipantInformation();
            if (this.consentAnswer >= 1 && this.insuranceDataAnswer == -1) return buildSocialDataInformation();
            if (this.insuranceDataAnswer >= 0) return buildDataForm();
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildParticipantInformation() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(children: [
        // headline
        Text("Proband*inneninformationen", style: TextStyle(fontSize: 18)),
        SizedBox(height: 20),
        Text("Titel der Studie: Stepped Care Ansatz zur Versorgung Internetbezogener Störungen (SCAVIS)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),

        // block 1
        Text("Liebe Interessierte unserer wissenschaftlichen Studie,", style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "die Nutzung von Smartphones und Internet ist weit verbreitet, eröffnet neue Möglichkeiten und wird auch in Zukunft in allen Bereichen unserer Gesellschaft wichtig sein. Gleichzeitig können für einen Teil der Nutzer*innen problematische Verhaltensweisen auftreten, welche sich negativ auf das alltägliche Leben auswirken können. In einigen Fällen kann sogar eine fortgesetzte schädliche Nutzung entstehen, welche zu einem suchtartigen Problem führen kann. Das betrifft beispielsweise Computerspiele, soziale Netzwerknutzung, suchtartiges Konsumieren von Pornografie oder suchtartiges Kaufen/Shoppen.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Darum besteht ein dringender Bedarf an wirksamen Präventions- und Behandlungsangeboten. Relevant sind dabei vor allem Angebote, mit denen Betroffene frühzeitig angesprochen werden, um ihnen angemessen helfen zu können. Um möglichst früh möglichst viele Personen erreichen zu können, soll dafür ein umfassendes Unterstützungsangebot entwickelt und überprüft werden. Dieses Angebot kann direkt auf dem eigenen Smartphone verwendet werden.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text:
                      "Wichtig ist aber zunächst zu prüfen, ob dieses Angebot wirksam ist. Deshalb soll in der vorliegenden Studie bei Berufstätigen zwischen 16 und 67 Jahren überprüft werden, ob eine Kombination aus frühen Hilfsangeboten sowie angepassten Angeboten für schwerer Betroffene wirksam ist. Damit soll der Entwicklung von schwereren Problemen entgegengewirkt werden. Bei bereits sehr intensiven Nutzungsformen wird Betroffenen zusätzlich zunächst eine telefonische Kurzberatung, später bei Bedarf eine Online-Therapie angeboten. Die Universität zu Lübeck führt die Studie in Kooperation mit der Universität Ulm, der Universität Mainz, der Freien Universität Berlin, der Media Protect e.V. und der CONVEMA Versorgungsmanagement GmbH durch. ",
                  style: TextStyle(fontSize: 14, color: MyTheme.TEXT_COLOR)),
              TextSpan(text: "Die Teilnahme an der Studie ist freiwillig.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.TEXT_COLOR)),
            ],
          ),
        ),
        SizedBox(height: 10),

        SizedBox(height: 10),
        Text(
            "Nach Einwilligung zur Studienteilnahme wird bei den Teilnehmenden das Internetnutzungsverhalten über einen Zeitraum von vier Wochen mit Hilfe der smart@net-App erfasst (Tracking). Wenn die Teilnehmenden in die weitere Teilnahme an der Studie einwilligen, werden sie zufällig einer Interventionsgruppe oder einer Kontrollgruppe zugeordnet. Für beide Gruppen erfolgt innerhalb der App eine weiterführende Befragung zur Internetnutzung, wie beispielsweise problematische Verhaltensweisen oder Erwartungen an die Internetnutzung. Die Kontrollgruppe erhält daraufhin Zugang zu einem Angebot mit Informationen zu sicherer und unproblematischer Internetnutzung innerhalb der smart@net-App. Die Interventionsgruppe erhält in der App Zugang zu einem stufenweise aufgebauten Angebot. Dabei durchläuft sie verschiedene Schritte, um mögliche problematische Internetnutzung zu reduzieren. Je nach Erfolg schließen die Teilnehmenden das Programm ab oder machen mit der nächsten Stufe weiter.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Für die Interventionsgruppe gibt es zunächst innerhalb der App ein individuelles Feedback zum Internetnutzungsverhalten. Innerhalb der ersten vier Wochen erhalten die Teilnehmenden weitere Rückmeldungen und Anregungen, zum Beispiel, wie man die Nutzung reduzieren oder alternative Beschäftigungen entwickeln kann.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Konnte durch die Rückmeldungen keine Besserung der problematischen Internetnutzung erreicht werden, folgt ein Übergang in Stufe zwei. Hier wird eine telefonische Kurzberatung angeboten. Sollte sich durch die telefonische Beratung keine Verbesserung zeigen, erhalten die Betroffenen in der dritten Stufe die Möglichkeit, eine Online-Therapie in Anspruch zu nehmen. Die Online-Therapie enthält sowohl Einzel- als auch Gruppengespräche und vermittelt Fertigkeiten, wie die Teilnehmenden auf problembelastende Nutzungsformen verzichten können. Teilnehmende mit starken internetbezogenen Problemen erhalten direkt nach dem Screening einen Vorschlag, die Online-Therapie in Anspruch zu nehmen. Etwa sechs bis neun Monate nach der Eingangsbefragung erfolgt für die Interventions- und für die Kontrollgruppe eine Nachbefragung, um beide Gruppen miteinander zu vergleichen. Damit lässt sich überprüfen, ob der gestufte Versorgungsansatz das Internetnutzungsverhalten verändern konnte. Die Nachbefragung erfolgt online über eine Internetseite. Den entsprechenden Link erhalten die Teilnehmenden über die angegebenen E-Mailadressen. Sollten diese nicht mehr gültig sein, werden die Teilnehmenden telefonisch kontaktiert.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Um aussagekräftige Daten zur Wirksamkeit dieses gestuften Ansatzes zu bekommen, benötigen wir möglichst viele Teilnehmende für die Studie. Deshalb wenden wir uns direkt in Kooperation mit Ihrer betrieblichen Krankenkasse an Sie, um Sie zur SCAVIS-Studie einzuladen.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),

        // block 2
        Text("Vorgehen und Datenerhebung der einzelnen Teilschritte", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text(
            "Alle im Verlauf der Studie erhobenen Daten werden streng vertraulich behandelt. Zum Schutz dieser Daten sind Maßnahmen getroffen worden, die eine Weitergabe an unbefugte Dritte verhindern. Alle Teilnehmenden erhalten einen individuellen Proband*innencode, durch den keine Rückschlüsse auf die Person und deren Namen möglich sind. Während der gesamten Dokumentations- und Auswertungsphase werden Teilnehmende lediglich anhand dieses Codes zugeordnet, während der vollständige Name der Teilnehmenden nicht ersichtlich ist. Mit diesem Code kann beispielsweise ohne Verwendung des Namens dokumentiert werden, welche Teilnehmenden an den Beratungsgesprächen oder Therapiesitzungen teilgenommen haben. Diese Angabe ist wichtig, um später bei der Auswertung der Daten die Wirksamkeit der Maßnahmen beurteilen zu können. Dieses Konzept nennt man „Pseudonymisierung“. Es wird in der Wissenschaft als Standardverfahren verwendet.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Für die Durchführung der weiteren Studienschritte ist es erforderlich, die Kontaktdaten der Teilnehmenden zu erfassen. Dies ist insbesondere für die telefonische Beratung und für die Online-Therapie wichtig, aber auch für die Kontaktaufnahme zur Nachbefragung. Die Kontaktdaten werden bereits verschlüsselt auf einen gesicherten Server übertragen und dort gespeichert. Nur die Studienmitarbeiter*innen haben sowohl eine Einsicht in die Kontaktdaten als auch die Proband*innencodes. Sämtliche Mitarbeiter*innen der Studie unterliegen der Schweigepflicht.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Die Studie dauert insgesamt sechs Monate. In den ersten vier Wochen findet optional innerhalb der App ein Tracking statt (siehe folgenden Abschnitt). In den darauffolgenden vier Wochen finden - je nach Bedarf - zwei telefonische Beratungen und in den darauffolgenden 17 Wochen die Online-Therapie statt. Nach insgesamt sechs Monaten erfolgt für alle Teilnehmenden eine Nachbefragung.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Die erste Befragung (Screening) dauert ca. 15 bis 20 Minuten. Die Beantwortung kann jederzeit unterbrochen und zu einem späteren Zeitpunkt fortgeführt werden. Bei Studienteilnahme werden weitere Fragebögen eingesetzt, sowohl wöchentlich (Beantwortungsdauer ca. 10 Minuten) als auch täglich (Beantwortungsdauer ca. eine Minute). Die täglichen/wöchentlichen Fragebögen werden immer gegen 19 Uhr verschickt.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 15),
        // block 2a
        Text("Das Tracking und Daten innerhalb der App", style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Text(
            "Bei der Einwilligung zur Studienteilnahme kann der anonymen Aufzeichnung der Häufigkeit und der Dauer der Smartphonenutzung (Tracking) über einen Zeitraum von vier Wochen zugestimmt werden. Die Aufzeichnung erfolgt ausschließlich zu wissenschaftlichen Zwecken. Das Tracking wird nur aktiviert, wenn Sie dem zustimmen. Die Nutzung dieser Funktion ist freiwillig.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Über das Tracking erfasst werden unter anderem sogenannte „App-Sessions“, das bedeutet, es wird registriert, über welchen Zeitraum Apps auf dem Smartphone genutzt werden und wie oft diese aufgerufen wurden. Beim Aufruf der App kann unterschieden werden, ob die App über das Icon oder über eine Benachrichtigung geöffnet wurde. Weiterhin wird erhoben, wie oft das Telefon entsperrt und wie oft es ohne Entsperrung aktiviert wird (z.B.: Uhrzeit prüfen, Vorschau einer Benachrichtigung prüfen). Es wird erhoben, wie viel Zeit im Menü des Smartphones verbracht wird und welche Apps auf dem Gerät installiert sind. Damit kann man beispielsweise ermitteln, welche Anwendungsarten besonders oft dazu führen, das Smartphone in die Hand zu nehmen. Es wird jedoch NICHT erhoben, was in diesen Apps gemacht wird. Das bedeutet, es kann NICHT identifiziert werden, welche Inhalte gelesen oder geschrieben werden. Das gleiche gilt auch für die auf dem Telefon gespeicherten Kontakte oder ein- und ausgehende Anrufe. Es wird beobachtet, wie viele Anrufe von verschiedenen Nummern auf dem Gerät ein- und ausgehen (z.B.: „Person 345 hat heute mit 4 unterschiedlichen Personen telefoniert. Die Gespräche waren vier Minuten lang und mit einer Person etwas länger mit 15 Minuten“). Die jeweiligen Telefonnummern oder die Inhalte der Gespräche werden NICHT aufgezeichnet. Alles ist anonym und lässt keinen Rückschluss auf die Person zu (Pseudonymisierung, siehe oben).",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Optional können zudem mit Hilfe der Standorterfassung Aussagen über Bewegungsmuster der Teilnehmenden getroffen werden. Da die erhobenen GPS-Daten noch vor der Speicherung verfremdet werden, ist kein Rückschluss auf die Aufenthaltsorte der Teilnehmenden möglich. Die tatsächliche Position des Nutzenden wird sowohl in Nord-/Süd- als auch Ost-/West-Richtung und in der Höhe auf einen anderen Ort auf der Welt projiziert. Der tatsächliche Ort des Nutzers bleibt geheim. Ausschließlich dieser anonymisierte Ort des Nutzers wird an die Studienserver übertragen. Erhoben werden ausschließlich die Anzahl der besuchten Orte, die Dauer pro Tag an einem Ort und der individuelle Bewegungsradius einer Person.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Direkt auf dem Smartphone werden Statistiken zu den gewonnenen Informationen erstellt. Diese Statistiken werden dann verschlüsselt an den Server der Universität Ulm übertragen, wo keinerlei Rückschlüsse auf die Inhalte des Smartphones mehr möglich sein werden.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text("Im Rahmen des Trackings werden folgende Aktivitäten auf Ihrem Smartphone aufgezeichnet:", style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MyBullet("Benutzersitzungen (Ein- und Ausschalten des Bildschirms, Entsperren des Bildschirms, Dauer der Sitzung, verstrichene Zeit seit der letzten Sitzung)",
              style: TextStyle(fontSize: 14)),
          MyBullet("Telefonereignisse (Starten des Geräts, Neustart, Abschalten oder Laden des Geräts, Flugzeugmodus,)", style: TextStyle(fontSize: 14)),
          MyBullet("Liste aller installierten Anwendungen (Titel der Anwendung, Name des Anwendungspakets, Änderungen im Laufe der Zeit)", style: TextStyle(fontSize: 14)),
          MyBullet("App-Sitzungen (App-Titel, Name des App-Pakets, Dauer der Nutzung)", style: TextStyle(fontSize: 14)),
          MyBullet(
              "	Summierte Nutzung der Anwendungen (Tägliche, wöchentliche oder monatliche aufsummierte Daten, Titel der Anwendung, Name des Anwendungspakets, Gesamtdauer der Nutzung, Anzahl der Öffnungen der Anwendung)",
              style: TextStyle(fontSize: 14)),
          MyBullet("Klingelton-Status (lautlos, vibrierend oder eingeschaltet)", style: TextStyle(fontSize: 14)),
          MyBullet("Optional: Standorte (per GPS erfasst und verfremdet)", style: TextStyle(fontSize: 14)),
        ]),
        SizedBox(height: 10),
        Text("Es ist sichergestellt, dass folgende Aktivitäten NICHT erfasst werden können:", style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MyBullet("Telefonnummern zu eingehenden/ausgehenden Anrufen", style: TextStyle(fontSize: 14)),
          MyBullet("Inhalte von Anrufen", style: TextStyle(fontSize: 14)),
          MyBullet("Telefonnummern zu gesendeten/empfangenen Nachrichten", style: TextStyle(fontSize: 14)),
          MyBullet("Inhalte gesendeter/empfangener Nachrichten", style: TextStyle(fontSize: 14)),
          MyBullet("Gelesene oder geschriebene App-Inhalte", style: TextStyle(fontSize: 14)),
          MyBullet("Sprachaufzeichnungen.", style: TextStyle(fontSize: 14)),
        ]),
        SizedBox(height: 10),
        Text(
            "Die Interventionsgruppe erhält während der ersten vier Wochen der Studie in wöchentlichen Abständen kurze Befragungen sowie täglich zwei kurze Fragen zum eigenen Wohlbefinden. Einmal pro Woche erhalten die Teilnehmenden eine Rückmeldung zu ihrer Smartphonenutzung sowie optional Anregungen für eine Nutzungsänderung. Zum Abschluss erfolgt erneut eine umfassendere Befragung, die unter anderem Merkmale für problematische Internetnutzung erfasst. Die Daten des Trackings und die Befragungsdaten werden verschlüsselt an einen gesicherten Server der Universität Ulm übermittelt.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 15),
        // block 2b
        Text("Die telefonische Beratung", style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Text(
            "Zur Durchführung der telefonischen Beratung erhalten die durchführenden Psycholog*innen Zugriff auf Ihre Kontaktdaten. Dazu werden die Daten verschlüsselt von der Universität Ulm an die zuständigen Berater*innen übermittelt. Diese entschlüsseln die Kontaktdaten erst vor Ort wieder. Die Psycholog*innen erhalten jedoch keinen Zugriff auf die Angaben, die Sie innerhalb der App oder während des Trackings gemacht haben. Im Rahmen der telefonischen Beratung sollen die Betroffenen zu einer Änderung ihres problematischen Internetnutzungsverhaltens motiviert werden. Für diese Beratung sollen innerhalb von vier Wochen zwei telefonische Kontakte im Umfang von bis zu 50 Minuten erfolgen.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Ihre Identifikationsnummer wird im Rahmen der telefonischen Beratung ausschließlich dafür verwendet, um Termine für die Beratung, erfolgte Kontaktversuche und einen Hinweis zu vermerken, ob die Beratung durchgeführt wurde. Am Ende der Beratung wird noch einmal ein Fragebogen eingesetzt, um zu entscheiden, ob den Betroffenen noch eine Online-Therapieangeboten wird.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 15),
        // block 2c
        Text("Die Online-Therapie", style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Text(
            "Wie bereits bei der telefonischen Beratung erhalten die Online-Therapeut*innen ausschließlich die Kontaktdaten der Teilnehmenden und keinen Zugang zu den Angaben aus der App und dem Tracking. Die Datenübermittlung erfolgt ebenfalls verschlüsselt.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Die Durchführung der videobasierten Therapiesitzungen und der zugehörigen elektronischen Erhebungen erfolgt mithilfe einer datenschutzkonformen Plattform der Facharzt Sofort GmbH (Viomedi), welche nach hohen Standards mit dem Datenschutz-Gütesiegel internet privacy standards (ips) versehen ist. Die Nutzung der Plattform erfordert keine Installation von Programmen.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Das Vorgehen der Online-Therapie basiert auf einem standardisierten verhaltenstherapeutischen Behandlungskonzept. Dabei sind über einen Zeitraum von 17 Wochen 15 Gruppen- und acht Einzelsitzungen vorgesehen. Zusätzlich werden zwei Auffrischungssitzungen (Booster Sessions) angeboten. Das Ziel der Online-Therapie ist es, negative Begleiterscheinungen von problematischer Internetnutzung zu reduzieren und Hilfestellung zu geben, wenn die Nutzung einer bestimmten Internetanwendung Probleme verursacht. Dabei werden keine Daten zu persönlichen Inhalten gespeichert, die innerhalb der therapeutischen Sitzungen besprochen werden. Im Zusammenhang mit den Therapiesitzungen werden lediglich die Anwesenheit, das allgemeine Thema der Sitzung, das Auftreten schwerwiegender Ereignisse und deren möglicher Zusammenhang mit der Therapie erfasst. Diese Angaben sind relevant, um die Wirksamkeit der Hilfen beurteilen zu können.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),

        // block 3
        Text("Übermittlung von Sozialdaten", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text:
                      "Um außerdem zu prüfen, ob das stufenweise Hilfeangebot dazu führen kann, die finanzielle Belastung des Gesundheitssystems zu reduzieren, würden wir gerne auf Ihre gespeicherten Sozialdaten zugreifen. Diese würden wir nach Ihrer Zustimmung mit Hilfe Ihrer Krankenversichertennummer bei Ihrer Krankenkasse anfragen. Dabei werden lediglich die Anzahl der ausgefallenen Arbeitstage (Krankschreibungstage), verursachte Kosten für ambulante oder stationäre Behandlungen sowie Arzneimittel übermittelt. Ziel ist, finanzielle Auswirkungen auf das Gesundheitssystem 12 Monate vor und 12 Monate nach Eintritt in das stufenweise Hilfeangebot der SCAVIS-Studie zu erfassen. ",
                  style: TextStyle(fontSize: 14, color: MyTheme.TEXT_COLOR)),
              TextSpan(
                  text: "Erkrankungen oder Diagnosen, die Ihrer Person zugeordnet sind, werden NICHT übermittelt. ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.TEXT_COLOR)),
              TextSpan(
                  text: "Die Daten werden zur statistischen Auswertung nicht mit Ihrem Namen in Verbindung gebracht, sondern mit Hilfe der Identifikationsnummer pseudonymisiert.",
                  style: TextStyle(fontSize: 14, color: MyTheme.TEXT_COLOR)),
            ],
          ),
        ),
        SizedBox(height: 20),

        // block 4
        Text("Datenübermittlung", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "Es werden in ", style: TextStyle(fontSize: 14, color: MyTheme.TEXT_COLOR)),
              TextSpan(text: "keinem Fall Daten an Arbeitgeber oder Krankenkassen übermittelt ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.TEXT_COLOR)),
              TextSpan(
                  text: " oder an andere unbefugte Dritte weitergegeben. Alle an der Studie beteiligten Mitarbeiter*innen unterliegen der Schweigepflicht.",
                  style: TextStyle(fontSize: 14, color: MyTheme.TEXT_COLOR)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
            "Nach Einwilligung zur Studienteilnahme werden die Teilnehmenden auf ein separates Formular geleitet, in dem sie gebeten werden, ihre Kontaktdaten anzugeben. Dies ist für die Kontaktaufnahme für die telefonische Beratung, gegebenenfalls die Online-Therapie und die Nachbefragung erforderlich. Diese Daten werden getrennt von den Erhebungsdaten gespeichert. Eine Übertragung der Kontaktdaten an die Therapeut*innen der Telefonberatung und der Online-Therapie findet ausschließlich verschlüsselt statt. Nach Abschluss der Studie werden die Kontaktdaten sämtlicher Teilnehmenden umgehend gelöscht.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Alle Fragebogen- und Tracking-Daten werden direkt in der App erhoben und verschlüsselt auf einen gesicherten Server der Universität Ulm übertragen. Daten aus dem Tracking, die Rückschlüsse auf eine andere Person zulassen würden (z.B.: Telefonnummern oder Namen von Kontakten), werden vor der Übertragung zum Server verfremdet.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Für die telefonische Beratung sowie für die Online-Beratung erhalten die zuständigen Therapeut*innen die verschlüsselten Kontaktdaten der Teilnehmenden. Auf die Angaben der Befragung oder die Ergebnisse des Trackings erhalten sie keinen Zugriff. Die Dokumentation im Rahmen der Beratung bzw. Therapie erfolgt über ein gesichertes System und wird verschlüsselt zwischen den Standorten übermittelt. Die verschlüsselte Datei kann nur von Studienmitarbeiter*innen ausgelesen werden.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Die Dokumentation aus Beratung und Therapie wird mit den Befragungs- und Trackingdaten vom Institut für Biometrie und Medizinische Statistik (IMBS) der Universität Lübeck mit Hilfe des Proband*innencodes zusammengeführt. Es werden dabei keine Namen oder Kontaktdaten der Teilnehmenden gespeichert. Das Zentrum für Klinische Studie (ZKS) in Lübeck überwacht die ordnungsgemäße Durchführung der klinischen Studie. Der vollständige Datensatz wird abschließend zur statistischen Auswertung anonymisiert an das Institut für Medizinische Biometrie und Statistik (IMBS) übermittelt. Zur Überprüfung Ihrer Daten dürfen Mitarbeiter*innen der Studie, durch die Studienleitung bevollmächtigte Personen und Vertreter*innen zuständiger Behörden Einsicht in Ihre Daten nehmen. Diese Personen müssen vorher eine Verschwiegenheitserklärung unterschreiben. Ihre Daten bleiben also vertraulich.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Zum Schutz der Daten sind organisatorische Maßnahmen getroffen, die eine Weitergabe an unbefugte Dritte verhindern. So werden während der gesamten Dokumentations- und Auswertungsphase Proband*innendaten lediglich anhand des individuellen Proband*innencodes eines/einer Teilnehmenden zugeordnet, während der vollständige Name der Teilnehmenden nicht in Erscheinung tritt und nur von Studienmitarbeiter*innen mit dem Proband*innencode in Verbindung gebracht werden kann.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text("Die erhobenen Studiendaten werden nach Abschluss der Studie in anonymisierter Form für mindestens zehn Jahre aufbewahrt.", style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),

        // block 5
        Text("Wissenschaftliche Auswertungen / Veröffentlichungen", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text(
            "Die Datenanalyse erfolgt von den beteiligten Universitäten in Lübeck, Ulm und Mainz. Die erhobenen Daten werden in anonymisierter Form in wissenschaftlichen Darstellungen und Veröffentlichungen verwendet. Eine Rückführung auf einzelne Personen ist nicht möglich und nicht notwendig. Zur Auswertung werden vorrangig Gruppenvergleiche herangezogen, um die Veränderung des Internetnutzungsverhaltens bei Teilnehmenden der Interventions- und Kontrollgruppe zu vergleichen. Begleitend dazu werden die anonymen Daten in einem Online-Repository des Open Science Framework hochgeladen, so dass andere Forscher die anonymisierten Daten ebenso verwenden können. Das bedeutet, dass ihre Angaben noch besser die Forschung fördern können.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),

        // block 6
        Text("Widerruf der Teilnahme inkl. Datenlöschung", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text(
            "Die Teilnehmenden können jederzeit auf eigenen Wunsch ohne Angabe von Gründen und ohne, dass ihnen hierdurch irgendein Nachteil erwächst, aus der klinischen Studie ausscheiden. Die Einwilligung zur Studienteilnahme kann, ohne Angabe persönlicher Daten, über ein Kontaktformular auf der Website (www.scavis.net/widerrufsformular/) widerrufen werden. Mit dem Ausscheiden aus der Studie werden keine weiteren Daten z.B. über das Tracking von Ihnen erfasst. Ihre Daten werden nicht in die finale Auswertung eingeschlossen und gelöscht, wenn die Datenerhebung für alle abgeschlossen ist. Vorher ist kein Zugriff auf die Daten möglich. Eine Löschung der Angaben, die Sie während des Screenings innerhalb der App getätigt haben, ist nicht möglich, da die Angaben bis zu Ihrer Einwilligung in die Studienteilnahme völlig anonym gespeichert sind und keiner Person zugeordnet werden können.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),

        // block 7
        Text("Rechtsgrundlage", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text(
            "Rechtsgrundlage für die Verarbeitung Ihrer personenbezogenen Daten ist Ihre Einwilligung nach Art 6 Abs. 1a) DSGVO. Ihre Teilnahme ist freiwillig. Wir behandeln alle erhobenen Daten streng vertraulich und entsprechend der gesetzlichen Datenschutzvorschriften. Die Übermittlung von Sozialdaten im Rahmen der Forschung ist nach §75 des 10. Sozialgesetzbuch für Sozialverwaltungsverfahren und Sozialdatenschutz (SGB X) zulässig, sofern die Erlaubnis der betroffenen Person eingeholt wurde.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),

        // block 8
        Text("Verantwortliche", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text("Die in diesem Projekt für die Datenverarbeitung verantwortliche Person ist:", style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PD Dr. Hans-Jürgen Rumpf", style: TextStyle(fontSize: 14)),
              Text("Universitätsklinikum Schleswig-Holstein (UKSH)", style: TextStyle(fontSize: 14)),
              Text("Universität zu Lübeck, Klinik für Psychiatrie und Psychotherapie", style: TextStyle(fontSize: 14)),
              Text("Ratzeburger Allee 160, 23538 Lübeck", style: TextStyle(fontSize: 14)),
              Text("Tel.: +49 451 500 98751", style: TextStyle(fontSize: 14)),
              Text("E-Mail: hans-juergen.rumpf@uksh.de", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),

        SizedBox(height: 20),

        // block 9
        Text("Kontakt zur Studienkoordination", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text("Sollten zusätzliche Fragen auftauchen, so können Sie Mitarbeiterinnen dieser Studie kontaktieren:", style: TextStyle(fontSize: 14)),
        SizedBox(height: 15),
        // block 9a
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Dr. Anja Bischof", style: TextStyle(fontSize: 14)),
              Text("Universitätsklinikum Schleswig-Holstein (UKSH)", style: TextStyle(fontSize: 14)),
              Text("Universität zu Lübeck, Klinik für Psychiatrie und Psychotherapie", style: TextStyle(fontSize: 14)),
              Text("Ratzeburger Allee 160, 23538 Lübeck", style: TextStyle(fontSize: 14)),
              Text("Tel.: +49 451 500 98753", style: TextStyle(fontSize: 14)),
              Text("E-Mail: anja.bischof@uksh.de", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        SizedBox(height: 15),
        // block 9b
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Dominique Brandt, M.Sc.", style: TextStyle(fontSize: 14)),
              Text("Universitätsklinikum Schleswig-Holstein (UKSH)", style: TextStyle(fontSize: 14)),
              Text("Universität zu Lübeck, Klinik für Psychiatrie und Psychotherapie", style: TextStyle(fontSize: 14)),
              Text("Ratzeburger Allee 160, 23538 Lübeck", style: TextStyle(fontSize: 14)),
              Text("Tel.: +49 451 500 98750", style: TextStyle(fontSize: 14)),
              Text("E-Mail: dominique.brandt@uksh.de", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        SizedBox(height: 20),

        // block 10
        Text("Kontakt des Datenschutzbeauftragten", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("x-tention Informationstechnologie GmbH", style: TextStyle(fontSize: 14)),
              Text("Bürgermeister-Wegele-Str. 12", style: TextStyle(fontSize: 14)),
              Text("86167 Augsburg", style: TextStyle(fontSize: 14)),
              Text("Tel.: +49 451 3101 1903", style: TextStyle(fontSize: 14)),
              Text("E-Mail: datenschutz@uni-luebeck.de", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        SizedBox(height: 20),

        // block 11
        Text("Aufwandsentschädigung", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text(
            "Alle Teilnehmenden am Screening erhalten innerhalb der App eine Rückmeldung zu ihrer Internetnutzung und auf Wunsch zu weiteren Bereichen. Unter allen Teilnehmenden des Screenings werden 20 Gutscheine in Höhe von 100,- € und 40 Gutscheine in Höhe von 50,- € verlost. Um bei der Verlosung mitzumachen, ist es notwendig eine gültige E-Mailadresse zu hinterlegen, damit im Falle eines Gewinns der Gutschein zugesendet werden kann. Die Teilnahme ist freiwillig.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Personen, die sich nach dem Screening für die weitere Studienteilnahme bereit erklären, erhalten eine Aufwandsentschädigung in Höhe von 15,- €. Dazu werden Amazon-Gutscheine per E-Mail an die in den Kontaktdaten erfasste E-Mailadresse versendet, welche für den weiteren Studienverlauf hinterlegt werden muss. Die Teilnehmenden der Interventionsgruppe erhalten außerdem kostenlos Feedback zu ihrem Internetnutzungsverhalten und gegebenenfalls weitere Beratungs- oder Therapieangebote.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Nehmen die Betroffenen nach sechs bis neun Monaten an der Nachbefragung teil, erhalten sie einen weiteren Gutschein in Höhe von 30,- Euro ebenfalls per E-Mail zugeschickt. Unter allen Teilnehmenden der Nachbefragung werden zusätzlich weitere zehn Gutscheine in Höhe von 100,- € und 20 Gutscheine in Höhe von 50,- € verlost.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),

        // block 12
        Text("Freiwilligkeit", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Es werden die Richtlinien der Datenschutz-Grundverordnung (DSGVO) eingehalten. Ihre Teilnahme ist für Sie mit keinerlei Risiken verbunden. Es werden ",
                  style: TextStyle(fontSize: 14, color: MyTheme.TEXT_COLOR)),
              TextSpan(
                  text: "keine Daten an Ihren Arbeitgeber, Ihre Krankenkasse oder andere unbefugte Dritte weitergegeben. ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.TEXT_COLOR)),
              TextSpan(
                  text:
                      "Die Nutzung der App sowie die telefonische Beratung und die Online-Therapie sind für Sie mit keinerlei Kosten verbunden. Beide Angebote werden im Rahmen des Projektes übernommen, wofür vor Beginn noch eine separate Einwilligungserklärung getroffen wird. Die Teilnahme an der Untersuchung ist freiwillig und kann jederzeit ohne Angabe von Gründen widerrufen werden. Die Aufzeichnung der Internetnutzung (Tracking) kann ebenfalls freiwillig aktiviert werden und ist kein verpflichtender Bestandteil der Studie.",
                  style: TextStyle(fontSize: 14, color: MyTheme.TEXT_COLOR)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
            "Sollte der weiteren Teilnahme an der Studie nicht zugestimmt werden, kann dennoch das Informationsangebot der App genutzt werden. Sollte das nicht von Interesse sein, kann die App vom Smartphone deinstalliert werden.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),

        // block 13
        Text("Minderjährige", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text(
            "Minderjährige, die mindestens 16 Jahre alt sind, sind dazu verpflichtet, ihre Eltern / Sorgeberechtigten über die Studienteilnahme zu informieren. Hierfür kann der folgende Link direkt an die Eltern / Sorgeberechtigten weitergeleitet werden:",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        InkWell(
          child: Text("https://www.scavis.net/wp-content/themes/scavis/assets/pdf/SCAVIS-Erklaerung_Sorgeberechtigte.pdf", style: TextStyle(fontSize: 14, color: MyTheme.TEXT_LINK_COLOR)),
          onTap: () async {
            String url = "https://www.scavis.net/wp-content/themes/scavis/assets/pdf/SCAVIS-Erklaerung_Sorgeberechtigte.pdf";
            if (await canLaunch(url)) {
              launch(url);
            }
          },
        ),
        SizedBox(height: 10),
        Text(
            "Nach DSGVO können Minderjährige auch ohne explizite Einwilligung der Sorgeberechtigten an der Studie teilnehmen. Personen unter 16 Jahren ist es nicht möglich an der Studie teilzunehmen.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),

        // block 14
        Text("Einwilligung", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text("Studie: Stepped Care Ansatz zur Versorgung Internetbezogener Störungen (SCAVIS)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(
            "Ich bin umfassend über Inhalt, Zweck und Umfang der Studie informiert worden. Die Teilnahme an der Studie ist freiwillig und kann jederzeit ohne Angabe von Gründen abgebrochen werden. Die Hinweise zur Datenverarbeitung habe ich aufmerksam gelesen und ich stimme der dort beschriebenen Verarbeitung meiner Daten zu. Diese Proband*inneninformationen habe ich gelesen und kann sie bei Bedarf herunterladen.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        Text(
            "Hiermit erkläre ich mich bereit, an der SCAVIS-Studie und dem damit verbundenen stufenweisen Versorgungssystem teilzunehmen. Mir ist bewusst, dass der Aufzeichnung meiner Internetnutzung zu wissenschaftlichen Zwecken optional zugestimmt werden kann. Ich erkläre mich weiterhin bereit, dass beim Vorliegen von Schwierigkeiten mit der Smartphonenutzung meine Kontaktdaten verschlüsselt an Berater*innen oder Psychotherapeut*innen übermittelt werden dürfen, damit diese mich für die telefonische Beratung und gegebenenfalls für die Online-Therapie kontaktieren können.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),
        Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Ja, ich möchte an der Studie ", style: TextStyle(fontSize: 14, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                      TextSpan(text: "inklusive ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                      TextSpan(text: "Tracking teilnehmen.", style: TextStyle(fontSize: 14, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: MyTheme.col2,
                  onPrimary: MyTheme.col2Text,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                ),
                onPressed: () {
                  giveConsent(1);
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Ja, ich möchte an der Studie teilnehmen, aber ", style: TextStyle(fontSize: 14, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                      TextSpan(text: "nicht ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                      TextSpan(text: "getrackt werden..", style: TextStyle(fontSize: 14, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: MyTheme.col2,
                  onPrimary: MyTheme.col2Text,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                ),
                onPressed: () {
                  giveConsent(2);
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Nein, ich möchte nicht teilnehmen.", style: TextStyle(fontSize: 14, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: MyTheme.col2,
                  onPrimary: MyTheme.col2Text,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                ),
                onPressed: () {
                  giveConsent(0);
                },
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget buildSocialDataInformation() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(children: [
        Text(
            "Des Weiteren erkläre ich mich hiermit bereit, dass mit meiner Krankenversichertennummer meine Sozialdaten (d.h. Anzahl der Krankentage, Kosten für ambulante und stationäre Behandlungen, Kosten für Arzneimittel) bei meiner Krankenkasse angefragt werden dürfen.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),
        Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Ja, meine Sozialdaten dürfen von der Krankenkasse eingeholt werden.", style: TextStyle(fontSize: 14, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: MyTheme.col2,
                  onPrimary: MyTheme.col2Text,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                ),
                onPressed: () {
                  setInsuranceDataAnswer(1);
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Nein, ich möchte nicht, dass meine Sozialdaten bei der Krankenkasse erfragt werden.", style: TextStyle(fontSize: 14, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: MyTheme.col2,
                  onPrimary: MyTheme.col2Text,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                ),
                onPressed: () {
                  setInsuranceDataAnswer(0);
                },
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget buildDataForm() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(children: [
        // block 1
        Text(
            "Vielen Dank für Ihr Interesse an der SCAVIS-Studie und dass Sie sich zur weiteren Teilnahme bereiterklärt haben. Um Sie, falls zutreffend und gewünscht, für die telefonische Beratung (Step 2) oder für die Online-Therapie (Step 3) sowie für die Nachbefragung kontaktieren zu können, benötigen wir Ihre Kontaktdaten. Diese werden verschlüsselt aufbewahrt und können nicht mit Ihren Befragungs- oder Nutzungsdaten in Verbindung gebracht werden.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),
        TextField(
          controller: _controllerName,
          decoration: InputDecoration(
            hintText: "Name",
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _controllerPhoneNumber,
          decoration: InputDecoration(
            hintText: "Telefonnummer",
          ),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 20),
        TextField(
          controller: _controllerEmailAddress,
          decoration: InputDecoration(
            hintText: "E-Mailadresse",
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20),
        TextField(
          controller: _controllerAddress,
          decoration: InputDecoration(
            hintText: "Optional: Postalische Adresse",
          ),
          maxLines: addressMaxLines,
        ),
        SizedBox(height: 20),
        insuranceDataAnswer == 1
            ? Column(
                children: [
                  TextField(
                    controller: _controllerInsuranceNumber,
                    decoration: InputDecoration(
                      hintText: "Krankenversicherungsnummer",
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )
            : Container(),
        Text(
            "Um uns für Ihre Teilnahme an der SCAVIS-Studie zu bedanken, haben wir als Aufwandsentschädigung einen Amazon-Gutschein in Höhe von 15,- Euro für Sie vorgesehen. Den Gutscheincode würden wir Ihnen über die angegebene E-Mailadresse zukommen lassen. Prüfen Sie also bitte, dass Sie eine korrekte E-Mailadresse eingetragen haben, deren Postfach Sie regelmäßig überprüfen.",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),
        this.contactDataServerErrorMessageVisible
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text(
                      "Die Daten konnten nicht gesendet werden, bitte versuchen Sie es erneut.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )
            : Container(),
        this.contactDataMissingrErrorMessageVisible
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text(
                      "Bitte tragen Sie alle Daten ein.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )
            : Container(),
        Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Weiter", style: TextStyle(fontSize: 14, color: MyTheme.PRIMARY_BUTTON_TEXT_COLOR)),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: MyTheme.col2,
                  onPrimary: MyTheme.col2Text,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                ),
                onPressed: () {
                  setContactDataAnswer();
                },
              ),
            ),
          ],
        )
      ]),
    );
  }
}

class MyBullet extends StatelessWidget {
  final String text;
  final TextStyle style;

  MyBullet(this.text, {this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.only(right: 10, top: 3),
            decoration: new BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            child: Flexible(
              child: Text(
                this.text,
                style: this.style ?? TextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
