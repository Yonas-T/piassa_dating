import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/blocs/subscriptionBloc/subscriptionBloc.dart';
import 'package:piassa_application/blocs/subscriptionBloc/subscriptionEvent.dart';
import 'package:piassa_application/blocs/subscriptionBloc/subscriptionState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
import 'package:piassa_application/repositories/subscriptionRepository.dart';
import 'package:piassa_application/screens/educationAndProfessionScreen/educationAndProfessionScreen.dart';
import 'package:piassa_application/screens/lifeStyleScreen/lifeStyleScreen.dart';
import 'package:piassa_application/screens/moveMakersScreen/moveMakersScreen.dart';
import 'package:piassa_application/screens/myProfileScreen/widgets/paymentPackageListWidget.dart';
import 'package:piassa_application/screens/myProfileScreen/widgets/photoAndNameWidget.dart';
import 'package:piassa_application/screens/myProfileScreen/widgets/profileDetailTileWidget.dart';
import 'package:piassa_application/screens/preferenceScreen/preferenceScreen.dart';
import 'package:piassa_application/screens/signupquestions/widgets/secondStepperPageWidget.dart';

class MyProfileScreen extends StatefulWidget {
  final User user;
  final AuthRepository userRepository;
  SubscriptionRepository subscriptionRepository = SubscriptionRepository();

  MyProfileScreen({required this.user, required this.userRepository});

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionBloc(
          subscriptionRepository: widget.subscriptionRepository)
        ..add(LoadSubscriptionEvent()),
      child: MyProfileChildScreen(
        user: widget.user,
        userRepository: widget.userRepository,
      ),
    );
  }
}

class MyProfileChildScreen extends StatefulWidget {
  final User user;
  final AuthRepository userRepository;

  MyProfileChildScreen({required this.user, required this.userRepository});

  @override
  _MyProfileChildScreenState createState() => _MyProfileChildScreenState();
}

class _MyProfileChildScreenState extends State<MyProfileChildScreen> {
  BasicProfileRepository basicProfileRepository = BasicProfileRepository();
  MatchPreferenceRepository matchPreferenceRepository =
      MatchPreferenceRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(klightPink),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(kWhite),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            PhotoAndNameWidget(
                user: widget.user,
                basicProfileRepository: basicProfileRepository,
                matchPreferenceRepository: matchPreferenceRepository),
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SecondStepperPageWidget(
                            toEdit: true,
                            basicProfileRepository: basicProfileRepository,
                            user: widget.user);
                      }));
                    },
                    child: ProfileDetailTileWidget(
                      tileIcon: Card(
                        shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Color(kDarkGrey),
                            size: 28,
                          ),
                        ),
                      ),
                      tileTitle: 'Preference',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      print('tapped');
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EducationAndProfessionScreen();
                      }));
                    },
                    child: ProfileDetailTileWidget(
                      tileIcon: Card(
                        shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 12.0, 14.0, 12.0),
                          child: Icon(
                            FontAwesomeIcons.graduationCap,
                            color: Color(kDarkGrey),
                            size: 25,
                          ),
                        ),
                      ),
                      tileTitle: 'Education Background',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LifeStyleScreen();
                      }));
                    },
                    child: ProfileDetailTileWidget(
                      tileIcon: Card(
                        shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            FontAwesomeIcons.glassMartini,
                            color: Color(kDarkGrey),
                            size: 24,
                          ),
                        ),
                      ),
                      tileTitle: 'LifeStyle',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MoveMakersScreen();
                      }));
                    },
                    child: ProfileDetailTileWidget(
                      tileIcon: Card(
                        shape: CircleBorder(),
                        elevation: 4,
                        color: Color(kWhite),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.emoji_emotions_outlined,
                            color: Color(kDarkGrey),
                            size: 28,
                          ),
                        ),
                      ),
                      tileTitle: 'Move Maker Questions',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            BlocBuilder<SubscriptionBloc, SubscriptionState>(
              builder: (context, state) {
                print(state);
                if (state is SubscriptionFailState) {
                  print(state.message);
                }

                if (state is SubscriptionLoadedState) {
                  print(state.subscription);
                  return PaymentPackageListWidget(
                    subscription: state.subscription,
                  );
                }
                return Container();
              },
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
