import 'package:flutter/material.dart';
import 'package:scavis/survey/components/action-flow-diagram/template/action-flow-template.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'action-flow/action-flow.dart';

enum ActionFlowChangeType {
  ANSWER_SELECTED,
  END_STATE_REACHED,
}

class ActionFlowDiagram extends StatefulWidget {
  final ActionFlowDiagramState _state = ActionFlowDiagramState();

  final ActionFlowTemplate template;
  final Function(ActionFlowChangeType type, dynamic answers) onChange;

  ActionFlowDiagram({this.template, this.onChange});

  @override
  ActionFlowDiagramState createState() => _state;
}

class ActionFlowDiagramState<T extends ActionFlowDiagram> extends State<T> {
  Timer _timer;
  dynamic flowAnswers = {};

  initTemplate(int tries) async {
    const int MAX_TRIES = 3;

    bool success = await widget.template.init();

    if (success == false && tries < MAX_TRIES) {
      if (_timer != null && _timer.isActive) {
        _timer.cancel();
      }
      _timer = Timer(Duration(seconds: 1), (){
        initTemplate(tries+1);
      });
    } else {
      setState(() {
        widget.template.isInitializing = false;
        widget.template.isInitialized = true;
        if (success) widget.template.isDataAvailable = true;
      });
    }
  }

  @override
  void dispose() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.template.isInitializing && !widget.template.isInitialized) {
      initTemplate(0);
    }

    if (widget.template.isInitializing) {
      return Center(child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 50),
          Text("Lade Daten von Server"),
        ],
      ));
    }

    if (!widget.template.isDataAvailable) {
      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          constraints: BoxConstraints(minHeight: constraints.minHeight),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Es stehen noch keine Daten zur Verfügung, weil diese zur Zeit auf dem Server noch ausgewertet werden.\nBitte aktivieren Sie Ihre Internetverbindung und klicken Sie auf Aktualisieren oder versuchen Sie es in wenigen Minuten erneut."),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      initTemplate(0);
                    },
                    child: Text("Aktualisieren"),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }

    Widget content = Container(child: Text("no current state"));

    FlowState state = widget.template.flow.getCurrentState();
    while (state is FlowDecision) {
      widget.template.flow.currentStateId = (state as FlowDecision).decide();
      state = widget.template.flow.getCurrentState();
    }
    if (state is FlowQuestionState) {
      FlowQuestionState qState = state as FlowQuestionState;
      content = Column(
        children: [
          qState.content is String ? Text(qState.content) : qState.content,
          SizedBox(height: 20),
          qState.chart != null
              ? Column(
                  children: [
                    qState.chart,
                    SizedBox(height: 20),
                  ],
                )
              : Container(),
          Column(
            children: List.generate(qState.answers.length, (answerIndex) {
              FlowAnswer answer = qState.answers[answerIndex];
              if (answer is FlowAnswerText) {
                TextEditingController _controller = TextEditingController(text: flowAnswers["${state.id}-${answer.id}"] ?? "");
                _controller.addListener(() {
                  flowAnswers["${state.id}-${answer.id}"] = _controller.value.text;
                });
                return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 5, bottom: 50),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _controller,
                    ));
              }
              if (answer is FlowAnswerCheckbox) {
                if (flowAnswers["${state.id}-${answer.id}"] == null) {
                  flowAnswers["${state.id}-${answer.id}"] = false;
                }
                return Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Checkbox(
                            onChanged: (value) {
                              setState(() {
                                flowAnswers["${state.id}-${answer.id}"] = value;
                              });
                            },
                            value: flowAnswers["${state.id}-${answer.id}"] ?? false),
                        Expanded(child: Container(margin: EdgeInsets.only(left: 20), child: Text(answer.label)))
                      ],
                    ));
              }
              if (answer is FlowAnswerButton) {
                return Container(
                  width: double.infinity,
                  constraints: BoxConstraints(minHeight: 50),
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: ElevatedButton(
                    child: Container(padding: EdgeInsets.only(top: 20, bottom: 20), child: Text(answer.text)),
                    onPressed: () {
                      flowAnswers["${state.id}-button"] = answer.value;
                      setState(() {
                        widget.template.flow.currentStateId = answer.gotoId;
                      });

                      if (widget.onChange != null) {
                        widget.onChange(ActionFlowChangeType.ANSWER_SELECTED, flowAnswers);
                      }
                    },
                  ),
                );
              }
              return Container();
            }),
          ),
        ],
      );
    }
    if (state is FlowEndState) {
      FlowEndState endState = state;
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          endState.content is String ? Text(endState.content) : endState.content,
          endState.chart != null
              ? Column(
                  children: [
                    endState.chart,
                    SizedBox(height: 20),
                  ],
                )
              : Container(),
          endState.link != null
              ? InkWell(
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        endState.link,
                        style: TextStyle(color: Colors.blue),
                      )),
                  onTap: () async {
                    if (await canLaunch(endState.link)) {
                      launch(endState.link);
                    }
                  },
                )
              : Container(),
        ],
      );
    }

    // when the end state is reached and it should auto close the diagram, call the callback function
    if (state is FlowEndState && state.autoClose) {
      if (widget.onChange != null) {
        widget.onChange(ActionFlowChangeType.END_STATE_REACHED, flowAnswers);
      }
    }

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        constraints: BoxConstraints(minHeight: constraints.minHeight),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  content,
                ],
              ),
              state is FlowEndState
                  ? Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20),
                      height: 50,
                      child: ElevatedButton(
                        child: Text("Schließen"),
                        onPressed: () {
                          if (widget.onChange != null) {
                            widget.onChange(ActionFlowChangeType.END_STATE_REACHED, flowAnswers);
                          }
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }
}
