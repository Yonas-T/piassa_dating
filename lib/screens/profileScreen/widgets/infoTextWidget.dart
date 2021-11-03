import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/profile.dart';
import 'package:piassa_application/models/userMatch.dart';

class InfoTextWidget extends StatefulWidget {
  bool isFromChat;
  final UserMatch recommended;
  InfoTextWidget({required this.recommended, required this.isFromChat});

  @override
  _InfoTextWidgetState createState() => _InfoTextWidgetState();
}

class _InfoTextWidgetState extends State<InfoTextWidget> {
  late int age;

  @override
  void initState() {
    var bDay = DateTime.parse(widget.recommended.birthDay).year;
    var now = DateTime.now().year;
    age = now - bDay;
    print(widget.recommended.education!.profession.englishValue);
    super.initState();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Do you want to block this user?",
              style: TextStyle(fontSize: kNormalFont, color: Color(kBlack))),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new MaterialButton(
              child: new Text(
                "No",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new MaterialButton(
              child: new Text(
                "Yes",
                style: TextStyle(color: Color(klightPink)),
              ),
              onPressed: () {
                // authBloc.add(LogOutEvent());

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.recommended.fullName}, $age',
                style: TextStyle(fontSize: kTitleFont, color: Color(kBlack)),
              ),
              widget.isFromChat ? InkWell(
                onTap: () {
                  _showDialog();
                },
                child: Text(
                  'Block User',
                  style: TextStyle(fontSize: kNormalFont, color: Colors.red),
                ),
              ) : Container()
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Addis Ababa',
                style: TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
              ),
              SizedBox(width: 12),
              Container(
                height: 2,
                width: 10,
                color: Color(kBlack),
              ),
              SizedBox(width: 12),
              Text(
                widget.recommended.height.toString(),
                style: TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
              ),
            ],
          ),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.graduationCap,
                    color: Color(klightPink),
                  ),
                  SizedBox(width: 12),
                  Text(
                    widget.recommended.education!.profession.englishValue,
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
                  ),
                ],
              ),
              // SizedBox(width: 20),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.suitcase,
                    color: Color(klightPink),
                  ),
                  SizedBox(width: 12),
                  Text(
                    widget.recommended.education!.profession.englishValue,
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.building,
                    color: Color(klightPink),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Religion',
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
                  ),
                ],
              ),
              SizedBox(width: 40),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.dumbbell,
                    color: Color(klightPink),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '${widget.recommended.lifeStyle!.physicalExercise.toString()} per week',
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.glassMartini,
                    color: Color(klightPink),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '${widget.recommended.lifeStyle!.drinking.toString()} per week',
                    style:
                        TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 48),
          Text(
            widget.recommended.headline,
            style: TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
          )
        ],
      ),
    );
  }
}
