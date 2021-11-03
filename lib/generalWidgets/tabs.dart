import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/blocs/authBloc/authBloc.dart';
import 'package:piassa_application/blocs/authBloc/authEvent.dart';
import 'package:piassa_application/blocs/authBloc/authState.dart';

import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/screens/homeScreen/homeScreen.dart';
import 'package:piassa_application/screens/loginScreen/loginScreen.dart';
import 'package:piassa_application/screens/matchesListingScreen/matchesListingScreen.dart';
import 'package:piassa_application/screens/myProfileScreen/myProfileScreen.dart';
import 'package:piassa_application/screens/settingsScreen/settingsScreen.dart';
import 'package:piassa_application/screens/signUpScreen/signUpScreen.dart';

class Tabs extends StatelessWidget {
  AuthRepository userRepository;

  final User user;

  Tabs({required this.user, required this.userRepository});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(userRepository: userRepository),
      child: TabsChild(user: user, userRepository: userRepository),
    );
  }
}

class TabsChild extends StatefulWidget {
  final User user;
  final userId;
  final AuthRepository userRepository;

  const TabsChild(
      {this.userId, required this.user, required this.userRepository});

  @override
  _TabsChildState createState() => _TabsChildState();
}

class _TabsChildState extends State<TabsChild> {
  List<Widget> _pages = [];
  List<String> _titles = ['Profile', 'Search', 'Matches'];
  late int _selectedPageIndex;
  late AuthBloc authBloc;

  @override
  void initState() {
    _selectedPageIndex = 1;
    super.initState();
  }

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Do you want to log out?", style: TextStyle(fontSize: kNormalFont, color: Color(kBlack))),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new MaterialButton(
              child: new Text(
                "No",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new MaterialButton(
              child: new Text(
                "Yes",
                style: TextStyle(color: Color(klightPink)),
              ),
              onPressed: () {
                authBloc.add(LogOutEvent());

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user);
    authBloc = BlocProvider.of<AuthBloc>(context);
    _pages = [
      MyProfileScreen(user: widget.user, userRepository: widget.userRepository),
      HomePageParent(
          // user: widget.user,
          userRepository: widget.userRepository),
      MatchesListingScreen()
    ];
    return Theme(
      data: ThemeData(
        primaryColor: Color(kPrimaryPurple),
        accentColor: Colors.white,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarWidget(
            actionIcon: Card(
              shape: CircleBorder(),
              shadowColor: Colors.grey,
              elevation: 4,
              color: Color(kWhite),
              child: _selectedPageIndex == 2
                  ? BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is LogOutSuccessState) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return LoginPageParent(
                                userRepository: widget.userRepository);
                          }));
                        }
                      },
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return IconButton(
                              onPressed: () {
                                _showDialog();
                              },
                              icon: Icon(
                                Icons.logout_outlined,
                                color: Color(klightPink),
                                size: 17,
                              ));
                        },
                      ),
                    )
                  : Container()
                  // IconButton(
                  //     onPressed: () {
                  //       Navigator.of(context)
                  //           .push(MaterialPageRoute(builder: (context) {
                  //         return SettingsScreen();
                  //       }));
                  //     },
                  //     icon: Container()
                  //     // Icon(
                  //     //   FontAwesomeIcons.slidersH,
                  //     //   color: Color(kDarkGrey),
                  //     //   size: 17,
                  //     // )
                  //     ),
            ),
            colorVal: (_selectedPageIndex == 0)
                ? Color(klightPink)
                : _selectedPageIndex == 1
                    ? Color(kWhite)
                    : Color(klightPink),
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
                        color: Color(kWhite))),
          ),
        ),
        body: _pages[_selectedPageIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 8.0, right: 8.0, bottom: 16.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: Color(kWhite),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black54,
                //     blurRadius: 3.0,
                //     spreadRadius: 2.0,
                //     offset: Offset(6.0, 6.0),
                //   )
                // ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16))),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16)),
              child: BottomNavigationBar(
                onTap: selectPage,
                iconSize: 26,
                elevation: 10,
                backgroundColor: Color(kWhite),
                unselectedItemColor: Colors.grey,
                selectedItemColor: Color(klightPink),
                currentIndex: _selectedPageIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.userAlt),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.search),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.arrow_upward),
                    icon: FaIcon(FontAwesomeIcons.solidComment),
                    label: "",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpPageParent(userRepository: widget.userRepository);
    }));
  }
}
