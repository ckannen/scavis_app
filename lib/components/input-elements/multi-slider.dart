/* Welcome to the MultiSlider 2.0!

The MultiSlider requires two Arguments:
1. Argument: Here you can choose the Slider-Titel, Min, Max, Divisions und Slider-Startvalue of the masterSlider. You can also choose whether to visually display the masterSlider

Example:
var masterSlider = {
    "showMasterSlider": true
    "masterSliderText": "Dies ist der Master Slider Text",
    "sliderMin": 0.0,
    "sliderMax": 50.0,
    "sliderDivisions": 25,
    "currentMasterSliderValue": 30.0,
  };

2. Argument: Here you can enter the subSliders with their respective Text and startValue (normally 0.0). For each item in the list, a new slider is generated.
 Example:
List subSlider = [
    {
      "sliderText": "Erster Subslider Text",
      "currentSliderValue": 0.0,
    },
    {
      "sliderText": "Zweiter Subslider Text",
      "currentSliderValue": 0.0,
    },
    {
      "sliderText": "Dritter Subslider Text",
      "currentSliderValue": 0.0,
    },
    {
      "sliderText": "Vierter Subslider Text",
      "currentSliderValue": 0.0,
    },
  ]; 
  
  */

import 'package:flutter/material.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';

import 'input-element-template.dart';
import 'slider-tooltip.dart';

class MultiSlider extends InputElementTemplate {
  final Key key;
  final _MultiSliderState state = _MultiSliderState();

  final Map masterSlider;
  final List subSlider;
  final QuestionnaireAnswer answer;

  MultiSlider({this.key, this.masterSlider, this.subSlider, this.answer});

  @override
  _MultiSliderState createState() => state;
}

class _MultiSliderState extends InputElementTemplateState<MultiSlider> {
  @override
  void initState() {
    super.initState();
    this.initAnswerStructure();
  }

  @override
  void initAnswerStructure() {
    if (widget.answer.answerValues == null) {
      List<dynamic> subslider = [];
      for (int i = 0; i < widget.subSlider.length; i++) {
        subslider.add({"value": null as dynamic});
      }
      widget.answer.answerValues = {
        "masterslider": {"value": null as dynamic},
        "subslider": subslider
      };
    }
  }

  void onValueChange({String type, int index, double sliderValue}) {
    if (mounted) {
      setState(() {
        if (type == 'master') {
          widget.answer.answerValues["masterslider"]["value"] = sliderValue;
        } else {
          widget.answer.answerValues["subslider"][index]["value"] = sliderValue;
        }
        //widget.answer.complete = totalSubSliderSum() == widget.masterSlider["sliderMax"];
        widget.answer.complete = true;
      });
    }
  }

  double totalSubSliderSum() {
    double sum = 0;
    for (int i = 0; i < widget.subSlider.length; i++) {
      sum += widget.subSlider[i]["currentSliderValue"];
    }
    return sum;
  }

  //sums all subSliders EXCEPT the one given as an argument.
  //sums ALL subSliders if given null as an argument
  double sumOfAllSubSlidersExcept(currentSubSlider) {
    if (currentSubSlider != null) {
      return ((widget.subSlider.map((m) => m['currentSliderValue']).toList()).reduce((value, element) => value + element)) - currentSubSlider["currentSliderValue"];
    } else {
      return ((widget.subSlider.map((m) => m['currentSliderValue']).toList()).reduce((value, element) => value + element));
    }
  }

// required for subSlider-generation
  dontBeZero(valueToCheck) {
    if (valueToCheck == 0) {
      return 1;
    } else {
      return valueToCheck;
    }
  }

// Used by the subSliders
  dontOverstep(valueToCheck, checkAgainst) {
    if (valueToCheck > checkAgainst) {
      return checkAgainst;
    } else {
      return valueToCheck;
    }
  }

// Used by the masterSlider
  dontUnderstep(valueToCheck, checkAgainst) {
    if (valueToCheck < checkAgainst) {
      return checkAgainst;
    } else {
      return valueToCheck;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Those Texts are for debug only.
      //Text("Value of masterSlider:" + widget.masterSlider["currentMasterSliderValue"].toString()),
      //Text("Sum of all subSliders:" + (sumOfAllSubSlidersExcept(null)).toString()),

      // This builds the masterSlider, if "showMasterSlider = true"
      widget.masterSlider["showMasterSlider"]
          ? Column(
              children: [
                // This builds the Title of the masterSlider
                Text(widget.masterSlider["masterSliderText"]),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: SliderTheme(
                    data: SliderThemeData(
                      showValueIndicator: ShowValueIndicator.never,
                      thumbShape: SliderTooltip(),
                    ),
                    child: Slider(
                      min: widget.masterSlider["sliderMin"],
                      max: widget.masterSlider["sliderMax"],
                      divisions: widget.masterSlider["sliderDivisions"],
                      value: widget.masterSlider["currentMasterSliderValue"],
                      onChanged: (double value) {
                        setState(() {
                          widget.masterSlider["currentMasterSliderValue"] = dontUnderstep(value, sumOfAllSubSlidersExcept(null));
                        });
                        onValueChange(type: "master", index: 0, sliderValue: widget.masterSlider["currentMasterSliderValue"]);
                      },
                      onChangeEnd: (double value) {
                        setState(() {
                          widget.masterSlider["currentMasterSliderValue"] = dontUnderstep(value, sumOfAllSubSlidersExcept(null));
                        });
                        onValueChange(type: "master", index: 0, sliderValue: widget.masterSlider["currentMasterSliderValue"]);
                      },
                    ),
                  ),
                ),
              ],
            )
          : Container(),

      // This builds one subSlider for each item in the subSlider-List.
      Column(
        children: List.generate(widget.subSlider.length, (subSliderIndex) {
          dynamic item = widget.subSlider[subSliderIndex];
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(item["sliderText"]),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 40),
                        child: SliderTheme(
                          data: SliderThemeData(
                            showValueIndicator: ShowValueIndicator.never,
                            thumbShape: SliderTooltip(),
                          ),
                          child: Slider(
                            // Subsliders inherit their layout from the masterSlider
                            min: widget.masterSlider["sliderMin"], max: widget.masterSlider["sliderMax"],
                            divisions: widget.masterSlider["sliderDivisions"],
                            value: item["currentSliderValue"],
                            label: "${(item["currentSliderValue"] as double).round()}%",
                            onChanged: (double value) {
                              setState(() {
                                // This makes sure that any subSlider can't be increased beyond
                                // the value of the masterSlider minus the sum of all other subSliders.
                                item["currentSliderValue"] = dontOverstep(value, (widget.masterSlider["currentMasterSliderValue"] - sumOfAllSubSlidersExcept(item)));
                              });
                              onValueChange(type: "subslider", index: subSliderIndex, sliderValue: item["currentSliderValue"]);
                            },
                            onChangeEnd: (double value) {
                              setState(() {
                                // This makes sure that any subSlider can't be increased beyond
                                // the value of the masterSlider minus the sum of all other subSliders.
                                item["currentSliderValue"] = dontOverstep(value, (widget.masterSlider["currentMasterSliderValue"] - sumOfAllSubSlidersExcept(item)));
                              });
                              onValueChange(type: "subslider", index: subSliderIndex, sliderValue: item["currentSliderValue"]);
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      child: Text("${(item["currentSliderValue"] as double).round()}%"),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
      Text("Total: ${totalSubSliderSum().round()}%")
    ]);
  }
}
