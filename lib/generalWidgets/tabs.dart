import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/blocs/homePageBloc/homePageBloc.dart';
import 'package:piassa_application/blocs/homePageBloc/homePageEvent.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/screens/educationAndProfessionScreen/educationAndProfessionScreen.dart';
import 'package:piassa_application/screens/homeScreen/homeScreen.dart';
import 'package:piassa_application/screens/likesListingScreen/likesListingScreen.dart';
import 'package:piassa_application/screens/matchesListingScreen/matchesListingScreen.dart';
import 'package:piassa_application/screens/myProfileScreen/myProfileScreen.dart';
import 'package:piassa_application/screens/profileInfoScreen/profileInfoScreen.dart';
import 'package:piassa_application/screens/signupquestions/signupQuestions.dart';

class Tabs extends StatefulWidget {
  final User user;
  final userId;
  final AuthRepository userRepository;

  const Tabs({this.userId, required this.user, required this.userRepository});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<Widget> _pages = [];
  List<String> _titles = ['Profile', 'Search', 'Matches'];

  int _selectedPageIndex = 1;

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      MyProfileScreen(),
      HomePageParent(user: widget.user, userRepository: widget.userRepository),
      MatchesListingScreen()
    ];
    return Theme(
      data: ThemeData(
        primaryColor: Color(kPrimaryPurple),
        accentColor: Colors.white,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarWidget(
            actionIcon: Card(
              shape: CircleBorder(),
              shadowColor: Colors.grey,
              elevation: 4,
              color: Color(kWhite),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.slidersH,
                    color: Color(kDarkGrey),
                    size: 17,
                  )),
            ),
            colorVal: _selectedPageIndex == 0 ? Color(klightPink) : _selectedPageIndex == 1 ? Color(kWhite) : Color(kWhite),
            leadingIcon: Container(),
            // IconButton(
            //   icon: Icon(Icons.arrow_back, color: Color(kPrimaryPink)),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            title: _selectedPageIndex == 1
                ? Container(
                    child: Image.asset('assets/images/piassa-logo.png'),
                    width: 160,
                  )
                : Text(_titles[_selectedPageIndex],
                    style: TextStyle(
                        fontSize: kTitleBoldFont,
                        fontWeight: FontWeight.bold,
                        color: Color(kDarkGrey))),
          ),
        ),
        body: _pages[_selectedPageIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 16.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: Color(kWhite),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 3.0,
                    spreadRadius: 2.0,
                    offset: Offset(6.0, 6.0),
                  )
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16))),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16)),
              child: BottomNavigationBar(
                onTap: selectPage,
                iconSize: 17,
                elevation: 10,
                backgroundColor: Color(kWhite),
                unselectedItemColor: Colors.grey,
                selectedItemColor: Color(klightPink),
                currentIndex: _selectedPageIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.user),
                    label: "Profile",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.search),
                    label: "Discover",
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.arrow_upward),
                    icon: FaIcon(FontAwesomeIcons.star),
                    label: "Matches",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
