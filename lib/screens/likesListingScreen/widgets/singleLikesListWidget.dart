import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';

class SingleLikesListWidget extends StatefulWidget {
  final Peoples peoples;

  SingleLikesListWidget({required this.peoples});
  @override
  _SingleLikesListWidgetState createState() => _SingleLikesListWidgetState();
}

class _SingleLikesListWidgetState extends State<SingleLikesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(widget.peoples.profilePictureURL),
            radius: 32,
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .65,
                    child: Text(
                      widget.peoples.name,
                      style: TextStyle(
                          fontSize: kNormalFont, color: Color(kWhite)),
                    ),
                  ),
                  Text(
                    widget.peoples.time,
                    style: TextStyle(
                      fontSize: kNormalFont,
                      color: Color(kWhite),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Text(
                widget.peoples.lastMessage,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: kSmallFont, color: Color(kWhite)),
              ),
              SizedBox(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width*.75,
                color: Color(kWhite).withOpacity(0.6),
                height: 1,
              )
            ],
          )
        ],
      ),
    );
  }
}
