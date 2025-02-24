import 'package:flutter/material.dart';

class TaskEntry extends StatelessWidget {
  final String title;
  final String description;

  TaskEntry({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(230, 230, 230, 1),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1), borderRadius: BorderRadius.circular(35)),
            child: Icon(Icons.question_answer),
            alignment: Alignment.center,
          ),
          Container(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(height: 5),
                Text(this.description),
              ],
            ),
            padding: EdgeInsets.all(10),
          )
        ],
      ),
    );
  }
}
