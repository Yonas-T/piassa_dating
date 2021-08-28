import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/profile.dart';

class InfoTextWidget extends StatelessWidget {
  final Profile myProfile;
  InfoTextWidget({required this.myProfile});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            '${myProfile.name}, ${myProfile.age}',
            style: TextStyle(fontSize: kTitleFont, color: Color(kWhite)),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                myProfile.city,
                style: TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
              ),
              SizedBox(width: 12),
              Container(
                height: 2,
                width: 10,
                color: Color(kWhite),
              ),
              SizedBox(width: 12),
              Text(
                myProfile.height,
                style: TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
              ),
            ],
          ),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.graduationCap,
                    color: Color(kWhite),
                  ),
                  SizedBox(width: 12),
                  Text(
                    myProfile.education,
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.suitcase,
                    color: Color(kWhite),
                  ),
                  SizedBox(width: 12),
                  Text(
                    myProfile.occupation,
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.building,
                    color: Color(kWhite),
                  ),
                  SizedBox(width: 12),
                  Text(
                    myProfile.religion,
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.dumbbell,
                    color: Color(kWhite),
                  ),
                  SizedBox(width: 12),
                  Text(
                    myProfile.sport,
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.glassMartini,
                    color: Color(kWhite),
                  ),
                  SizedBox(width: 12),
                  Text(
                    myProfile.drink,
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 48),
          Text(
            myProfile.bio,
            style: TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
          )
        ],
      ),
    );
  }
}
