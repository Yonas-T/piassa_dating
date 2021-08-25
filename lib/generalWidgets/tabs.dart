import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/blocs/homePageBloc/homePageBloc.dart';
import 'package:piassa_application/blocs/homePageBloc/homePageEvent.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/screens/homeScreen/homeScreen.dart';
import 'package:piassa_application/screens/likesListingScreen/likesListingScreen.dart';
import 'package:piassa_application/screens/matchesListingScreen/matchesListingScreen.dart';

class Tabs extends StatefulWidget {
  final User user;
  final userId;
  final AuthRepository userRepository;

  const Tabs({this.userId, required this.user, required this.userRepository});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, Widget>> _pages = [
      {'page': HomePageParent(user: widget.user, userRepository: widget.userRepository)},
      {'page': MatchesListingScreen()},
      {'page': LikesListingScreen()},
    ];


    int _selectedPageIndex = 0;

    void _selectPage(int index) {
      setState(() {
        _selectedPageIndex = index;
      });
    }

    return Theme(
      data: ThemeData(
        primaryColor: Color(kPrimaryPurple),
        accentColor: Colors.white,
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(kDarkGrey),
            title: Text(
              "Chill",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<HomePageBloc>(context).add(LogOutEvent());
                },
              )
            ],
            
          ),
          body: _pages[_selectedPageIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            iconSize: 17,
            elevation: 10,
            backgroundColor: Color(kWhite),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Color(kPrimaryPurple),
            currentIndex: _selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.search),
                title: Text("Search"),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.microphone),
                title: Text("Likes"),
              ),
              BottomNavigationBarItem(
                // icon: Icon(Icons.arrow_upward),
                icon: FaIcon(FontAwesomeIcons.star),
                title: Text("Matches"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
