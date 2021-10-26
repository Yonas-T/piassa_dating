import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class ProfileDetailTileWidget extends StatefulWidget {
  final Widget tileIcon;
  final String tileTitle;

  ProfileDetailTileWidget({required this.tileIcon, required this.tileTitle});

  @override
  _ProfileDetailTileWidgetState createState() =>
      _ProfileDetailTileWidgetState();
}

class _ProfileDetailTileWidgetState extends State<ProfileDetailTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(klightPink).withOpacity(0.05),
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
                style: TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
