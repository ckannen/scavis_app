import 'package:scavis/survey/components/template/survey-content-template.dart';

import '../action-flow/action-flow.dart';

class ActionFlowTemplate extends SurveyContentTemplate {
  ActionFlow flow;
  bool isInitializing = false;
  bool isInitialized = false;
  bool isDataAvailable = false;

  Future<bool> init() async {
    isInitializing = true;
    return true;
  }
}
