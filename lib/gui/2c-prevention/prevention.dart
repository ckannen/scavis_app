import 'package:flutter/material.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'prevention-manager.dart';

class PreventionView extends StatefulWidget {
  static const String ROUTE = "/setup-screen/";

  @override
  _PreventionViewState createState() => _PreventionViewState();
}

class _PreventionViewState extends State<PreventionView> {
  int currentWeek;
  @override
  initState() {
    super.initState();
    setCurrentWeek();
  }

  // get the current week for the prevention module
  setCurrentWeek() async {
    int week = await PreventionManager.getCurrentWeek();
    if (week != null) {
      setState(() {
        this.currentWeek = week;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);

    if (currentWeek == null) {
      return Container(child: Center(child: Text("Präventionsmodul wird geladen")));
    }
    return WebView(
      initialUrl: 'https://www.scavis.net/wochenthemen/?amount=$currentWeek',
    );
  }
}
