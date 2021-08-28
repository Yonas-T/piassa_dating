import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class ProfileDetailTileWidget extends StatefulWidget {
  final Widget tileIcon;
  final String tileTitle;

  ProfileDetailTileWidget(
      {
      required this.tileIcon,
      required this.tileTitle});

  @override
  _ProfileDetailTileWidgetState createState() =>
      _ProfileDetailTileWidgetState();
}

class _ProfileDetailTileWidgetState extends State<ProfileDetailTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xfe676e).withOpacity(0.03),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              widget.tileIcon,
              SizedBox(
                width: 16,
              ),
              Text(
                widget.tileTitle,
                style:
                    TextStyle(fontSize: kNormalFont, color: Color(kDarkGrey)),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(kPrimaryPink),
          )
        ],
      ),
    );
  }
}
