import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final List<Widget> cardIcon;

  ProfileCard({required this.cardIcon, required this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color(kWhite),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 180,
        width: MediaQuery.of(context).size.width * .80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: kHeadingFont, color: Color(kPrimaryPink)),
              ),
            ),
            ListView.builder(
                itemCount: cardIcon.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return cardIcon[i];
                })
          ],
        ),
      ),
    );
  }
}
