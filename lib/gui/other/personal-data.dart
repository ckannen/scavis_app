import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scavis/theme/my-theme.dart';

class PersonalDataScreen extends StatefulWidget {
  static const String ROUTE = "/personal-data/";

  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  List<dynamic> permissions = [
    {"id": "notifications", "label": "Benachrichtigungen", "allowed": false, "Android": true, "iOS": true},
    {"id": "calls", "label": "Anrufe", "allowed": false, "Android": true, "iOS": true},
    {"id": "sms", "label": "SMS", "allowed": false, "Android": true, "iOS": true},
    {"id": "apps", "label": "Apps", "allowed": false, "Android": true, "iOS": true},
    {"id": "location", "label": "GPS", "allowed": false, "Android": true, "iOS": true},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.BACKGROUND_COLOR,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue.shade100,
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 30,
              ),
              /*
              child: Column(
                children: [
                  Text("Präventionsmodul"),
                  Text("Sie wurden dem Präventionsmodul zugeordnet"),
                  Text("Bitte erlauben Sie Push-Notificaions"),
                  ElevatedButton(onPressed: (){}, child: Text("Benachrichtungen erhalten")),
                  ElevatedButton(onPressed: (){}, child: Text("Fertig")),
                ],
              )
              */
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Interventionsmodul",
                        style: TextStyle(fontSize: 24),
                      )),
                  Text("Sie wurden dem Interventionsmodul zugeordnet"),
                  Text("Das bedeutet, dass Sie an einer 4-wöchigen Trackingphase teilnehmen dürfen."),
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Permissions",
                        style: TextStyle(fontSize: 20),
                      )),
                  Column(
                      children: List.generate(permissions.length, (index) {
                    return Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            permissions[index]["label"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          permissions[index]["allowed"] == false
                              ? Switch(
                                  value: permissions[index]["allowed"],
                                  onChanged: (bool _value) {
                                    setState(() {
                                      permissions[index]["allowed"] = _value;
                                    });
                                  },
                                )
                              : Container(margin: EdgeInsets.only(right: 10), child: Icon(FontAwesomeIcons.check, color: Colors.green)),
                        ],
                      ),
                    );
                  })),
                  Container(margin: EdgeInsets.only(top: 30), alignment: Alignment.centerRight, child: ElevatedButton(onPressed: () {}, child: Text("Fertig"))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
