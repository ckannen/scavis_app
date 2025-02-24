import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/theme/my-theme.dart';

class AbortInterventionGroupScreen extends StatefulWidget {
  static const String ROUTE = "/finished-intervention-group/";
  @override
  _AbortInterventionGroupScreenState createState() => _AbortInterventionGroupScreenState();
}

class _AbortInterventionGroupScreenState extends State<AbortInterventionGroupScreen> {
  bool participateInOnlineTherapy;
  bool participateInPhoneTherapy;

  bool initialized = false;
  bool abort = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    ScavisCouchbase db = ScavisCouchbase();

    dynamic questionnaireResults = await db.loadQuestionnaireResults();
    try {
      if (questionnaireResults["icat"]["computation"]["decision-on-day-1"] == 'abort') {
        abort = true;
        initialized = true;
      } else if (questionnaireResults["icat"]["computation"]["decision-on-day-1"] == 'continue') {
        Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE);
      }
    } catch (e) {
      print("could not access data");
    }

    // if not data available, try again in 5 seconds
    if (!initialized) {
      Timer(Duration(seconds: 5), () {
        loadData();
      });
    }
  }

  void storeData() async {
    ScavisCouchbase database = ScavisCouchbase();

    // store document with answers in database
    await database.storeQuestionnaireAnswer(
        surveyId: 'online-therapy',
        day: 1,
        pageIndex: 0,
        itemIndex: 0,
        answer: {"value": participateInOnlineTherapy, "text": participateInOnlineTherapy ? "Ja ..." : "Nein ...", "question": "Online-Therapie"});
    await database.storeQuestionnaireAnswer(
        surveyId: 'phone-counseling',
        day: 1,
        pageIndex: 0,
        itemIndex: 0,
        answer: {"value": participateInPhoneTherapy, "text": participateInPhoneTherapy ? "Ja ..." : "Nein ...", "question": "Telefon-Beratung"});

    // abort participation for participant
    if (participateInOnlineTherapy || participateInPhoneTherapy) {
      var appStateManager = AppStateManager();
      appStateManager.participantSchedule["preventionStartDt"] = null;
      appStateManager.participantSchedule["studyPart2StartDt"] = null;
      appStateManager.participantSchedule["trackingStartDt"] = null;
      appStateManager.participantSchedule["studyPart2Aborted"] = true;
      appStateManager.storeParticipantSchedule();
    }

    Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.createDefaultAppBar(),
      backgroundColor: MyTheme.BACKGROUND_COLOR,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (!initialized) {
              return Center(child: Text("Verarbeite Daten ..."));
            }
            return Container(
              margin: EdgeInsets.all(20),
              child: ListView(
                children: createContent(),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> createContent() {
    if (participateInOnlineTherapy == null)
      return [
        Text(
          "Vielen Dank für Ihre Angaben. Möglicherweise haben Sie zum Teil bereits eher unangenehme Auswirkungen der Internetnutzung erlebt.",
        ),
        SizedBox(height: 10),
        Text(
          "Wir möchten Ihnen gerne anbieten eine weitergehende Hilfe in Anspruch zu nehmen. Als Teil des Projektes besteht die Möglichkeit, die Themen mit Expert*innen und anderen Teilnehmenden zu besprechen. Diese Online-Therapie beinhaltet Einzel- und Gruppensitzungen und ihre Wirksamkeit wurde bereits wissenschaftlich überprüft. Es entstehen dabei für Sie keine Kosten, diese werden über das Projekt finanziert.",
        ),
        SizedBox(height: 10),
        Text(
          "Wenn Sie damit einverstanden sind, brauchen Sie sich um nichts Weiteres zu kümmern. Sie werden von uns zur weiteren Absprache kontaktiert.",
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            child: Text("Ja, ich möchte kontaktiert werden."),
            style: ElevatedButton.styleFrom(
              primary: MyTheme.col2,
              onPrimary: MyTheme.col2Text,
              padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            ),
            onPressed: () {
              setState(() {
                participateInOnlineTherapy = true;
              });
            },
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            child: Text("Nein, ich möchte nicht kontaktiert werden."),
            style: ElevatedButton.styleFrom(
              primary: MyTheme.col2,
              onPrimary: MyTheme.col2Text,
              padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            ),
            onPressed: () {
              setState(() {
                participateInOnlineTherapy = false;
              });
            },
          ),
        ),
      ];
    if (participateInOnlineTherapy == false && participateInPhoneTherapy == null)
      return [
        Text(
          "Dann ist das vielleicht nicht das richtige Angebot für Sie. Stattdessen gibt es auch die Möglichkeit, eine telefonische Beratung in Anspruch zu nehmen, die zweimal 50 Minuten umfasst.",
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            child: Text("Ja, ich möchte an der telefonischen Beratung teilnehmen."),
            style: ElevatedButton.styleFrom(
              primary: MyTheme.col2,
              onPrimary: MyTheme.col2Text,
              padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            ),
            onPressed: () {
              setState(() {
                participateInPhoneTherapy = true;
              });
            },
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            child: Text("Nein, ich möchte nicht an der telefonischen Beratung teilnehmen."),
            style: ElevatedButton.styleFrom(
              primary: MyTheme.col2,
              onPrimary: MyTheme.col2Text,
              padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            ),
            onPressed: () {
              setState(() {
                participateInPhoneTherapy = false;
              });
            },
          ),
        ),
      ];
    if (participateInOnlineTherapy == false && participateInPhoneTherapy == false)
      return [
        Text(
          "Das scheint für Sie nicht zu passen. In diesem Fall erhalten Sie weitere Tipps und Hinweise im Präventionsmodul der smart@net-App.",
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            child: Text("Fertig"),
            style: ElevatedButton.styleFrom(
              primary: MyTheme.col2,
              onPrimary: MyTheme.col2Text,
              padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            ),
            onPressed: () {
              storeData();
            },
          ),
        ),
      ];
    return [
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          child: Text("Wir werden Sie in den nächsten Wochen kontaktieren."),
          style: ElevatedButton.styleFrom(
            primary: MyTheme.col2,
            onPrimary: MyTheme.col2Text,
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          ),
          onPressed: () {
            storeData();
          },
        ),
      ),
    ];
  }
}
