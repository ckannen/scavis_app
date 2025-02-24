import 'package:flutter/material.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/gui/1-login/init-study.dart';
import 'package:scavis/theme/my-theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConsentScreen extends StatefulWidget {
  static const String ROUTE = "/app-consent/";
  @override
  _AppConsentScreenState createState() => _AppConsentScreenState();
}

class _AppConsentScreenState extends State<AppConsentScreen> {
  int currentInfoboxStep = 0;
  bool networkWarningVisible = false;

  List<List<dynamic>> infoboxTexts = [
    [
      "Willkommen in der smart@net-App zur Förderung gesunder und verantwortungsvoller Internetnutzung. Die smart@net-App wurde entwickelt im Rahmen der SCAVIS-Studie (Stepped Care Ansatz zur Versorgung Internetbezogener Störungen), die durchgeführt wird von der Universität zu Lübeck in Kooperation mit der Universität Ulm, dem Media Protect e.V., der Universität Mainz, der Freien Universität Berlin und der CONVEMA Versorgungsmanagement GmbH. Die Studie wird gefördert durch den Innovationsfonds.",
    ],
    [
      "Im Rahmen der Studie interessieren wir uns für Ihre Internetnutzung und Ihre Einstellung zu Gesundheitsthemen. Sie können an der Befragung nur teilnehmen, wenn Sie zwischen 16 und 67 Jahren (offizielles Renteneintrittsalter) alt sind. Im Anschluss an die Befragung erhalten Sie eine individuelle Rückmeldung („Feedback“) über Ihre Internetnutzung.",
    ],
    [
      "Alle Befragten bekommen die Möglichkeit, an einer Verlosung von 20 Gutscheinen in Höhe von 100,- € und 40 Gutscheinen in Höhe von 50,- € teilzunehmen. Einige Teilnehmende werden zudem im Anschluss eingeladen, an einer weiterführenden Studie teilzunehmen.",
    ],
    [
      "Ihre Angaben werden nicht an Dritte weitergeleitet, auch nicht an Arbeitgeber oder Krankenkassen. Die wissenschaftliche Auswertung der Daten erfolgt anonym und alle Studienmitarbeiter*innen unterliegen der Schweigepflicht. Weitere Informationen zum Datenschutz finden Sie hier:",
      Uri.parse("https://app.scavis.net/files-for-app/SCAVIS-Datenschutzkonzept.pdf"),
    ],
    [
      "Wenn Sie noch nicht volljährig sind, weisen wir Sie darauf hin, dass Sie verpflichtet sind, Ihre Eltern / Sorgeberechtigten über die Studienteilnahme zu informieren. Hierfür können Sie folgenden Link an Ihre Eltern / Sorgeberechtigten weiterleiten: ",
      Uri.parse("https://app.scavis.net/files-for-app/SCAVIS-Erklaerung_Sorgeberechtigte.pdf"),
      "Die Informationen für Eltern / Sorgeberechtigte finden Sie auch in den App-Einstellungen.",
    ],
  ];

  createConsentDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Teilnahme"),
            content: Text("Hiermit bestätige ich, dass ich die Information gelesen habe und damit einverstanden bin."),
            backgroundColor: MyTheme.BACKGROUND_COLOR,
            actions: [
              MaterialButton(
                  child: Text("Ja"),
                  onPressed: () async {
                    // storing the variable appStateManager.appState[AppStateNames.APP_CONSENT_GIVEN] = true;
                    // could happen here, but since the participant id is not known at this point,
                    // the flag is stored on the init study screen, after the participant information were created and loaded form the server
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, InitStudyScreen.ROUTE);
                  }),
              MaterialButton(
                  child: Text("Nein"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);

    List<Step> infoboxSteps = [];
    for (int i = 0; i < infoboxTexts.length; i++) {
      infoboxSteps.add(Step(
        title: Container(),
        isActive: currentInfoboxStep == i,
        content: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              children: List.generate(infoboxTexts[i].length, (index) {
                dynamic item = infoboxTexts[i][index];
                if (item is String) {
                  return Text(item);
                }
                if (item is Uri) {
                  return InkWell(
                    child: Container(margin: EdgeInsets.only(top: 10, bottom: 10), alignment: Alignment.centerLeft, child: Text(item.toString(), style: TextStyle(color: MyTheme.TEXT_LINK_COLOR),)),
                    onTap: () async {
                      if (await canLaunch(item.toString())) {
                        launch(item.toString());
                      }
                    },
                  );
                }
              }),
            )),
      ));
    }

    return Scaffold(
      appBar: MyAppBar.createDefaultAppBar(),
      backgroundColor: MyTheme.BACKGROUND_COLOR,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double dividerHeight = 10;
            bool imgVisible = false;
            double imgHeight = 0;
            double block1Height = 100;

            if (constraints.maxHeight > MyTheme.MAX_HEIGHT_SM) {
              block1Height = 100;
              imgVisible = true;
              imgHeight = 30;
            }
            if (constraints.maxHeight > MyTheme.MAX_HEIGHT_MD) {
              block1Height = 120;
              imgVisible = true;
              imgHeight = 40;
            }
            if (constraints.maxHeight > MyTheme.MAX_HEIGHT_LG) {
              block1Height = 200;
              imgVisible = true;
              imgHeight = 100;
            }
            if (constraints.maxHeight > MyTheme.MAX_HEIGHT_XL) {
              block1Height = 300;
              imgVisible = true;
              imgHeight = 150;
            }

            double block2Height = constraints.maxHeight - block1Height - dividerHeight;

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: block1Height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imgVisible
                          ? Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Image.asset(
                                "assets/images/screening-welcome.png",
                                height: imgHeight,
                              ),
                            )
                          : Container(),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Column(
                          children: [
                            Text(
                              "Willkommen in der smart@net-App",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "powered by SCAVIS",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: double.infinity, height: dividerHeight, color: MyTheme.col2),
                Container(
                  width: double.infinity,
                  height: block2Height,
                  child: Column(
                    children: [
                      Expanded(
                        child: Theme(
                          data: ThemeData(primaryColor: MyTheme.col2),
                          child: Stepper(
                            steps: infoboxSteps,
                            type: StepperType.horizontal,
                            onStepContinue: () {
                              if (currentInfoboxStep < infoboxSteps.length - 1) {
                                setState(() {
                                  currentInfoboxStep++;
                                });
                              } else {
                                createConsentDialog();
                              }
                            },
                            onStepTapped: (int stepIndex) {
                              setState(() {
                                currentInfoboxStep = stepIndex;
                              });
                            },
                            controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                              return Container();
                            },
                            currentStep: currentInfoboxStep,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 20, bottom: 10),
                        child: ElevatedButton(
                          child: Text(currentInfoboxStep < infoboxSteps.length - 1 ? "Weiter" : "Loslegen"),
                          style: ElevatedButton.styleFrom(
                            primary: MyTheme.col2,
                            onPrimary: MyTheme.col2Text,
                            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                          ),
                          onPressed: () {
                            if (currentInfoboxStep < infoboxSteps.length - 1) {
                              setState(() {
                                currentInfoboxStep++;
                              });
                            } else {
                              createConsentDialog();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                /*
            
            */
              ],
            );
          },
        ),
      ),
    );
  }
}