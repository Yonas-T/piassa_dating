import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileBloc.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/tabs.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
import 'package:piassa_application/screens/allDoneScreen/allDoneScreen.dart';
import 'package:piassa_application/screens/gallaryScreen/gallaryScreen.dart';
import 'package:piassa_application/screens/signupquestions/signupQuestions.dart';
import 'package:piassa_application/screens/signupquestions/widgets/secondStepperPageWidget.dart';
import 'package:piassa_application/services/basicProfileApiProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import './blocs/authBloc/authBloc.dart';
import './blocs/authBloc/authState.dart';
import 'repositories/authRepository.dart';
import './screens/loginScreen/loginScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authBloc/authEvent.dart';

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
  late User user;

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
        // user: user,
        userRepository: userRepository,
      ),
    );
  }
}

class Appp extends StatefulWidget {
  final AuthRepository userRepository;
  // final User user;

  Appp({
    required this.userRepository,
  });

  @override
  _ApppState createState() => _ApppState();
}

class _ApppState extends State<Appp> {
  String? value = '';
  bool isLoading = false;
  late User userTemp;
  bool isSignedIn = false;
  BasicProfileRepository basicProfileRepository = BasicProfileRepository();
  MatchPreferenceRepository matchPreferenceRepository =
      MatchPreferenceRepository();
  late BasicProfileBloc basicProfileBloc;
  UserMatch? profileData;

  checkValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('signupValue') != null) {
      setState(() {
        value = prefs.getString('signupValue');
      });
    }
  }

  Future authval() async {
    bool isSignedInAll = await widget.userRepository.isSignedIn();
    print('SIGNALLLL ' + isSignedInAll.toString());

    if (isSignedInAll) {
      var userTempAll = await widget.userRepository.getCurrentUser();
      print('TEMPALLLL ' + userTempAll.email!);
      setState(() {
        isSignedIn = isSignedInAll;
        if (userTempAll != null) {
          userTemp = userTempAll;
          log('TEMPO USER: $userTemp');
        }
      });

      profileData = await basicProfileRepository.fetchEntireProfile();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (profileData!.userImages.isNotEmpty) {
        log('NNNOOOTTT NULLLLL');
        prefs.setString('profileVal', 'true');
      }
    }
    print('======isSignedin=====$isSignedIn');
  }

  @override
  void initState() {
    // basicProfileBloc = BasicProfileBloc(
    //     basicProfileRepository: basicProfileRepository,
    //     matchPreferenceRepository: matchPreferenceRepository);
    // basicProfileBloc.add(LoadBasicProfileEvent());
    setState(() {
      isLoading = true;
    });
    checkValue();
    authval().whenComplete(() {
      setState(() {
        isLoading = false;
        print('========isloading=========$isLoading');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: Center(child: Container()))
        : BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              print(state);
              // log(profileData!.userImages.isNotEmpty.toString());
              log(value!);
              if (state is AuthInitialState) {
                return Container();
              } else if (isSignedIn) {
                return value == 'HasAllValue' ||
                        profileData!.userImages.isNotEmpty
                    ? Tabs(
                        user: userTemp,
                        // userId: state.user.uid,
                        userRepository: widget.userRepository,
                      )
                    : value == null && profileData == null
                        ? SignupQuestionsScreen(
                            toEdit: false,
                            matchPreferenceRepository:
                                matchPreferenceRepository,
                            basicProfileRepository: basicProfileRepository,
                            user: userTemp)
                        : value == 'HasImageValue'
                            ? AllDoneScreen(
                                user: userTemp,
                                userRepository: widget.userRepository)
                            : value == 'HasPreferenceValue' ||
                                    profileData!.haveMatchPreference
                                ? GallaryScreen(
                                    toEdit: false,
                                    user: userTemp,
                                    basicProfileRepository:
                                        basicProfileRepository)
                                : value == 'HasBasicProfileValue' ||
                                        profileData!.fullName.isNotEmpty
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

class SplashScreenPage extends StatefulWidget {
  final AuthRepository userRepository;
  // final User user;

  SplashScreenPage({
    required this.userRepository,
  });

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: BlocProvider(
          create: (context) => AuthBloc(userRepository: widget.userRepository)
            ..add(AppStartedEvent()),
          child: Appp(
            // user: widget.user,
            userRepository: widget.userRepository,
          )),
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
