import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/theme/my-theme.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoreInfoScreen extends StatefulWidget {
  static const String ROUTE = "/more-info/";

  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.createDefaultAppBar(),
      backgroundColor: MyTheme.BACKGROUND_COLOR,
      body: SafeArea(
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            child: WebView(
              initialUrl: "https://www.scavis.net",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {},
              onWebResourceError: (WebResourceError error) {
                Navigator.pop(context);
                Fluttertoast.showToast(
                  msg: "Keine Internetverbindung",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: MyTheme.BACKGROUND_COLOR_ACCENT,
                  textColor: MyTheme.TEXT_COLOR_INVERSE,
                  fontSize: 16.0,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
