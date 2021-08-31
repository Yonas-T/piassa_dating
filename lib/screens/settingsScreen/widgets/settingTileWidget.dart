import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';

class SettingTileWidget extends StatelessWidget {
  final Widget iconName;
  final String title;

  SettingTileWidget({required this.iconName, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(klightPink).withOpacity(0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              iconName,
          SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
          ),
            ],
          ),
          
          Icon(Icons.arrow_forward_ios, color: Color(kPrimaryPink),size: 16,)
        ],
      ),
    );
  }
}
