import 'package:flutter/material.dart';
import 'package:scavis/gui/2a-task-list/task-list.dart';

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double tileWidth = constraints.maxWidth - 30;

      return FutureBuilder<List<Widget>>(
          future: TaskList.getTaskList(context, tileWidth),
          builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            List<Widget> taskList = [];
            if (snapshot.hasData) {
              taskList = snapshot.data;
            }
            return Container(
              alignment: Alignment.center,
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    alignment: Alignment.center,
                    child: Text("${taskList.length} neue Aufgabe" + (taskList.length == 1 ? "" : "n"), style: TextStyle(fontSize: 24)),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    child: Text(
                        "In dieser Liste sehen Sie alle Aufgaben, die noch zu erledigen sind. Bitte arbeiten Sie die Liste immer schnellstmöglich ab. Klicken Sie auf eine der Kacheln, um die Aufgabe zu starten.",
                        style: TextStyle(fontSize: 16)),
                  ),
                  taskList.length != 0
                      ? Column(
                          children: taskList,
                        )
                      : Container(
                          margin: EdgeInsets.all(15),
                          alignment: Alignment.center,
                          child: Text("Zurzeit keine Aufgaben"),
                        ),
                ],
              ),
            );
          });
    });
  }
}
