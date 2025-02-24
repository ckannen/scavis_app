import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/my-notifications/my-notifications.dart';
import 'package:scavis/theme/my-theme.dart';

class AssignToPreventionGroupScreen extends StatefulWidget {
  static const String ROUTE = "/assign-to-prevention-group/";
  @override
  _AssignToPreventionGroupScreenState createState() => _AssignToPreventionGroupScreenState();
}

class _AssignToPreventionGroupScreenState extends State<AssignToPreventionGroupScreen> {
  TextEditingController _controllerEmailAddress = TextEditingController();
  bool networkWarningVisible = false;

  bool raffleServerErrorMessageVisible = false;

  @override
  void initState() {
    super.initState();
    activatePreventionModule();
  }

  // activate prevention module
  activatePreventionModule() async {
    var appStateManager = AppStateManager();

    await appStateManager.loadParticipantSchedule();
    if (appStateManager.participantSchedule != null) {
      DateTime nowDt = DateTime.now();
      appStateManager.participantSchedule["preventionStartDt"] = nowDt.toIso8601String();
      appStateManager.storeParticipantSchedule();

      DateTime nextWeekDt = nowDt.add(Duration(days: 7));
      nextWeekDt = nextWeekDt.toLocal();
      DateTime startDt = new DateTime(nextWeekDt.year, nextWeekDt.month, nextWeekDt.day, 19, 0, 0, 0, 0);

      // add notifications
      for (int i = 0; i < 26; i++) {
        DateTime notificationDt = startDt.add(Duration(days: i * 7));
        addNotification(notificationDt);
      }
    }
  }

  // send the email address to the server for the raffle
  void sendEmailAddressToServer() async {
    setState(() {
      raffleServerErrorMessageVisible = false;
    });

    // send the data to the server
    try {
      const String URL = "https://app.scavis.net/app-api/save-email-address-for-raffle.php";
      Response response = await Dio().post(URL, data: {"emailAddress": _controllerEmailAddress.text});
      dynamic jsonRespnse = jsonDecode(response.data);
      if (jsonRespnse["status"] == "ok" || jsonRespnse["status"] == "no data") {
        // change app state
        AppStateManager appStateManager = AppStateManager();
        appStateManager.appState[AppStateNames.RAFFLE_EMAIL_ENTERED] = true;
        appStateManager.storeAppState();

        // go to prevention screen
        Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE, arguments: {"tab": "prevention"});
      } else {
        setState(() {
          raffleServerErrorMessageVisible = true;
        });
      }
    } on Exception catch (e) {
      setState(() {
        raffleServerErrorMessageVisible = true;
      });
      print("$runtimeType.setContactDataAnswer: $e");
    }
  }

  // add a notification
  addNotification(DateTime startDt) {
    int notificationId = Random.secure().nextInt(1000000000);
    MyNotification notification = MyNotification(context);
    notification.initNotification();
    notification.createNotification(notificationId, startDt, "smart@net", "Es stehen neue Inhalte im Präventionsmodul zur Verfügung.");
  }

  // request the permission to send notifications
  requestPermission() {
    MyNotification notification = MyNotification(context);
    if (Platform.isIOS) {
      notification.requestIOSPermission();
    }
  }

  void finishGroupAssigning() {}

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
                    "Vielen Dank für Ihre Teilnahme an der Befragung zur SCAVIS-Studie!",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Als Dankeschön für die Unterstützung unserer Studie verlosen wir unter allen Teilnehmenden 20 Gutscheine in Höhe von 100,- € und 40 Gutscheine in Höhe von 50,- €. Für eine Teilnahme an der Verlosung ist es notwendig, eine gültige E-Mail-Adresse zu hinterlegen, damit wir im Falle eines Gewinns den Gutschein verschicken können. Die Teilnahme an der Verlosung ist freiwillig. Sollten Sie nicht an der Verlosung teilnehmen wollen, lassen Sie das Feld bitte leer.",
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: TextField(
                      controller: _controllerEmailAddress,
                      decoration: InputDecoration(
                        hintText: "E-Mail-Adresse",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Wenn Sie möchten, können Sie weiterhin das Präventionsmodul innerhalb der smart@net-App nutzen. Dort finden Sie interessante und hilfreiche Informationen zu gesunder Internetnutzung und internetbezogenen Störungen.",
                  ),
                  SizedBox(height: 20),
                  this.raffleServerErrorMessageVisible
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
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      child: Text("Weiter"),
                      style: ElevatedButton.styleFrom(
                        primary: MyTheme.col2,
                        onPrimary: MyTheme.col2Text,
                        padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                      ),
                      onPressed: () {
                        sendEmailAddressToServer();
                        requestPermission();
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