import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/customBottomNavBar.dart';
import 'package:piassa_application/models/profile.dart';
import 'package:piassa_application/screens/matchesListingScreen/widgets/topBarWidgetTransparent.dart';
import 'package:piassa_application/screens/profileScreen/widgets/infoTextWidget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Profile> _profile = [];

  @override
  void initState() {
    _profile.add(Profile(
        name: 'Person',
        age: '23',
        city: 'Addis Ababa',
        drink: 'Occasionally',
        education: 'Bachelors Degree',
        height: '173cm',
        occupation: 'Accountant',
        religion: 'Orthodox',
        sport: 'Daily',
        imageUrl:
            'https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg',
        bio: 'I am an easy going person.'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .7,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(_profile[0].imageUrl),
                    fit: BoxFit.cover)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
              height: MediaQuery.of(context).size.height * .6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoTextWidget(myProfile: _profile[0]),
                  
                  Container(
                    height: 120,
                    padding: EdgeInsets.all(24),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(kWhite),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: CustomBottomNavBar(),
                  )
                ],
              ),
            ),
          ),
          TopBarWidgetTransparent(titleBar: ''),
        ],
      ),
    );
  }
}
