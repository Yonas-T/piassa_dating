import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/tabs.dart';
import 'package:piassa_application/repositories/authRepository.dart';

class AllDoneScreen extends StatefulWidget {
  final User user;
  final AuthRepository userRepository;

  const AllDoneScreen({Key? key, required this.user, required this.userRepository}) : super(key: key);

  @override
  _AllDoneScreenState createState() => _AllDoneScreenState();
}

class _AllDoneScreenState extends State<AllDoneScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[Color(kPrimaryPink), Color(kPrimaryPurple)],
          ),
        ),
        child: Column(
          children: [
            Text('All Done',
                style: TextStyle(
                  fontSize: kTitleFont,
                  color: Color(kWhite),
                )),
            Flexible(
                child: Text(
              'Thank you for finishing your profile',
              style: TextStyle(
                fontSize: kNormalFont,
                color: Color(kWhite),
              ),
              overflow: TextOverflow.visible,
            )),
            Container(
              height: 80,
              width: 80,
              color: Color(kPrimaryOrange).withOpacity(0.4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Container(
                height: 60,
                width: 60,
                color: Color(kWhite),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Tabs(user: widget.user, userRepository: widget.userRepository);
              }));
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      color: Color(kPrimaryPink),
                      fontSize: kNormalFont,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
