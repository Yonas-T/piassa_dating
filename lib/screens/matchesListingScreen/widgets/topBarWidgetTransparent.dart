import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';

class TopBarWidgetTransparent extends StatelessWidget {
  
  final String titleBar;
  TopBarWidgetTransparent({required this.titleBar});

  @override
  Widget build(BuildContext context) {
    var restHeight = 160;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 4),
      height: restHeight / 2,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Icon(
              FontAwesomeIcons.slidersH,
              color: Color(kWhite),
            ),
          ),
          Text(
            titleBar,
            style: TextStyle(fontSize: kTitleFont, color: Color(kWhite)),
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Icon(
              FontAwesomeIcons.bell,
              color: Color(kWhite),
            ),
          ),
        ],
      ),
    );
  }
}
