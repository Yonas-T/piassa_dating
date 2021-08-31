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
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[Color(kPrimaryPink), Color(kPrimaryPurple)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('All Done',
                  style: TextStyle(
                    fontSize: kExtraLargeFont,
                    color: Color(kWhite),
                  )),
              Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                    child: Text(
                'Thank you for for completing your profile, now you will get your matches.',
                style: TextStyle(
                    fontSize: kNormalFont,
                    color: Color(kWhite),
                ),
                overflow: TextOverflow.visible,
              ),
                  )),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                color: Color(klightPink),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 60,
                    width: 60,
                  decoration: BoxDecoration(
                    color: Color(kWhite),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
