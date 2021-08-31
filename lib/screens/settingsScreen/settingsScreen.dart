import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
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
      backgroundColor: Color(klightPink),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(
          actionIcon: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(color: Color(kWhite), shape: BoxShape.circle),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.clear,
                      color: Color(klightPink),
                      size: 17,
                    ))),
          ),
          colorVal: Color(klightPink),
          leadingIcon: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container()
          ),
          title: Text('',
              style: TextStyle(
                  fontSize: kTitleBoldFont,
                  fontWeight: FontWeight.bold,
                  color: Color(kWhite))),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(kWhite),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: ListView(
          children: [
            SizedBox(height: 10),
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
                    'Settings',
                    style: TextStyle(
                        fontSize: kHeadingFont, color: Color(kBlack)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SettingTileWidget(
                    title: 'General Setting',
                    iconName: Card(
                      shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.slidersH,
                          color: Color(kDarkGrey),
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                  height: 8,
                ),
                  SettingTileWidget(
                    title: 'Notifications',
                    iconName: Card(
                      shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.bell,
                          color: Color(kDarkGrey),
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                  height: 8,
                ),
                  SettingTileWidget(
                    title: 'Account',
                    iconName: Card(
                      shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.lock_outline,
                          color: Color(kDarkGrey),
                          size: 27,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                  height: 8,
                ),
                  SettingTileWidget(
                    title: 'FAQ & Support',
                    iconName: Card(
                      shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.questionCircle,
                          color: Color(kDarkGrey),
                          size: 25,
                        ),
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
