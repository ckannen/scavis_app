import 'package:flutter/material.dart';
import 'package:scavis/theme/my-theme.dart';

class MyAppBar {
  static Widget createDefaultAppBar() {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        "assets/images/logo.png",
        height: 40,
      ),
      backgroundColor: MyTheme.APP_BAR_BG_COLOR,
    );
  }
}
