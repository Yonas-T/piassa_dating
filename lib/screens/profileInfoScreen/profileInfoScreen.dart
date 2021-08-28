import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/screens/educationAndProfessionScreen/educationAndProfessionScreen.dart';
import 'package:piassa_application/screens/lifeStyleScreen/lifeStyleScreen.dart';
import 'package:piassa_application/screens/matchesListingScreen/widgets/topBarWidgetTransparent.dart';
import 'package:piassa_application/screens/profileInfoScreen/widgets/profileCard.dart';


class ProfileInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[Color(kPrimaryPink), Color(kPrimaryPurple)],
              ),
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 100),
                InkWell(
                  onTap: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) {
                    //   return EducationAndProfessionScreen();
                    // }));
                  },
                  child: ProfileCard(
                    cardIcon: [
                      ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (Rect rect) {
                          return LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(kPrimaryPink),
                              Color(kPrimaryPurple)
                            ],
                          ).createShader(rect);
                        },
                        child: Icon(
                          FontAwesomeIcons.graduationCap,
                          size: 40,
                          color: Color(kPrimaryPurple),
                        ),
                      )
                    ],
                    title: 'Education & Profession',
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LifeStyleScreen();
                    }));
                    
                  },
                  child: ProfileCard(
                    cardIcon: [
                      ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (Rect rect) {
                          return LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(kPrimaryPink),
                              Color(kPrimaryPurple)
                            ],
                          ).createShader(rect);
                        },
                        child: Icon(
                          FontAwesomeIcons.glassMartini,
                          size: 40,
                          color: Color(kPrimaryPurple),
                        ),
                      ),
                      ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (Rect rect) {
                          return LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(kPrimaryPink),
                              Color(kPrimaryPurple)
                            ],
                          ).createShader(rect);
                        },
                        child: Icon(
                          Icons.food_bank,
                          size: 40,
                          color: Color(kPrimaryPurple),
                        ),
                      )
                    ],
                    title: 'Life Style',
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {},
                  child: ProfileCard(
                    cardIcon: [
                      ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (Rect rect) {
                          return LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(kPrimaryPink),
                              Color(kPrimaryPurple)
                            ],
                          ).createShader(rect);
                        },
                        child: Icon(
                          FontAwesomeIcons.smile,
                          size: 40,
                          color: Color(kPrimaryPurple),
                        ),
                      )
                    ],
                    title: 'Move Makers',
                  ),
                ),
                SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
          TopBarWidgetTransparent(
            titleBar: 'Profile Info',
          )
        ],
      ),
    );
  }
}
