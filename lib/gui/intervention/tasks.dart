import 'package:flutter/material.dart';
import 'package:scavis/gui/intervention/task-entry.dart';

class TasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);

    List<Widget> entries = [];
    int taskCount = 4;
    for (int i = 0; i < taskCount; i++) {
      if (i > 0) {
        entries.add(Divider(
          color: Colors.black,
        ));
      }
      entries.add(TaskEntry(title: "Stimmungs-Fragebogen " + (i+1).toString(), description: "Stimmungsfragebogen vom 01.01.2021"));
    }
    if (taskCount == 0) {
      entries.add(Text("Großartig! Sie haben alle Aufgaben erledigt. Wir benachrichtigen Sie sobald neue Aufgaben zur Verfügung stehen."));
    }

    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Color.fromRGBO(200, 200, 200, 1),
            child: Text("Hier sehen Sie alle aktuellen Aufgaben"),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(children: entries),
          ),
        ],
      ),
    );
  }
}
