import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/screens/educationAndProfessionScreen/educationAndProfessionScreen.dart';
import 'package:piassa_application/screens/lifeStyleScreen/lifeStyleScreen.dart';
import 'package:piassa_application/screens/moveMakersScreen/moveMakersScreen.dart';
import 'package:piassa_application/screens/myProfileScreen/widgets/paymentPackageListWidget.dart';
import 'package:piassa_application/screens/myProfileScreen/widgets/photoAndNameWidget.dart';
import 'package:piassa_application/screens/myProfileScreen/widgets/profileDetailTileWidget.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 8),
          PhotoAndNameWidget(),
          SizedBox(
            height: 16,
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    //   return ();
                    // }));
                },
                child: ProfileDetailTileWidget(
                    tileIcon: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(kWhite),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Color(kDarkGrey),
                        size: 30,
                      ),
                    ),
                    tileTitle: 'Preference',
                    ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                      print('tapped');
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EducationAndProfessionScreen();
                      }));
                    },
                child: ProfileDetailTileWidget(
                    tileIcon: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(kWhite),
                      ),
                      child: Icon(
                        FontAwesomeIcons.graduationCap,
                        color: Color(kDarkGrey),
                        size: 30,
                      ),
                    ),
                    tileTitle: 'Education Background',
                    ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LifeStyleScreen();
                      }));
                    },
                child: ProfileDetailTileWidget(
                    tileIcon: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(kWhite),
                      ),
                      child: Icon(
                        FontAwesomeIcons.glassMartini,
                        color: Color(kDarkGrey),
                        size: 30,
                      ),
                    ),
                    tileTitle: 'LifeStyle',
                    ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return MoveMakersScreen();
                    }));
                  },
                child: ProfileDetailTileWidget(
                    tileIcon: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(kWhite),
                      ),
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Color(kDarkGrey),
                        size: 30,
                      ),
                    ),
                    tileTitle: 'Move Maker Questions',
                    ),
              ),
            ],
          ),
          PaymentPackageListWidget()
        ],
      ),
    );
  }
}
