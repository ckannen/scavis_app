import 'package:flutter/material.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/gui/intervention/status.dart';
import 'package:scavis/theme/my-theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'tasks.dart';

class InterventionMainScreen extends StatefulWidget {
  static const String ROUTE = "/intervention-main/";

  @override
  _InterventionMainScreenState createState() => _InterventionMainScreenState();
}

class _InterventionMainScreenState extends State<InterventionMainScreen> {
  int tabNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);

    AppBar appBar = MyAppBar.createDefaultAppBar();

    double innerHeight = mqd.size.height - mqd.padding.vertical - appBar.preferredSize.height;

    List<Widget> tabs = [
      // HOME tab
      StatusScreen(),
      // TASKS tab
      TasksView(),
      Center(
        child: Text("Feedback"),
      ),
      Container(
        child: WebView(
          initialUrl: 'https://flutter.dev',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {},
        ),
      ),
    ];

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: tabs[this.tabNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this.tabNavigationIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "Aufgaben"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Feedback"),
          BottomNavigationBarItem(icon: Icon(Icons.text_snippet_outlined), label: "Prävention"),
        ],
        onTap: (index) {
          setState(() {
            this.tabNavigationIndex = index;
          });
        },
      ),
    );
  }
}
