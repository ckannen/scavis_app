import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/my-notifications/my-notifications.dart';
import 'package:scavis/theme/my-theme.dart';

class AssignToControlGroupScreen extends StatefulWidget {
  static const String ROUTE = "/assign-to-control-group/";
  @override
  _AssignToControlGroupScreenState createState() => _AssignToControlGroupScreenState();
}

class _AssignToControlGroupScreenState extends State<AssignToControlGroupScreen> {
  @override
  void initState() {
    super.initState();
    activateControlGroupScreening();
  }

  // activate control group screening
  activateControlGroupScreening() async {
    var appStateManager = AppStateManager();

    await appStateManager.loadParticipantSchedule();
    if (appStateManager.participantSchedule != null) {
      DateTime nowDt = DateTime.now();
      DateTime tomorrowDt = nowDt.add(Duration(days: 1));
      tomorrowDt = tomorrowDt.toLocal();
      DateTime startDt = new DateTime(tomorrowDt.year, tomorrowDt.month, tomorrowDt.day, 19, 0, 0, 0, 0);
      appStateManager.participantSchedule["studyPart2StartDt"] = startDt.toIso8601String();
      appStateManager.storeParticipantSchedule();

      // add notification
      addNotification(startDt);
    }
  }

  // add a notification
  addNotification(DateTime startDt) {
    int notificationId = Random.secure().nextInt(1000000000);
    MyNotification notification = MyNotification(context);
    notification.initNotification();
    notification.createNotification(notificationId, startDt, "smart@net", "Es steht ein neuer Fragebogen für Sie bereit.");
  }

  // request the permission to send notifications
  requestPermission() {
    MyNotification notification = MyNotification(context);
    if (Platform.isIOS) {
      notification.requestIOSPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.createDefaultAppBar(),
      backgroundColor: MyTheme.BACKGROUND_COLOR,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              margin: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Text(
                    "Sie sind in der Kontrollgruppe!",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Zunächst möchten wir Ihnen einige weitere Fragen zu Ihrer Internetnutzung stellen, wie beispielsweise mögliche Probleme, die dabei auftreten oder Ihre Erwartungen, die Sie an die Internetnutzung haben. Im Anschluss wird Sie für das Präventionsmodul freigeschaltet. Dort erwarten Sie spannende Informationen, Links sowie Podcasts zu riskanter und zu verantwortungsvoller Internetnutzung.",
                  ),
                  Text(
                    "Die Befragung erhalten Sie morgen um 19:00 Uhr.",
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      child: Text("OK"),
                      style: ElevatedButton.styleFrom(
                        primary: MyTheme.col2,
                        onPrimary: MyTheme.col2Text,
                        padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                      ),
                      onPressed: () {
                        requestPermission();
                        Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
