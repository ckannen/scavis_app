import 'package:flutter/material.dart';
import 'package:scavis/theme/my-theme.dart';

class TaskTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String description;
  final double width;
  final Function onTap;

  TaskTile({this.iconData, this.title, this.description, this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        width: width,
        color: Colors.grey.shade300,
        child: Row(
          children: [
            Container(
                width: 100,
                height: 100,
                color: MyTheme.col2,
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 60,
                )),
            Container(
              padding: EdgeInsets.only(left: 7, top: 5, bottom: 5, right: 7),
              width: width - 100,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(title, style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(description),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        if (onTap != null) {
          onTap();
        }
      },
    );
  }
}
