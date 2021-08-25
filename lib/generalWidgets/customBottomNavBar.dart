import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/screens/matchesListingScreen/matchesListingScreen.dart';
import 'package:piassa_application/screens/profileInfoScreen/profileInfoScreen.dart';
import 'package:piassa_application/screens/profileScreen/profileScreen.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 80,
      width: MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
          color: Color(kWhite),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ProfileInfoScreen();
              }));
            },
            child: Container(
              height: 80,
              width: (MediaQuery.of(context).size.width * .8)/4,
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.user,
                    color: Color(isSelected? kDarkGrey : kPrimaryPink),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: kSmallFont, color: Color(kPrimaryPink)),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.slideshare,
                  color: Color(kPrimaryPink),
                ),
                Text(
                  'Discover',
                  style: TextStyle(
                      fontSize: kSmallFont, color: Color(kPrimaryPink)),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MatchesListingScreen();
              }));
            },
            child: Column(
              children: [
                Icon(
                  Icons.message,
                  color: Color(kPrimaryPink),
                ),
                Text(
                  'Matches',
                  style: TextStyle(
                      fontSize: kSmallFont, color: Color(kPrimaryPink)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
