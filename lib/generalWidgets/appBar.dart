import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class AppBarWidget extends StatelessWidget {
  final Widget title;
  final Widget leadingIcon;
  final Widget actionIcon;
  final Color colorVal;
  double? leadingWidth;

  AppBarWidget(
      {required this.title,
      required this.actionIcon,
      required this.leadingIcon,
      this.leadingWidth,
      required this.colorVal});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title,
        centerTitle: true,
        leadingWidth: leadingWidth,
        leading: leadingIcon,
        elevation: 0,
        backgroundColor: colorVal,
        actions: [actionIcon]);
  }
}
