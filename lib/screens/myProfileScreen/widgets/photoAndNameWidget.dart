import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/screens/signupquestions/signupQuestions.dart';

class PhotoAndNameWidget extends StatefulWidget {
  final User user;

  final BasicProfileRepository basicProfileRepository;
  const PhotoAndNameWidget({
    required this.user,
     required this.basicProfileRepository});

  @override
  _PhotoAndNameWidgetState createState() => _PhotoAndNameWidgetState();
}

class _PhotoAndNameWidgetState extends State<PhotoAndNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SignupQuestionsScreen(
                  user: widget.user, 
                  basicProfileRepository: widget.basicProfileRepository);
            }));
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://img.freepik.com/free-photo/portrait-young-beautiful-african-girl-dark-wall_176420-5818.jpg?size=626&ext=jpg'),
            radius: 64,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Card(
                shape: CircleBorder(),
                elevation: 4,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      size: 24.0,
                      color: Color(kDarkGrey),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Name',
          style: TextStyle(fontSize: kLargeFont, color: Color(kBlack)),
        )
      ],
    );
  }
}
