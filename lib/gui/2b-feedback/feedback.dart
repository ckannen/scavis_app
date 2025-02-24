import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/gui/2b-feedback/screening/cius-feedback.dart';
import 'package:scavis/gui/2b-feedback/screening/fomo-feedback.dart';
import 'package:scavis/gui/2b-feedback/screening/persoenlichkeit-feedback.dart';
import 'package:scavis/gui/2b-feedback/screening/pss4-feedback.dart';
import 'package:scavis/gui/2b-feedback/screening/sofalizing-feedback.dart';
import 'package:scavis/gui/2b-feedback/screening/swls.dart';
import 'package:scavis/gui/2b-feedback/screening/urbanitaet-feedback.dart';
import 'package:scavis/gui/3-screening/optional-screening.dart';
import 'package:scavis/theme/my-theme.dart';

class FeedbackView extends StatefulWidget {
  final initialTabIndex;

  FeedbackView({this.initialTabIndex=0});

  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  bool dataInitialized = false;
  bool dataMissing = false;
  int tabIndex = 0;
  bool feedbackIntroMessageVisible = false;
  ScrollController _scrollController = ScrollController();

  List<Map> questionnaireResults;

  List<dynamic> feedbackList = [
    {"title": "Lade", "widget": Container(), "locked": false},
  ];

  @override
  void initState() {
    super.initState();

    tabIndex = widget.initialTabIndex;
    
    loadData();

    var appStateManager = AppStateManager();

    // show a welcome message if the user sees the feedback page for the first time
    if (!appStateManager.appState[AppStateNames.FEEDBACK_OPENED]) {
      feedbackIntroMessageVisible = true;
    }
  }

  loadData() async {
    ScavisCouchbase db = ScavisCouchbase();
    dynamic aggregatedResults = await db.loadAggregatedResults();
    if (aggregatedResults == null) aggregatedResults = {};
    dynamic questionnaireResults = await db.loadQuestionnaireResults();

    // load questionnaire states
    dynamic mandatoryScreeningState = await db.loadSurveyState(surveyId: "mandatory-screening");
    if (mandatoryScreeningState["complete"] != true) {
      return;
    }
    dynamic optionalScreeningState = await db.loadSurveyState(surveyId: "optional-screening");

    setState(() {
      dataMissing = false;
      if (mandatoryScreeningState["complete"] == true) {
        if (questionnaireResults["cius"] == null) dataMissing = true;
        if (questionnaireResults["swls"] == null) dataMissing = true;
        if (questionnaireResults["sofalizing"] == null) dataMissing = true;
        if (questionnaireResults["pss4"] == null) dataMissing = true;
      }
      if (optionalScreeningState["complete"] == true) {
        if (questionnaireResults["miniIPIP20"] == null) dataMissing = true;
        if (questionnaireResults["fomo"] == null) dataMissing = true;
      }

      feedbackList = [
        // Mandatory Screening Feedback
        {"title": "Internetnutzung", "widget": IuesFeedback(ownData: questionnaireResults["cius"], comparisonData: aggregatedResults["cius"]), "locked": false}, // CIUS
        {"title": "Lebenszufriedenheit", "widget": SwlsFeedback(ownData: questionnaireResults["swls"], comparisonData: aggregatedResults["swls"]), "locked": false}, // SWLS
        {"title": "Sofalizing", "widget": SofalizingFeedback(ownData: questionnaireResults["sofalizing"], comparisonData: aggregatedResults["sofalizing"]), "locked": false},
        {"title": "Stress", "widget": Pss4Feedback(ownData: questionnaireResults["pss4"], comparisonData: aggregatedResults["pss4"]), "locked": false}, // PSS4
        // Optional Screening Feedback
        {
          "title": "Persönlichkeit",
          "widget": PersoenlichkeitFeedback(ownData: questionnaireResults["miniIPIP20"], comparisonData: aggregatedResults["miniIPIP20"]),
          "locked": !optionalScreeningState["complete"]
        }, // Mini IPIP 20 (optional)
        {
          "title": "Fear of Missing Out",
          "widget": FomoFeedback(ownData: questionnaireResults["fomo"], comparisonData: aggregatedResults["fomo"]),
          "locked": !optionalScreeningState["complete"]
        }, // FoMO (optional)
        /*
        // removed: not shown anymore to participants
        {
          "title": "Urbanität",
          "widget": UrbanitaetFeedback(ownData: questionnaireResults["urbanitaet"], comparisonData: aggregatedResults["urbanitaet"]),
          "locked": !optionalScreeningState["complete"]
        }, // Urbanität (optional)
        */
        /*
        // Tracking Feedback
        // Day 1, Day 22
        {"title": "IUES", "widget": LebenszufriedenheitFeedback(ownData: questionnaireResults["lebenszufriedenheit"], comparisonData: aggregatedResults["lebenszufriedenheit"]), "locked": true},
        // Day 8, Day 15, Day 28
        {"title": "RR und SER", "widget": LebenszufriedenheitFeedback(ownData: questionnaireResults["lebenszufriedenheit"], comparisonData: aggregatedResults["lebenszufriedenheit"]), "locked": true},
        // Day 8, Day 15, Day 22
        {"title": "Fear of Missing Out (täglich)", "widget": LebenszufriedenheitFeedback(ownData: questionnaireResults["lebenszufriedenheit"], comparisonData: aggregatedResults["lebenszufriedenheit"]), "locked": true},
        // Day 8, Day 28
        {"title": "Auswirkungen und DB", "widget": LebenszufriedenheitFeedback(ownData: questionnaireResults["lebenszufriedenheit"], comparisonData: aggregatedResults["lebenszufriedenheit"]), "locked": true},
        // Day 14, Day 28
        {"title": "Mood", "widget": LebenszufriedenheitFeedback(ownData: questionnaireResults["lebenszufriedenheit"], comparisonData: aggregatedResults["lebenszufriedenheit"]), "locked": true},
        // Day 15
        {"title": "Self Efficacy", "widget": LebenszufriedenheitFeedback(ownData: questionnaireResults["lebenszufriedenheit"], comparisonData: aggregatedResults["lebenszufriedenheit"]), "locked": true},
        // Day 15
        {"title": "TKS WLB", "widget": LebenszufriedenheitFeedback(ownData: questionnaireResults["lebenszufriedenheit"], comparisonData: aggregatedResults["lebenszufriedenheit"]), "locked": true},
        // Day 28
        {"title": "ICAT", "widget": LebenszufriedenheitFeedback(ownData: questionnaireResults["lebenszufriedenheit"], comparisonData: aggregatedResults["lebenszufriedenheit"]), "locked": true},
        {"title": "Lebenszufriedenheit (täglich)", "widget": LebenszufriedenheitFeedback(ownData: questionnaireResults["lebenszufriedenheit"], comparisonData: aggregatedResults["lebenszufriedenheit"]), "locked": true},
        */
      ];
      dataInitialized = true;
    });

    if (dataMissing) {
      Timer(Duration(seconds: 5), (){
        loadData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!dataInitialized || dataMissing) {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Lade Daten von Server"),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: MyTheme.BACKGROUND_COLOR,
      drawer: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                    DrawerHeader(
                      child: Text(
                        'Feedbacks',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      decoration: BoxDecoration(
                        color: MyTheme.col2,
                      ),
                    ),
                  ] +
                  List.generate(feedbackList.length, (feedbackIndex) {
                    return ListTile(
                      tileColor: tabIndex == feedbackIndex ? Colors.grey.shade200 : Colors.transparent,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(feedbackList[feedbackIndex]["title"]),
                          feedbackList[feedbackIndex]["locked"] == true ? Icon(Icons.lock_outlined) : Container(),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          tabIndex = feedbackIndex;
                        });
                        Scaffold.of(context).openEndDrawer();
                      },
                    );
                  }),
            ),
          );
        },
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  child: Column(
                    children: [
                      feedbackList[tabIndex]["locked"]
                          ? Container(
                              width: constraints.maxWidth,
                              //margin: EdgeInsets.only(top: 50),
                              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              child: Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Text(
                                        feedbackList[tabIndex]["title"],
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 50),
                                      Text(
                                        "Für dieses Feedback liegen noch keine Daten vor. Beantworten Sie den optionalen Teil des Screenings, um dieses Feedback freizuschalten.",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 50),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: MyTheme.col2,
                                          onPrimary: Colors.white,
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                          ),
                                          child: Text("Zum optionalen Zusatz-Screening"),
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(context, OptionalScreeningSetScreen.ROUTE);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : feedbackList[tabIndex]["widget"],
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: tabIndex == 0
                                  ? null
                                  : () {
                                      setState(() {
                                        tabIndex--;
                                        _scrollController.jumpTo(0);
                                      });
                                    },
                              child: Icon(FontAwesomeIcons.arrowLeft),
                            ),
                            ElevatedButton(
                              onPressed: tabIndex == feedbackList.length - 1
                                  ? null
                                  : () {
                                      setState(() {
                                        tabIndex++;
                                        _scrollController.jumpTo(0);
                                      });
                                    },
                              child: Icon(FontAwesomeIcons.arrowRight),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                    child: Icon(FontAwesomeIcons.bars),
                  ),
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                feedbackIntroMessageVisible
                    ? Container(
                        height: constraints.maxHeight,
                        color: Colors.black.withOpacity(0.7),
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Wrap(
                                children: [
                                  Column(children: [
                                    Text(
                                      "Feedback",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                        "Für den Fall, dass Sie zu den ersten Teilnehmenden der Studie gehören, werden für Ihr Feedback möglicherweise nur unzureichend aussagekräftige Vergleichswerte vorhanden sein. Öffnen Sie in diesem Fall die App einfach in ein paar Tagen erneut. Die Datenbank wird ständig aktualisiert, wodurch zu einem späteren Zeitpunkt Vergleichswerte vorhanden sein werden."),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                        onPressed: () {
                                          var appStateManager = AppStateManager();
                                          appStateManager.appState[AppStateNames.FEEDBACK_OPENED] = true;
                                          appStateManager.storeAppState();

                                          setState(() {
                                            feedbackIntroMessageVisible = false;
                                          });
                                        },
                                        child: Text("OK")),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }
}
