import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/gui/2a-task-list/task-list.dart';
import 'package:scavis/gui/2b-feedback/feedback.dart';
import 'package:scavis/gui/2c-prevention/prevention-manager.dart';
import 'package:scavis/gui/2c-prevention/prevention.dart';
import 'package:scavis/gui/2d-settings/settings.dart';
import 'package:scavis/gui/2a-task-list/task-list-screen.dart';
import 'package:scavis/theme/my-theme.dart';

class MainMenuScreen extends StatefulWidget {
  static const String ROUTE = "/main-menu/";
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool routeArgumentsRead = false;
  int tabIndex = 0;
  int initialFeedbackTabIndex = 0;

  getTabBarInfo() async {
    List<Widget> taskList = await TaskList.getTaskList(context, 1);
    int preventionWeek = await PreventionManager.getCurrentWeek();
    return {
      "taskList": taskList,
      "preventionWeek": preventionWeek,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (!routeArgumentsRead) {
      dynamic args = ModalRoute.of(context).settings.arguments;
      if (args != null) {
        if (args["tab"] == "feedback") {
          setState(() {
            tabIndex = 1;
          });
          if (args["feedback"] == "optional-screening") {
            setState(() {
              initialFeedbackTabIndex = 4;
            });
          }
        }
        if (args["tab"] == "prevention") {
          setState(() {
            tabIndex = 2;
          });
        }
      }
      routeArgumentsRead = true;
    }

    return FutureBuilder<dynamic>(
      future: getTabBarInfo(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> taskList = [];
        int preventionWeek;
        if (snapshot.hasData) {
          taskList = snapshot.data["taskList"];
          preventionWeek = snapshot.data["preventionWeek"];
        }

        MediaQueryData mqd = MediaQuery.of(context);

        AppBar appBar = MyAppBar.createDefaultAppBar();

        if (taskList == null) {
          return Scaffold(appBar: appBar, backgroundColor: Colors.white, body: Center(child: Text("Loading ...")));
        }

        var items = [
          BottomNavigationBarItem(
            icon: taskList.length > 0
                ? Badge(
                    badgeColor: MyTheme.primary1,
                    borderSide: BorderSide(color: Colors.white, width: 1),
                    badgeContent: Text("${taskList.length}", style: TextStyle(color: Colors.white)),
                    child: Icon(FontAwesomeIcons.clipboardList),
                  )
                : Icon(FontAwesomeIcons.clipboardList),
            label: "Aufgaben",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartBar),
            label: "Feedback",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.handsHelping),
            label: "Prävention",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cog),
            label: "Einstellungen",
          ),
        ];
        if (preventionWeek == null) {
          items.removeAt(2);
        }

        BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // only needed for more than 3 items
          selectedItemColor: MyTheme.primary1,
          items: items,
          currentIndex: tabIndex,
          onTap: (_tabIndex) {
            setState(
              () {
                tabIndex = _tabIndex;
              },
            );
          },
        );
        double headerHeight = appBar.preferredSize.height;
        double footerHeight = 200;
        double contentHeight = mqd.size.height - mqd.padding.vertical - headerHeight - footerHeight;

        return Scaffold(
          appBar: appBar,
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              switch (tabIndex) {
                case 0:
                  return TaskListView();
                  break;
                case 1:
                  return FeedbackView(
                    initialTabIndex: initialFeedbackTabIndex,
                  );
                  break;
                case 2:
                  if (preventionWeek != null) {
                    return PreventionView();
                  } else {
                    return SettingsView();
                  }
                  break;
                case 3:
                  return SettingsView();
                  break;
              }
              return Container(
                color: Colors.blue,
                width: double.infinity,
                height: constraints.maxHeight,
              );
            },
          ),
          bottomNavigationBar: bottomNavigationBar,
        );
      },
    );
  }
}
