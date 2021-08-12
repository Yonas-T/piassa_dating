import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/screens/likesListingScreen/widgets/searchBarWidget.dart';
import 'package:piassa_application/screens/likesListingScreen/widgets/singleLikesListWidget.dart';

class LikesListingScreen extends StatefulWidget {
  @override
  _LikesListingScreenState createState() => _LikesListingScreenState();
}

class _LikesListingScreenState extends State<LikesListingScreen> {
  List<Peoples> _likesList = [];

  @override
  void initState() {
    _likesList.add(Peoples(
        name: 'Test Person',
        id: '1',
        time: '10:00',
        profilePictureURL:
            'https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg',
        lastMessage: 'Hey There'));
    _likesList.add(Peoples(
        name: 'Another Person',
        id: '2',
        time: '04:00',
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
        color: Color(kDarkGrey),
        // padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 4),
              height: restHeight / 2,
              color: Color(kDarkGrey),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(kWhite),
                    radius: 20,
                    child: Icon(
                      FontAwesomeIcons.slidersH,
                      color: Color(kDarkGrey),
                    ),
                  ),
                  Text(
                    'Likes',
                    style:
                        TextStyle(fontSize: kTitleFont, color: Color(kWhite)),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(kWhite),
                    radius: 20,
                    child: Icon(
                      FontAwesomeIcons.bell,
                      color: Color(kDarkGrey),
                    ),
                  ),
                ],
              ),
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
