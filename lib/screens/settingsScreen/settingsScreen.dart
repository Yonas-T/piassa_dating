import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/screens/matchesListingScreen/widgets/topBarWidget.dart';
import 'package:piassa_application/screens/settingsScreen/widgets/settingTileWidget.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(kDarkGrey),
        child: Column(
          children: [
            Container(
                height: 120,
                child: TopBarWidget(
                  titleBar: '',
                )),
            Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height - 120,
              decoration: BoxDecoration(
                  color: Color(kWhite),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(24))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Setting',
                    style: TextStyle(
                        fontSize: kHeadingFont, color: Color(kDarkGrey)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SettingTileWidget(
                    title: 'General Setting',
                    iconName: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(kWhite),
                      ),
                      child: Icon(
                        FontAwesomeIcons.slidersH,
                        color: Color(kDarkGrey),
                        size: 24,
                      ),
                    ),
                  ),
                  SettingTileWidget(
                    title: 'Notifications',
                    iconName: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(kWhite),
                      ),
                      child: Icon(
                        FontAwesomeIcons.bell,
                        color: Color(kDarkGrey),
                        size: 27,
                      ),
                    ),
                  ),
                  SettingTileWidget(
                    title: 'Account',
                    iconName: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(kWhite),
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        color: Color(kDarkGrey),
                        size: 30,
                      ),
                    ),
                  ),
                  SettingTileWidget(
                    title: 'FAQ & Support',
                    iconName: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(kWhite),
                      ),
                      child: Icon(
                        FontAwesomeIcons.questionCircle,
                        color: Color(kDarkGrey),
                        size: 27,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
