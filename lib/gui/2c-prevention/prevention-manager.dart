import 'package:scavis/app-state/app-state.dart';

class PreventionManager {
  // get the current week for the prevention module
  static Future<int> getCurrentWeek() async {
    var appStateManager = AppStateManager();

    await appStateManager.loadParticipantSchedule();
    if (appStateManager.participantSchedule != null && appStateManager.participantSchedule["preventionStartDt"] != null) {
      DateTime startDt = DateTime.parse(appStateManager.participantSchedule["preventionStartDt"]);
      DateTime nowDt = DateTime.now();
      Duration diff = nowDt.difference(startDt);

      // if the prevention has not started yet, return null
      if (nowDt.compareTo(startDt) < 0) {
        return null;
      }

      // calculate the current week for the prevention
      int currentWeek = (diff.inSeconds / 86400 / 7).ceil();
      return currentWeek;
    } else {
      return null;
    }
  }
}
