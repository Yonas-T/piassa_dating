import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final Widget leadingIcon;
  final Widget actionIcon;
  final Color colorVal;

  AppBarWidget(
      {required this.title,
      required this.actionIcon,
      required this.leadingIcon, required this.colorVal});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title,
            style: TextStyle(fontSize: kNormalFont, color: Color(kDarkGrey))),
        centerTitle: true,
        leading: leadingIcon,
        elevation: 0,
        backgroundColor: colorVal,
        actions: [actionIcon]);
  }
}
