import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/screens/likesListingScreen/widgets/searchBarWidget.dart';
import 'package:piassa_application/screens/likesListingScreen/widgets/singleLikesListWidget.dart';
import 'package:piassa_application/screens/matchesListingScreen/widgets/topBarWidget.dart';

class LikesListingScreen extends StatefulWidget {
  @override
  _LikesListingScreenState createState() => _LikesListingScreenState();
}

class _LikesListingScreenState extends State<LikesListingScreen> {
  List<Peoples> _likesList = [];

  @override
  void initState() {
    _likesList.add(Peoples(
        id: '1',
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
    _likesList.add(Peoples(
        id: '2',
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
    var restHeight = 160;
    return Scaffold(
      body: Container(
        color: Color(kDarkGrey),
        // padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          children: [
            TopBarWidget(
              titleBar: 'Likes',
            ),
            SearchBarWidget(
              height: restHeight / 2,
              listOfPeoples: _likesList,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height - restHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[Color(kPrimaryPink), Color(kMidPurple)],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                  ),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _likesList.length,
                    itemBuilder: (context, i) {
                      return SingleLikesListWidget(peoples: _likesList[i]);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
