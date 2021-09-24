// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:piassa_application/constants/constants.dart';
// import 'package:piassa_application/generalWidgets/appBar.dart';
// import 'package:piassa_application/repositories/authRepository.dart';
// import 'package:piassa_application/screens/homeScreen/homeScreen.dart';
// import 'package:piassa_application/screens/matchesListingScreen/matchesListingScreen.dart';
// import 'package:piassa_application/screens/myProfileScreen/myProfileScreen.dart';
// import 'package:piassa_application/screens/profileInfoScreen/profileInfoScreen.dart';
// import 'package:piassa_application/screens/profileScreen/profileScreen.dart';

// class CustomBottomNavBar extends StatefulWidget {
//   final User user;
//   final userId;
//   final AuthRepository userRepository;

//   const CustomBottomNavBar(
//       {this.userId, required this.user, required this.userRepository});

//   @override
//   _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   bool isSelected = false;
//   List<Widget> _pages = [];
//   List<String> _titles = ['Profile', 'Discover', 'Matches'];
//   int _selectedPageIndex = 1;

//   @override
//   Widget build(BuildContext context) {
//     _pages = [
//       MyProfileScreen(),
//       HomePageParent(user: widget.user, userRepository: widget.userRepository),
//       MatchesListingScreen()
//     ];
//     return Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child: AppBarWidget(
//             actionIcon: Card(
//               shape: CircleBorder(),
//               shadowColor: Colors.grey,
//               elevation: 4,
//               color: Color(kWhite),
//               child: IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     FontAwesomeIcons.slidersH,
//                     color: Color(kDarkGrey),
//                     size: 17,
//                   )),
//             ),
//             colorVal: Colors.transparent,
//             leadingIcon: Container(),
//             // IconButton(
//             //   icon: Icon(Icons.arrow_back, color: Color(kPrimaryPink)),
//             //   onPressed: () => Navigator.of(context).pop(),
//             // ),
//             title: _selectedPageIndex == 1
//                 ? Container(
//                     child: Image.asset('assets/images/piassa-logo.png'),
//                     width: 160,
//                   )
//                 : Text(_titles[_selectedPageIndex],
//                     style: TextStyle(
//                         fontSize: kTitleBoldFont,
//                         fontWeight: FontWeight.bold,
//                         color: Color(kDarkGrey))),
//           ),
//         ),
//         body: Stack(children: [
//           _pages[_selectedPageIndex],
//           Positioned(
//               bottom: 10, child: CustomNavContainer(isSelected: isSelected)),
//         ]));
//   }
// }

// class CustomNavContainer extends StatefulWidget {
  

//   final bool isSelected;
//   int selectedPageIndx;

//   CustomNavContainer({required this.isSelected, required this.selectedPageIndx});

//   @override
//   _CustomNavContainerState createState() => _CustomNavContainerState();
// }

// class _CustomNavContainerState extends State<CustomNavContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       height: 80,
//       width: MediaQuery.of(context).size.width * .85,
//       decoration: BoxDecoration(
//           color: Color(kWhite),
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           InkWell(
//             onTap: () {
//               setState(() {
//                 widget.selectedPageIndx == 0;
//               });
//             },
//             child: ProfileTab(isSelected: widget.isSelected),
//           ),
//           InkWell(
//             onTap: () {},
//             child: DiscoverTab(),
//           ),
//           InkWell(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                 return MatchesListingScreen();
//               }));
//             },
//             child: MatchesTab(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MatchesTab extends StatelessWidget {
//   const MatchesTab({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       width: (MediaQuery.of(context).size.width * .85) / 3,
//       decoration: BoxDecoration(
//           color: Color(klightPink).withOpacity(0.16),
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
//       child: Column(
//         children: [
//           Icon(
//             Icons.message,
//             color: Color(kPrimaryPink),
//           ),
//           Text(
//             'Matches',
//             style: TextStyle(fontSize: kSmallFont, color: Color(kPrimaryPink)),
//           )
//         ],
//       ),
//     );
//   }
// }

// class DiscoverTab extends StatelessWidget {
//   const DiscoverTab({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       width: (MediaQuery.of(context).size.width * .85) / 3,
//       decoration: BoxDecoration(
//           color: Color(klightPink).withOpacity(0.16),
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
//       child: Column(
//         children: [
//           Icon(
//             FontAwesomeIcons.slideshare,
//             color: Color(kPrimaryPink),
//           ),
//           Text(
//             'Discover',
//             style: TextStyle(fontSize: kSmallFont, color: Color(kPrimaryPink)),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ProfileTab extends StatelessWidget {
//   const ProfileTab({
//     Key? key,
//     required this.isSelected,
//   }) : super(key: key);

//   final bool isSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       width: (MediaQuery.of(context).size.width * .85) / 3,
//       decoration: BoxDecoration(
//           color: Color(klightPink).withOpacity(0.16),
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
//       child: Column(
//         children: [
//           Icon(
//             FontAwesomeIcons.user,
//             color: Color(isSelected ? kDarkGrey : kPrimaryPink),
//           ),
//           Text(
//             'Profile',
//             style: TextStyle(fontSize: kSmallFont, color: Color(kPrimaryPink)),
//           )
//         ],
//       ),
//     );
//   }
// }
