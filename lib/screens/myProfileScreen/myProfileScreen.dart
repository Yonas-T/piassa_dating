import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
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
      backgroundColor: Color(klightPink),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(kWhite),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            PhotoAndNameWidget(),
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      //   return ();
                      // }));
                    },
                    child: ProfileDetailTileWidget(
                      tileIcon: Card(
                        shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Color(kDarkGrey),
                            size: 28,
                          ),
                        ),
                      ),
                      tileTitle: 'Preference',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      print('tapped');
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EducationAndProfessionScreen();
                      }));
                    },
                    child: ProfileDetailTileWidget(
                      tileIcon: Card(
                        shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 12.0, 14.0, 12.0),
                          child: Icon(
                            FontAwesomeIcons.graduationCap,
                            color: Color(kDarkGrey),
                            size: 25,
                          ),
                        ),
                      ),
                      tileTitle: 'Education Background',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LifeStyleScreen();
                      }));
                    },
                    child: ProfileDetailTileWidget(
                      tileIcon: Card(
                        shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            FontAwesomeIcons.glassMartini,
                            color: Color(kDarkGrey),
                            size: 24,
                          ),
                        ),
                      ),
                      tileTitle: 'LifeStyle',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MoveMakersScreen();
                      }));
                    },
                    child: ProfileDetailTileWidget(
                      tileIcon: Card(
                        shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.emoji_emotions_outlined,
                            color: Color(kDarkGrey),
                            size: 28,
                          ),
                        ),
                      ),
                      tileTitle: 'Move Maker Questions',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            PaymentPackageListWidget(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
