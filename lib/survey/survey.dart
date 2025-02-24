import 'package:couchbase_lite/couchbase_lite.dart';
import 'package:flutter/material.dart';
import 'package:scavis/components/app-bar/my-app-bar.dart';
import 'package:scavis/survey/components/action-flow-diagram/action-flow-diagram.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'components/questionnaire/questionnaire.dart';
import 'components/questionnaire/template/questionnaire-template.dart';
import 'components/questionnaire/types/questionnaire-answer-state.dart';
import 'components/questionnaire/types/questionnaire-answer.dart';
import 'components/template/survey-content-template.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/gui/2-main-menu/main-menu.dart';
import 'package:scavis/theme/my-theme.dart';
import 'components/progress-bar/progress-bar.dart';

enum ModalType {
  WELCOME,
  CONITNUE,
  FINISH,
}

class SurveyScreen extends StatefulWidget {
  static const String ROUTE = '/questionnaires-set/';

  SurveyScreen();

  @override
  SurveyScreenState createState() => SurveyScreenState<SurveyScreen>();
}

class SurveyScreenState<T extends SurveyScreen> extends State<T> {
  String surveyId = "";

  // list of all questionnaires in this survey
  List<SurveyContentTemplate> questionnaires = [];

  bool questionnairesInitialized = false;

  int day;

  // current questionnaire and current question in this questionnaire
  Key contentKey = UniqueKey();
  int pageIndex = 0;
  int itemIndex = 0;
  bool showIntro = true;

  // number of all survey items in all questionnaires andf action flow diagrams in this set
  int totalItemCount = 0;

  // modal
  bool modalVisible = true;
  ModalType modalType = ModalType.WELCOME;

  // show an error message for the current question
  bool showErrorMessage = false;

  // scroll controller for the questionnaire content
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  initQuestionnaires() async {
    await loadQuestionnaires();
    await restore();
  }

  // load all questionnaires for this questionnaire set
  loadQuestionnaires() async {
    // count questions in all questionnaires
    // and add 1 for each action flow diagram, since the number of consecutive items cannot be count for those diagrams
    int totalItemCount = 0;
    this.questionnaires.forEach((questionnaire) {
      if (questionnaire is QuestionnaireTemplate) totalItemCount += questionnaire.totalQuestionCount;
      if (questionnaire is ActionFlowDiagram) totalItemCount += 1;
    });

    // save variables
    setState(() {
      this.questionnaires = questionnaires;
      this.totalItemCount = totalItemCount;
    });
  }

  restore() async {
    await restoreSurveyState();
    if (pageIndex == null || itemIndex == null) {
      return;
    }
    await restoreSurveyAnswers();

    // if the user has filled out any data before, go to the next unanswered question
    // and show the continue modal instead of the welcome modal before
    if (pageIndex != 0 || itemIndex != 0) {
      // display the modal
      setState(() {
        modalType = ModalType.CONITNUE;
      });
      // if the current page is a questionnaire, go to the next question, since the current one has already been answered
      if (this.questionnaires[this.pageIndex] is QuestionnaireTemplate) {
        gotoNextQuestion(save: false);
      }
      // if the current page is a action flow diagram, do nothing and the actiob flow diagram starts from the beginning
      if (this.questionnaires[this.pageIndex] is ActionFlowTemplate) {
        // do nothing
      }
    }
  }

  // restore state for this questionnaire set
  // this state contains information about the last answered question index and the quetionnaire index for this question
  // and also whether this questionnaire is completed
  restoreSurveyState() async {
    ScavisCouchbase db = ScavisCouchbase();
    dynamic state = await db.loadSurveyState(surveyId: surveyId);
    setState(() {
      pageIndex = state["pageIndex"];
      itemIndex = state["itemIndex"];
    });
  }

  // restore all answers that were already stored for questions in this questionnaire set
  restoreSurveyAnswers() async {
    ScavisCouchbase db = ScavisCouchbase();
    List<Fragment> answers = await db.loadAllQuestionnaireAnswersForSurvey(surveyId: surveyId);
    answers.forEach((Fragment fragment) {
      dynamic data = fragment.getMap()["data"];
      int _pageIndex = data["pageIndex"];
      int _itemIndex = data["itemIndex"];
      dynamic answer = data["answer"];

      QuestionnaireTemplate questionnaire = this.questionnaires[_pageIndex];
      questionnaire.answers[_itemIndex] = QuestionnaireAnswer.fromJson(answer);
    });
  }

  // get the item position
  int calcCurrentItemPosition() {
    int count = 0;
    for (int i = 0; i < pageIndex; i++) {
      if (questionnaires[i] is QuestionnaireTemplate) {
        QuestionnaireTemplate questionnaire = this.questionnaires[i];
        count += questionnaire.answers.length;
      }
      if (questionnaires[i] is ActionFlowDiagram) {
        count += 1;
      }
    }
    count += itemIndex;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    if (!questionnairesInitialized) {
      initQuestionnaires();
      questionnairesInitialized = true;
    }

    MediaQueryData mqd = MediaQuery.of(context);

    AppBar appBar = MyAppBar.createDefaultAppBar();

    return Stack(
      children: [
        Scaffold(
          appBar: appBar,
          backgroundColor: Colors.white,
          body: this.questionnaires.length == 0
              ? Container()
              : SafeArea(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      double progressBarHeight = 40;
                      double contentHeight = constraints.maxHeight - progressBarHeight;

                      if (pageIndex == null || itemIndex == null) {
                        return Center(child: Column(
                          children: [
                            Text("Diesen Fragebogen haben Sie bereits ausgefüllt"),
                            SizedBox(height: 20),
                            ElevatedButton(onPressed: (){
                              Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE);
                            }, child: Text("Zurück")),
                          ],
                        ));
                      }

                      Widget content = Container();
                      if (this.questionnaires[this.pageIndex] is ActionFlowTemplate) {
                        ActionFlowTemplate template = this.questionnaires[this.pageIndex];
                        content = Container(
                          constraints: BoxConstraints(minHeight: contentHeight),
                          padding: EdgeInsets.all(20),
                          child: ActionFlowDiagram(template: template, onChange: onActionFlowDiagramChanged),
                        );
                      }
                      if (this.questionnaires[this.pageIndex] is QuestionnaireTemplate) {
                        QuestionnaireTemplate questionnaire = this.questionnaires[this.pageIndex];
                        content = Questionnaire(
                          key: contentKey,
                          introduction: questionnaire.introduction,
                          bigIntroduction: showIntro,
                          headline: "Fragenset ${this.pageIndex + 1}",
                          bigHeadline: showIntro,
                          currentItemIndex: itemIndex,
                          children: showIntro ? [] : questionnaire.createItemsForIndex(itemIndex),
                          hasErrors: showErrorMessage,
                          button: showIntro ? QuestionnaireButton.START : QuestionnaireButton.NEXT,
                          onNext: onQuestionnaireNextButtonPressed,
                        );
                      }

                      return Column(
                        children: [
                          SurveyProgressBar(
                              width: mqd.size.width,
                              height: progressBarHeight,
                              finished: calcCurrentItemPosition(),
                              total: totalItemCount,
                              hideQuestionCount: this.questionnaires[this.pageIndex] is ActionFlowTemplate),
                          Container(
                            height: contentHeight,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              child: content,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ),
        modalVisible ? createModal() : Container(),
      ],
    );
  }

  // ####################################################################################################
  // Save questionnaire answers
  // ####################################################################################################
  onQuestionnaireNextButtonPressed() {
    // at the beginning of each questionnaire is an intro text
    // hide this intro text on the first click on the next button
    // and afterwards the first question gets visible
    if (showIntro) {
      setState(() {
        showIntro = false;
      });
      return;
    }

    // evaluate the answer and find out if it is complete
    QuestionnaireTemplate questionnaire = this.questionnaires[this.pageIndex];
    QuestionnaireAnswerState answerState = questionnaire.evaluateAnswer(itemIndex);
    if (answerState.type == QuestionnaireAnswerStateType.ANSWER_COMPLETE || answerState.type == QuestionnaireAnswerStateType.QUESTIONNAIRE_FINISHED) {
      setState(() {
        showErrorMessage = false;
      });
      gotoNextQuestion();
    } else {
      setState(() {
        showErrorMessage = true;
      });
    }
  }

  saveQuestionnaireAnswerInDb() async {
    ScavisCouchbase db = ScavisCouchbase();

    QuestionnaireTemplate questionnaire = this.questionnaires[this.pageIndex];

    db.storeQuestionnaireAnswer(surveyId: surveyId, day: day, pageIndex: pageIndex, itemIndex: itemIndex, answer: questionnaire.answers[itemIndex].toJson());

    String questionnaireId = questionnaire.id;
    db.storeQuestionnaireState(
      surveyId: surveyId,
      day: day,
      questionnaireId: questionnaireId,
      itemIndex: itemIndex,
      complete: itemIndex == questionnaire.totalQuestionCount - 1,
    );
    db.storeSurveyState(
      surveyId: surveyId,
      day: day,
      pageIndex: pageIndex,
      itemIndex: itemIndex,
      complete: false,
    );
  }

  // ####################################################################################################
  // Save action flow diagram answers
  // ####################################################################################################
  onActionFlowDiagramChanged(ActionFlowChangeType type, dynamic answers) {
    if (type == ActionFlowChangeType.ANSWER_SELECTED) {
      // ignore, since the answers are only stored after the diagram is completed
    }
    if (type == ActionFlowChangeType.END_STATE_REACHED) {
      saveActionFlowDiagramAnswersInDb(answers);
      gotoNextSurveyPage();
    }
  }

  saveActionFlowDiagramAnswersInDb(dynamic answers) async {
    ScavisCouchbase db = ScavisCouchbase();

    ActionFlowTemplate actionFlowDiagram = this.questionnaires[this.pageIndex];

    db.storeActionFlowAnswers(surveyId: surveyId, day: day, pageIndex: pageIndex, answers: answers);

    String questionnaireId = actionFlowDiagram.id;
    db.storeQuestionnaireState(surveyId: surveyId, day: day, questionnaireId: questionnaireId, itemIndex: itemIndex, complete: true);
    db.storeSurveyState(
      surveyId: surveyId,
      day: day,
      pageIndex: pageIndex,
      itemIndex: itemIndex,
      complete: false,
    );
  }

  // ####################################################################################################
  // Navigation
  // ####################################################################################################
  // go to next survey page (e.g. next questionnaire or next action flow chartc)
  gotoNextSurveyPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageIndex < questionnaires.length - 1) {
        setState(() {
          pageIndex++;
          itemIndex = 0;
          // show the introduction only if it is available
          if (this.questionnaires[this.pageIndex] is QuestionnaireTemplate) {
            if ((this.questionnaires[this.pageIndex] as QuestionnaireTemplate).introduction != "") {
              showIntro = true;
            }
          } else {
            showIntro = true;
          }
          contentKey = UniqueKey();
          _scrollController.jumpTo(0);
        });
        this.onNextPage(pageIndex);
      } else {
        finishSurvey();
      }
    });
  }

  // go to next question in questionnaire
  gotoNextQuestion({bool save = true}) async {
    if (save) {
      await saveQuestionnaireAnswerInDb();
    }

    QuestionnaireTemplate questionnaire = this.questionnaires[this.pageIndex];
    if (itemIndex < questionnaire.totalQuestionCount - 1) {
      // go to the next question
      setState(() {
        itemIndex++;
        showIntro = false;
        _scrollController.jumpTo(0);
        this.onNextItem(pageIndex, itemIndex);
      });
      // if the next question should be skipped, go to the next
      if (questionnaire.skipItem(questionnaire.answers, itemIndex)) {
        gotoNextQuestion();
      }
    } else {
      // go to the next questionnaire
      gotoNextSurveyPage();
    }
  }

  // finish the survey
  // the survey state database entry will be changed, so that the survey is marked as finished
  finishSurvey() async {
    setState(() {
      showIntro = true;
      pageIndex = 0;
      itemIndex = 0;
      contentKey = UniqueKey();
      modalVisible = true;
      modalType = ModalType.FINISH;
    });

    ScavisCouchbase db = ScavisCouchbase();
    db.storeSurveyState(
      surveyId: surveyId,
      day: day,
      pageIndex: null,
      itemIndex: null,
      complete: true,
    );
  }

  // KEEP THIS FUNCTION EVEN IF IT HAS NO BODY HERE; IT MAY BE USED AS CALLBACK FROM CHILD ELEMENTS
  // called when the next questionnaire is started
  // this can be used as a callback by classes that extends the SurveyPage class
  // and maybe skip a questionnaire
  onNextPage(int pageIndex) async {}

  // KEEP THIS FUNCTION EVEN IF IT HAS NO BODY HERE; IT MAY BE USED AS CALLBACK FROM CHILD ELEMENTS
  // called when the next question is started
  // this can be used as a callback by classes that extends the SurveyPage class
  // and maybe skip a question
  onNextItem(int pageIndex, int itemIndex) async {}

  // ####################################################################################################
  // MODALS
  // ####################################################################################################
  // create a modal
  createModal() {
    List<Widget> children = createModalContent(modalType);
    return Material(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Column(children: children),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // create the content for a modal
  //   1) for the survey start
  //   2) for when the survey was interrupted and then is continued
  //   3) for the end of the survey
  createModalContent(ModalType type) {
    List<Widget> children = [];

    // Start screening
    if (type == ModalType.WELCOME) {
      children.add(Text(
        "Herzlich Willkommen zum smart@net-Screening!",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Das Screening besteht aus einer Reihe von Fragebögen mit insgesamt 117 Fragen.\n" +
            "Das Ausfüllen des gesamten Screening dauert im Schnitt 10 Minuten.\n" +
            "Bitte arbeiten Sie konzentriert und füllen Sie möglichst alle Fragen in einem Durchgang aus.\n" +
            "\n" +
            "Nach dem Screening werden Sie in eine von drei Gruppen eingeteilt und nehmen dann entweder an unserem Präventionspropgramm teil " +
            "oder werden der Trackinggruppe zugeorndet und lernen mehr über Ihr Smartphonenutzungsverhalten.\n" +
            "\n" +
            "Damit Sie möglichst bald mit Ihrem persönlichen Programm starten können, füllen Sie bitte das Screening bis zum 27.02.2021 aus.",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(ElevatedButton(
        child: Text("Jetzt starten", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          primary: MyTheme.col2,
          onPrimary: MyTheme.col2Text,
        ),
        onPressed: () {
          setState(() {
            modalVisible = false;
          });
        },
      ));
    }

    // Continue screening
    if (type == ModalType.CONITNUE) {
      children.add(Text(
        "Screening fortsetzen",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Sie haben das Screening unterbrochen. Klicken Sie auf 'Weitermachen', um es fortzusetzen.",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(ElevatedButton(
        child: Text("Weitermachen", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          primary: MyTheme.col2,
          onPrimary: MyTheme.col2Text,
        ),
        onPressed: () {
          setState(() {
            modalVisible = false;
          });
        },
      ));
    }

    // finished
    if (type == ModalType.FINISH) {
      children.add(Text(
        "Super!",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 24),
        textAlign: TextAlign.center,
      ));
      children.add(Container(height: 20));
      children.add(Text(
        "Sie haben auch den optionalen Teil des Screening vollständig ausgefüllt.\n" + "Nun können Sie zum Feedback gehen und Ihre persönliche Auswertung ansehen.\n",
        style: TextStyle(color: MyTheme.TEXT_COLOR, fontSize: 16),
        textAlign: TextAlign.left,
      ));
      children.add(Container(height: 20));
      children.add(ElevatedButton(
        child: Text("Zum Feedback", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          primary: MyTheme.col2,
          onPrimary: MyTheme.col2Text,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, MainMenuScreen.ROUTE, arguments: {"tab": "feedback"});
        },
      ));
    }

    return children;
  }
}