import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/tabs.dart';
import 'package:piassa_application/screens/allDoneScreen/allDoneScreen.dart';
import 'package:piassa_application/screens/chatScreen/chatScreen.dart';
import 'package:piassa_application/screens/chatScreen/widgets/chatProfileWIdget.dart';

import 'package:piassa_application/screens/educationAndProfessionScreen/educationAndProfessionScreen.dart';
import 'package:piassa_application/screens/gallaryScreen/gallaryScreen.dart';
import 'package:piassa_application/screens/homeScreen/home.dart';
import 'package:piassa_application/screens/itsAMatchScreen/itsAMatchScreen.dart';
import 'package:piassa_application/screens/lifeStyleScreen/lifeStyleScreen.dart';
import 'package:piassa_application/screens/likesListingScreen/likesListingScreen.dart';
import 'package:piassa_application/screens/matchesListingScreen/matchesListingScreen.dart';
import 'package:piassa_application/screens/moveMakersScreen/moveMakersScreen.dart';
import 'package:piassa_application/screens/myProfileScreen/myProfileScreen.dart';
import 'package:piassa_application/screens/phoneLoginScreen/phoneLoginScreen.dart';
import 'package:piassa_application/screens/preferenceScreen/preferenceScreen.dart';
import 'package:piassa_application/screens/profileInfoScreen/profileInfoScreen.dart';
import 'package:piassa_application/screens/profileScreen/profileScreen.dart';
import 'package:piassa_application/screens/settingsScreen/settingsScreen.dart';
import 'package:piassa_application/screens/signupquestions/signupQuestions.dart';

import './blocs/authBloc/authBloc.dart';
import './blocs/authBloc/authState.dart';
import 'repositories/authRepository.dart';
import './screens/homeScreen/homeScreen.dart';
import './screens/loginScreen/loginScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authBloc/authEvent.dart';
import 'screens/forgotPasswordScreen/forgotPasswordScreen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository userRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: kPrimaryPurple,
        // accentColor: kPrimaryPink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Heebo",
      ),
      home: SplashScreenPage(
          userRepository: userRepository,
        ),
    );
  }
}

class Appp extends StatelessWidget {
  final AuthRepository userRepository;

  Appp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is AuthInitialState) {
          return Container();
        } else if (state is AuthenticatedState) {
          return 
          // ChatScreen(
          //   'Helina','Female / 5km / 44m','I bring a lot of energy to what I do and always have some leftover to get into trouble on the weekends at my fav. local bar. (If you play your cards right, maybe we can meet there.)',chat1Image
          //   // user: state.user,
          //   // userRepository: userRepository,
          // );
          Tabs(
            user: state.user,
            userId: state.user.uid,
            userRepository: userRepository,
          );
        } else if (state is UnauthenticatedState) {
          return LoginPageParent(userRepository: userRepository);
        }
        return Container();
      },
    );
  }
}

class SplashScreenPage extends StatelessWidget {
  final AuthRepository userRepository;

  SplashScreenPage({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: BlocProvider(
          create: (context) =>
              AuthBloc(userRepository: userRepository)..add(AppStartedEvent()),
          child: Appp(userRepository: userRepository)),
      image: new Image.asset("assets/images/piassa-logo-light.png"),
      photoSize: 100.0,
      useLoader: false,
      gradientBackground: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: <Color>[Color(kPrimaryPink), Color(kPrimaryPurple)],
      ),
    );
  }
}
