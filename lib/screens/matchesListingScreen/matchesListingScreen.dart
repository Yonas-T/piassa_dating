import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/screens/matchesListingScreen/widgets/matchSearchBarWidget.dart';
import 'package:piassa_application/screens/matchesListingScreen/widgets/singleMatchesListWidget.dart';
import 'package:piassa_application/screens/profileScreen/profileScreen.dart';

class MatchesListingScreen extends StatefulWidget {
  @override
  _MatchesListingScreenState createState() => _MatchesListingScreenState();
}

class _MatchesListingScreenState extends State<MatchesListingScreen> {
  List<Peoples> _matchesList = [];

  @override
  void initState() {
    _matchesList.add(Peoples(
        name: 'Test Person',
        id: '1',
        time: '10:00',
        gender: 'female',
        location: GeoPoint(10, 10),
        profilePictureURL:
            'https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg',
        lastMessage: 'Hey There'));
    _matchesList.add(Peoples(
        name: 'Another Person',
        id: '2',
        time: '04:00',
        gender: 'female',
        location: GeoPoint(10, 10),
        profilePictureURL:
            'https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg',
        lastMessage: 'Hello'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var restHeight = 160;
    return Scaffold(
      body: Container(
          // color: Color(kDarkGrey),
          child:
              // Column(
              //   children: [
              // Container(
              //   padding: EdgeInsets.fromLTRB(16, 24, 16, 4),
              //   height: restHeight / 2,
              //   color: Color(kDarkGrey),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       CircleAvatar(
              //         backgroundColor: Color(kWhite),
              //         radius: 20,
              //         child: Icon(
              //           FontAwesomeIcons.slidersH,
              //           color: Color(kDarkGrey),
              //         ),
              //       ),
              //       Text(
              //         'Matches',
              //         style:
              //             TextStyle(fontSize: kTitleFont, color: Color(kWhite)),
              //       ),
              //       CircleAvatar(
              //         backgroundColor: Color(kWhite),
              //         radius: 20,
              //         child: Icon(
              //           FontAwesomeIcons.bell,
              //           color: Color(kDarkGrey),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // MatchSearchBarWidget(
              //   height: restHeight / 2,
              //   listOfPeoples: _matchesList,
              // ),

              // SizedBox(height: 8),
              Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(kWhite),
          // borderRadius: BorderRadius.only(
          //   topRight: Radius.circular(24),
          // ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70),
            Container(
              height: MediaQuery.of(context).size.height * .18,
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _matchesList.length,
                  itemBuilder: (context, i) {
                    return Container(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Color(kDarkGrey),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            _matchesList[i].profilePictureURL,
                          ),
                          radius: 40,
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 4),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Color(kDarkGrey).withOpacity(0.6),
            ),
            SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _matchesList.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProfileScreen();
                        }));
                      },
                      child: SingleMatchesListWidget(peoples: _matchesList[i]),
                    );
                  }),
            ),
          ],
        ),
      )
          //   ],
          // ),
          ),
    );
  }
}
