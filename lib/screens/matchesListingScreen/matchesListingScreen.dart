import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/screens/chatScreen/chatScreen.dart';
import 'package:piassa_application/screens/itsAMatchScreen/itsAMatchScreen.dart';
import 'package:piassa_application/screens/matchesListingScreen/widgets/matchSearchBarWidget.dart';
import 'package:piassa_application/screens/matchesListingScreen/widgets/singleMatchesListWidget.dart';
import 'package:piassa_application/screens/profileScreen/profileScreen.dart';

class MatchesListingScreen extends StatefulWidget {
  @override
  _MatchesListingScreenState createState() => _MatchesListingScreenState();
}

class _MatchesListingScreenState extends State<MatchesListingScreen> {
  List<Peoples> _matchesList = [];
  bool _isLiked = false;

  @override
  void initState() {
    _isLiked = false;
    _matchesList.add(Peoples(
        userName: 'Test Person',
        fullName: '1',
        gender: '10:00',
        email: 'female',
        latitude: GeoPoint(10, 10).latitude,
        longitude: GeoPoint(10, 10).longitude,
        birthDay: '12/12/12',
        nationality: 'Ethiopian',
        headline: 'asdfgh',
        height: 1.7));
    _matchesList.add(Peoples(
        userName: 'Test Person',
        fullName: '1',
        gender: '10:00',
        email: 'female',
        latitude: GeoPoint(10, 10).latitude,
        longitude: GeoPoint(10, 10).longitude,
        birthDay: '12/12/12',
        nationality: 'Ethiopian',
        headline: 'asdfgh',
        height: 1.7));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kWhite),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'New Likes',
                style: TextStyle(
                  fontSize: kButtonFont,
                  color: Color(kBlack),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .14,
              padding: EdgeInsets.only(left: 20),
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
                            '_matchesList[i].profilePictureURL',
                          ),
                          radius: 40,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Card(
                              shape: CircleBorder(),
                              elevation: 6,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isLiked = true;

                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ItsAMatchScreen();
                                    }));
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 8.0,
                                  child: !_isLiked
                                      ? Icon(
                                          Icons.favorite,
                                          size: 10.0,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.check,
                                          size: 10.0,
                                          color: Colors.green,
                                        ),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Color(kLightGrey).withOpacity(0.6),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Matches',
                style: TextStyle(
                  fontSize: kButtonFont,
                  color: Color(kBlack),
                ),
              ),
            ),
            SizedBox(height: 4),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 0.8,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                children: _matchesList.map((value) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.35,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ChatScreen(
                                'Helina',
                                'Female / 5km / 44m',
                                'I bring a lot of energy to what I do and always have some leftover to get into trouble on the weekends at my fav. local bar. (If you play your cards right, maybe we can meet there.)',
                                "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg");
                          }));
                        },
                        child: SingleMatchesListWidget(
                          userData: value,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
