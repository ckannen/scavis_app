import 'package:flutter/material.dart';

abstract class InputElementTemplate extends StatefulWidget {
  final InputElementTemplateState state = null;
}

abstract class InputElementTemplateState<T extends InputElementTemplate> extends State<T> {
  
  // when the answerValues are not set yet, create an object with default values inside
  // the answerValues contain the actual answer adopted for the current input element
  // this is different from input element to input element, because each input element has it special result type and information to store
  void initAnswerStructure();
}
