import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scavis/app-state/app-state.dart';
import 'package:scavis/database/scavis-couchbase.dart';
import 'package:scavis/gui/2c-prevention/prevention.dart';
import 'package:scavis/gui/3-screening/control-group-screening.dart';
import 'package:scavis/gui/3-screening/daily-screening.dart';
import 'package:scavis/gui/4-group-assigning/prevention-group.dart';
import 'package:scavis/gui/4-group-assigning/participant-information.dart';
import 'task-tile.dart';

class TaskList {
  static Future<List<Widget>> getTaskList(BuildContext context, double tileWidth) async {
    var appStateManager = AppStateManager();

    await appStateManager.loadParticipantSchedule();
    if (appStateManager.participantSchedule == null) {
      return Future.value(null);
    }

    bool raffleVisible = false;
    bool participantInformationVisible = false;
    bool contactDataFormVisible = false;
    bool groupAssignedVisible = false;
    bool trackingPermissionsTileVisible = true;

    // raffle task
    //   visible for
    //     1) group=prevention & raffle=no
    //     2) group=intervention & study_part_2_consent=no & raffle=no
    //     3) group=control & study_part_2_consent=no & raffle=no
    raffleVisible = (appStateManager.participantSchedule["group"] == AssignedGroupValues.PREVENTION && appStateManager.appState[AppStateNames.RAFFLE_EMAIL_ENTERED] == false) ||
        (appStateManager.participantSchedule["group"] == AssignedGroupValues.INTERVENTION && appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] == StateValues.NO) ||
        (appStateManager.participantSchedule["group"] == AssignedGroupValues.CONTROL && appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] == StateValues.NO);

    // participant information
    //   visible for
    //     1) group=intervention & study_part_2_consent=pending
    //     2) group=control & study_part_2_consent=pending
    participantInformationVisible =
        (appStateManager.participantSchedule["group"] == AssignedGroupValues.INTERVENTION && appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] == StateValues.PENDING) ||
            (appStateManager.participantSchedule["group"] == AssignedGroupValues.CONTROL && appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] == StateValues.PENDING);

    // contact data form
    //   visible for
    //     1) group=intervention & study_part_2_consent=yes && contact_data=false
    //     2) group=control & study_part_2_consent=yes && contact_data=false
    contactDataFormVisible = (appStateManager.participantSchedule["group"] == AssignedGroupValues.INTERVENTION &&
            appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] == StateValues.YES &&
            appStateManager.appState[AppStateNames.CONTACT_DATA_ENTERED] == false) ||
        (appStateManager.participantSchedule["group"] == AssignedGroupValues.CONTROL &&
            appStateManager.appState[AppStateNames.STUDY_PART_2_CONSENT] == StateValues.YES &&
            appStateManager.appState[AppStateNames.CONTACT_DATA_ENTERED] == false);

    // group assigned screen
    //   visible for
    //     1) group=intervention & contact_data=true && studyPart2Initialized=false
    //     2) group=control & contact_data=true && studyPart2Initialized=false
    groupAssignedVisible = (appStateManager.participantSchedule["group"] == AssignedGroupValues.INTERVENTION &&
            appStateManager.appState[AppStateNames.STUDY_PART_2_START_DATETIME] == true &&
            appStateManager.appState[AppStateNames.CONTACT_DATA_ENTERED] == "") ||
        (appStateManager.participantSchedule["group"] == AssignedGroupValues.CONTROL &&
            appStateManager.appState[AppStateNames.STUDY_PART_2_START_DATETIME] == true &&
            appStateManager.appState[AppStateNames.CONTACT_DATA_ENTERED] == "");

    List<Widget> taskList = [];

    // raffle
    if (raffleVisible) {
      taskList.add(TaskTile(
        iconData: FontAwesomeIcons.mailBulk,
        title: "Verlosung",
        description: "Tragen Sie Ihre E-Mail-Adresse ein, wenn Sie an der Verlosung der Amazon-Gutscheine teilnehmen möchten.",
        width: tileWidth,
        onTap: () {
          Navigator.pushReplacementNamed(context, AssignToPreventionGroupScreen.ROUTE);
        },
      ));
    }
    // participant information
    if (participantInformationVisible) {
      taskList.add(TaskTile(
        iconData: FontAwesomeIcons.fileSignature,
        title: "Probandeninformation",
        description: "Bitte bestätigen Sie Ihr Einverständnis mit der Proband*inneninformation, um an der weiteren Studie teilzunehmen.",
        width: tileWidth,
        onTap: () {
          Navigator.pushReplacementNamed(context, ParticipantInformationScreen.ROUTE);
        },
      ));
    }

    // contact data form
    if (contactDataFormVisible) {
      taskList.add(TaskTile(
        iconData: FontAwesomeIcons.addressBook,
        title: "Kontaktdaten",
        description: "Bitte tragen Sie einige Daten ein, um mit der Studie zu starten.",
        width: tileWidth,
        onTap: () {
          Navigator.pushReplacementNamed(context, ParticipantInformationScreen.ROUTE);
        },
      ));
    }

    // contact data form
    if (groupAssignedVisible) {
      taskList.add(TaskTile(
        iconData: FontAwesomeIcons.users,
        title: "Gruppenzuordnung",
        description: "Sie wurden einer Gruppe zugeordnet.",
        width: tileWidth,
        onTap: () {
          Navigator.pushReplacementNamed(context, ParticipantInformationScreen.ROUTE);
        },
      ));
    }

    ScavisCouchbase database = ScavisCouchbase();
    dynamic questionnaireResults = await database.loadQuestionnaireResults();

    DateTime nowDt = DateTime.now();

    if (appStateManager.participantSchedule["studyPart2StartDt"] != null) {
      DateTime startDt = DateTime.parse(appStateManager.participantSchedule["studyPart2StartDt"]);

      if (startDt != null) {
        if (appStateManager.participantSchedule["group"] == AssignedGroupValues.INTERVENTION) {
          for (int day = 1; day <= 28; day++) {
            DateTime dt = startDt.add(Duration(days: day - 1));
            if (dt.compareTo(nowDt) <= 0) {
              // check the survey state, if it was already filled out, do not show the link anymore
              dynamic surveyState = await database.loadSurveyState(surveyId: "daily-screening-$day");
              if (surveyState["complete"] == false) {
                // add survey to list
                taskList.add(TaskTile(
                  iconData: FontAwesomeIcons.fileAlt,
                  title: "Täglicher Fragebogen ($day)",
                  description: "Hier finden Sie Ihren täglichen Fragebogen.",
                  width: tileWidth,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, DailyScreening.ROUTE, arguments: {"day": day});
                  },
                ));
              }
            }
          }
        }

        if (appStateManager.participantSchedule["group"] == AssignedGroupValues.CONTROL) {
          DateTime dt = startDt;
          if (dt.compareTo(nowDt) <= 0 || true) {
            // check the survey state, if it was already filled out, do not show the link anymore
            dynamic surveyState = await database.loadSurveyState(surveyId: "control-group-screening");
            if (surveyState["complete"] == false) {
              // add survey to list
              taskList.add(TaskTile(
                iconData: FontAwesomeIcons.fileAlt,
                title: "Fragebogen",
                description: "Hier finden Sie Ihren Fragebogen.",
                width: tileWidth,
                onTap: () {
                  Navigator.pushReplacementNamed(context, ControlGroupScreeningSetScreen.ROUTE);
                },
              ));
            }
          }
        }
      }
    }
    
    return Future.value(taskList);
  }
}