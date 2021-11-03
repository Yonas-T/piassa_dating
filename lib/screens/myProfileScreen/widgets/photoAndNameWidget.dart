import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
import 'package:piassa_application/screens/gallaryScreen/gallaryScreen.dart';
import 'package:piassa_application/screens/signupquestions/signupQuestions.dart';
import 'package:piassa_application/services/matchListApiProvider.dart';
import 'package:piassa_application/services/myProfileApiProvider.dart';

class PhotoAndNameWidget extends StatefulWidget {
  final User user;
  final BasicProfileRepository basicProfileRepository;
  final MatchPreferenceRepository matchPreferenceRepository;
  const PhotoAndNameWidget(
      {required this.user,
      required this.basicProfileRepository,
      required this.matchPreferenceRepository});

  @override
  _PhotoAndNameWidgetState createState() => _PhotoAndNameWidgetState();
}

class _PhotoAndNameWidgetState extends State<PhotoAndNameWidget> {
  UserMatch? myProfile;
  bool gotData = false;

  Future getMyProfile() async {
    myProfile = await MyProfileApiProvider().fetchMyProfile();
  }

  List<String> imgUrl = [];

  @override
  void initState() {
    gotData = false;
    print(gotData);
    getMyProfile().then((value) {
      myProfile!.userImages.forEach((element) {
        print(element.verificationStatus);
        if (element.fileType == 'PROFILE'
            // && element.verificationStatus == 'VERIFIED'
            ) {
          imgUrl.add(element.filePath);
        }
        print(imgUrl);
      });
      print(myProfile);
      setState(() {
        gotData = true;
      });
      print(gotData);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !gotData
        ? Center(
            child: Container(height: 64),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Color(kWhite),
                backgroundImage: NetworkImage(imgUrl[0]),
                radius: 64,
                child: InkWell(
                  onTap: () {
                    print('object');
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      print('pressed');
                      return GallaryScreen(
                          toEdit: true,
                          user: widget.user,
                          basicProfileRepository:
                              widget.basicProfileRepository);
                    }));
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Card(
                      shape: CircleBorder(),
                      elevation: 4,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20.0,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              print('pressed');
                              return SignupQuestionsScreen(
                                toEdit: true,
                                user: widget.user,
                                basicProfileRepository:
                                    widget.basicProfileRepository,
                                matchPreferenceRepository:
                                    widget.matchPreferenceRepository,
                              );
                            }));
                          },
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
              SizedBox(height: 8),
              Text(
                myProfile!.fullName,
                style: TextStyle(fontSize: kLargeFont, color: Color(kBlack)),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context)
                  //         .push(MaterialPageRoute(builder: (context) {
                  //       print('pressed');
                  //       return SignupQuestionsScreen(
                  //         toEdit: true,
                  //         user: widget.user,
                  //         basicProfileRepository: widget.basicProfileRepository,
                  //         matchPreferenceRepository:
                  //             widget.matchPreferenceRepository,
                  //       );
                  //     }));
                  //   },
                  //   child: Text(
                  //     'Edit Profile',
                  //     style: TextStyle(
                  //       color: Color(kPrimaryPink),
                  //       fontSize: kNormalFont,
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          );
  }
}
