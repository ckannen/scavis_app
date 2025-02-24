import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  static const String ROUTE = "/intervention-main/";

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

enum Status { notStarted, tracking, tasksTodo, error, ended }

class _StatusScreenState extends State<StatusScreen> {
  Status status = Status.ended;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          status == Status.notStarted
              ? Center(
                  child: Column(
                    children: [
                      Icon(Icons.access_alarm_rounded, color: Colors.blue, size: 80),
                      Text("Das App-Tracking startet in 1 Tag"),
                    ],
                  ),
                )
              : Container(),
          status == Status.tracking
              ? Center(
                  child: Column(
                    children: [
                      Icon(Icons.search, color: Colors.green, size: 80),
                      Text("Die App zeichnet korrekt auf."),
                      Text("Das Tracking läuft bereits seit 1 Tag und noch für weitere 30 Tage."),
                    ],
                  ),
                )
              : Container(),
          status == Status.tasksTodo
              ? Container(
                  child: Column(
                    children: [
                      Icon(Icons.today, color: Colors.blue, size: 80),
                      Text("Es stehen Aufgaben für Sie bereit."),
                      Text("Bitte klicken Sie auf Aufgaben und schließen diese ab."),
                    ],
                  ),
                )
              : Container(),
          status == Status.error
              ? Container(
                  child: Column(
                    children: [
                      Icon(Icons.warning, color: Colors.yellow, size: 80),
                      Text("Die App zeichnet NICHT korrekt auf."),
                      Text("Bitte prüfen Sie die Einstellungen. Hilfe dazu finden Sie auf der Webseite ..."),
                    ],
                  ),
                )
              : Container(),
            status == Status.ended
              ? Container(
                  child: Column(
                    children: [
                      Icon(Icons.check, color: Colors.green, size: 80),
                      Text("Das Tracking wurde beendet. Die Teilnahme der Studie ist damit für Sie abgeschlossen."),
                      Text("Sie können die App weiter nutzen, um auf das Präventionsmodul zuzugreifen."),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
