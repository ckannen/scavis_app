import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/gui/1-login/more-info.dart';
import 'package:scavis/theme/my-theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  static const String ROUTE = "/setup-screen/";

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String participantCode = "";
  @override
  initState() {
    super.initState();
    initDbAndLoadUser();
  }

  // load the user data to show the participant code
  initDbAndLoadUser() async {
    var scavisCouchbase = ScavisCouchbase();
    setState(() {
      participantCode = scavisCouchbase.couchbaseUser.participantCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20, bottom: 20),
              alignment: Alignment.center,
              child: Text("Einstellungen", style: TextStyle(fontSize: 24)),
            ),
          SizedBox(height: 40),
          // participant code
          // TODO only show code for intervention and control group
          Text("Ihr Teilnehmercode", style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text(participantCode, style: TextStyle(fontSize: 20)),
          SizedBox(height: 50),
          // documents
          Text("Dokumente", style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          createLink("Info-Webseite", null, () {
            Navigator.pushNamed(context, MoreInfoScreen.ROUTE);
          }),
          createLink("Datenschutzkonzept", "https://app.scavis.net/files-for-app/SCAVIS-Datenschutzkonzept.pdf", null),
          createLink("Information für Sorgeberechtigte", "https://app.scavis.net/files-for-app/SCAVIS-Erklaerung_Sorgeberechtigte.pdf", null),
          SizedBox(height: 50),
        ],
      ),
      alignment: Alignment.center,
    );
  }

  Widget createLink(String title, String url, Function onTap) {
    return Column(children: [
      InkWell(
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.arrowRight, size: 16, color: MyTheme.TEXT_LINK_COLOR),
              SizedBox(width: 10),
              Text(title, style: TextStyle(fontSize: 16, color: MyTheme.TEXT_LINK_COLOR)),
            ],
          ),
        ),
        onTap: () async {
          if (url != null) {
            if (await canLaunch(url)) {
              launch(url);
            }
          }
          if (onTap != null) {
            onTap();
          }
        },
      ),
    ]);
  }
}
