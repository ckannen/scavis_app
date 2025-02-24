import 'package:flutter/material.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/theme/my-theme.dart';

class FinishedControlGroupScreen extends StatefulWidget {
  static const String ROUTE = "/finished-control-group/";
  @override
  _FinishedControlGroupScreenState createState() => _FinishedControlGroupScreenState();
}

class _FinishedControlGroupScreenState extends State<FinishedControlGroupScreen> {
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
                    "Vielen Dank für Ihre Angaben.",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Sie können nun das Präventionsmodul innerhalb der smart@net-App nutzen. Dort finden Sie interessante und hilfreiche Informationen zu gesunder Internetnutzung und internetbezogenen Störungen. Wir kontaktieren Sie in sechs Monaten zu einer weiteren Befragung, für die Sie einen Amazon-Gutschein in Höhe von 30,- Euro erhalten.",
                  ),
                  SizedBox(height: 20),
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
                        Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE, arguments: {"tab": "prevention"});
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
