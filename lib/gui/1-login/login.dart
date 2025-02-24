import 'package:flutter/material.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/gui/1-login/app-consent.dart';
import 'package:scavis/gui/1-login/more-info.dart';
import 'package:scavis/theme/my-theme.dart';

class LoginScreen extends StatefulWidget {
  static const String ROUTE = "/login/";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);

    return Scaffold(
      appBar: MyAppBar.createDefaultAppBar(),
      backgroundColor: MyTheme.BACKGROUND_COLOR_ACCENT,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double footerHeight = 200;
            double imageHeight = 50;
            if (constraints.maxHeight > MyTheme.MAX_HEIGHT_MD) {
              footerHeight = 250;
              imageHeight = 100;
            }
            if (constraints.maxHeight > MyTheme.MAX_HEIGHT_XL) {
              footerHeight = 300;
              imageHeight = 300;
            }
            double contentHeight = constraints.maxHeight - footerHeight;

            return Container(
              color: MyTheme.BACKGROUND_COLOR,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: contentHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/working-man.png", height: imageHeight),
                        Container(height: 20),
                        Text(
                          "SCAVIS-Studie zu\nArbeit und Smartphonenutzung",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: footerHeight,
                    color: MyTheme.BACKGROUND_COLOR_ACCENT,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text("Starten"),
                          style: ElevatedButton.styleFrom(
                            primary: MyTheme.PRIMARY_BUTTON_BG_COLOR,
                            onPrimary: MyTheme.PRIMARY_BUTTON_TEXT_COLOR,
                            padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppConsentScreen.ROUTE);
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        InkWell(
                          child: Container(
                            child: Text("Mehr erfahren"),
                            padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, MoreInfoScreen.ROUTE);
                          },
                        )
                      ],
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
