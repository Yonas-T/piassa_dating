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
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(
          actionIcon: Card(
              shape: CircleBorder(),
              shadowColor: Colors.grey[300],
              elevation: 1,
              color: Color(kWhite),
              child: IconButton(onPressed: () {
                
              }, icon: Icon(FontAwesomeIcons.slidersH, color: Color(kPrimaryPink),)),
            ),
          colorVal: Colors.transparent,
          leadingIcon: Container(),
          // IconButton(
          //   icon: Icon(Icons.arrow_back, color: Color(kPrimaryPink)),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          title: '${_titles[_selectedPageIndex]}',
        ),
      ),
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Color(kDarkGrey),
        //   title: Text(
        //     "Home",
        //     style: TextStyle(
        //       fontSize: kTitleFont,
        //     ),
        //   ),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(Icons.exit_to_app),
        //       onPressed: () {
        //         BlocProvider.of<HomePageBloc>(context).add(LogOutEvent());
        //       },
        //     )
        //   ],
        // ),
        body: _pages[_selectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: selectPage,
          iconSize: 17,
          elevation: 10,
          backgroundColor: Color(kWhite),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(kPrimaryPurple),
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.arrow_upward),
              icon: FaIcon(FontAwesomeIcons.star),
              label: "Matches",
            ),
          ],
        ),
      ),
    );
  }
}
