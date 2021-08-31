import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
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
    return Scaffold(
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
                      Icons.check,
                      color: Color(klightPink),
                      size: 14,
                    ))),
          ),
          colorVal: Color(klightPink),
          leadingIcon: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(kWhite), size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          title: Text('Matches',
              style: TextStyle(
                  fontSize: kTitleBoldFont,
                  fontWeight: FontWeight.bold,
                  color: Color(kWhite))),
        ),
      ),
      body: Container(
        color: Color(kWhite),
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
                  color: Color(kDarkGrey),
                ),
              ),
            ),
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
                  color: Color(kDarkGrey),
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 0.8,
                scrollDirection: Axis.vertical,
                children: _matchesList.map((value) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.7,
                      alignment: Alignment.center,
                      child: SingleMatchesListWidget(
                        userData: value,
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
