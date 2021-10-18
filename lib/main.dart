import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileBloc.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileEvent.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/tabs.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
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
import 'package:piassa_application/screens/signupquestions/widgets/secondStepperPageWidget.dart';
import 'package:piassa_application/utils/sheredPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  HttpOverrides.global = MyHttpOverrides();
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

class Appp extends StatefulWidget {
  final AuthRepository userRepository;

  Appp({required this.userRepository});

  @override
  _ApppState createState() => _ApppState();
}

class _ApppState extends State<Appp> {
  String? value = '';
  User? user;
  bool isLoading = false;
  late User userTemp;
  bool isSignedIn = false;
  BasicProfileRepository basicProfileRepository = BasicProfileRepository();
  MatchPreferenceRepository matchPreferenceRepository =
      MatchPreferenceRepository();
  late BasicProfileBloc basicProfileBloc;
  Peoples? profileData;

  checkValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('signupValue') != null) {
      setState(() {
        value = prefs.getString('signupValue');
      });
    }
  }

  authval() async {
    bool isSignedInAll = await widget.userRepository.isSignedIn();
    var userTempAll = await widget.userRepository.getCurrentUser();
    setState(() {
      isSignedIn = isSignedInAll;
      if (userTempAll != null) {
        userTemp = userTempAll;
      }
    });
    if (isSignedIn) {
      profileValue();
    }
    print('===========$isSignedIn');
  }

  profileValue() async {
    profileData = await basicProfileRepository.fetchBasicProfile();
    print('PROFILEdATA: $profileData');
  }

  @override
  void initState() {
    // basicProfileBloc = BasicProfileBloc(
    //     basicProfileRepository: basicProfileRepository,
    //     matchPreferenceRepository: matchPreferenceRepository);
    // basicProfileBloc.add(LoadBasicProfileEvent());

    checkValue();
    authval();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print(state);
        if (state is AuthInitialState) {
          return Container();
        } else if (isSignedIn) {
          return value == 'HasAllValue'
              ? Tabs(
                  user: userTemp,
                  // userId: state.user.uid,
                  userRepository: widget.userRepository,
                )
              : value == null && profileData == null
                  ? SignupQuestionsScreen(
                      toEdit: false,
                      matchPreferenceRepository: matchPreferenceRepository,
                      basicProfileRepository: basicProfileRepository,
                      user: userTemp)
                  : value == 'HasImageValue' 
                      ? AllDoneScreen(
                          user: user, userRepository: widget.userRepository)
                      : value == 'HasPreferenceValue'
                          ? GallaryScreen(
                              basicProfileRepository: basicProfileRepository)
                          : value == 'HasBasicProfileValue'
                              ? SecondStepperPageWidget(
                                  toEdit: false,
                                  basicProfileRepository:
                                      basicProfileRepository,
                                  user: userTemp)
                              : SignupQuestionsScreen(
                                toEdit: false,
                                  matchPreferenceRepository:
                                      matchPreferenceRepository,
                                  basicProfileRepository:
                                      basicProfileRepository,
                                  user: userTemp);
        } else if (state is UnauthenticatedState) {
          return LoginPageParent(userRepository: widget.userRepository);
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
      image: Image.asset("assets/images/piassa-logo-light.png"),
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
