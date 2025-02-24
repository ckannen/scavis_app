import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scavis/theme/my-theme.dart';

class Headline extends StatelessWidget {
  final String text;
  final bool introMode;
  final bool button1;
  final Function onButtonTap;

  Headline(this.text, this.introMode, this.button1, this.onButtonTap);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      child: AnimatedDefaultTextStyle(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(this.text),
            ),
            !this.introMode ? Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                child: Container(height: 40, child: Icon(button1 ? FontAwesomeIcons.caretUp : FontAwesomeIcons.questionCircle, size: 18, color: Colors.grey)),
                onTap: () {
                  if (onButtonTap != null) {
                    onButtonTap();
                  }
                },
              ),
            ): Container(),
          ],
        ),
        style: this.introMode
            ? TextStyle(
                fontSize: 20,
                color: MyTheme.textColor,
                fontWeight: FontWeight.w500,
              )
            : TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
        duration: Duration(milliseconds: 150),
      ),
      alignment: Alignment.center,
      height: 40,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        top: this.introMode ? 40 : 0,
        bottom: this.introMode ? 20 : 0,
      ),
      duration: Duration(milliseconds: 250),
    );
  }
}
