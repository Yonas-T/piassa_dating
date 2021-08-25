import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/screens/settingsScreen/settingsScreen.dart';

class TopBarWidget extends StatelessWidget {
  final String titleBar;
  TopBarWidget({required this.titleBar});

  @override
  Widget build(BuildContext context) {
    var restHeight = 120;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      height: restHeight / 2,
      color: Color(kDarkGrey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SettingsScreen();
              }));
            },
            child: CircleAvatar(
              backgroundColor: Color(kWhite),
              radius: 20,
              child: Icon(
                FontAwesomeIcons.slidersH,
                color: Color(kDarkGrey),
              ),
            ),
          ),
          Text(
            titleBar,
            style: TextStyle(fontSize: kTitleFont, color: Color(kWhite)),
          ),
          CircleAvatar(
            backgroundColor: Color(kWhite),
            radius: 20,
            child: Icon(
              FontAwesomeIcons.bell,
              color: Color(kDarkGrey),
            ),
          ),
        ],
      ),
    );
  }
}
