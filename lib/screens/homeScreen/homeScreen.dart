import 'package:piassa_application/blocs/authBloc/authBloc.dart';
import 'package:piassa_application/models/peoples.dart';

import '../../blocs/homePageBloc/homePageBloc.dart';
import '../../blocs/homePageBloc/homePageEvent.dart';
import '../../blocs/homePageBloc/homePageState.dart';
import '../../repositories/authRepository.dart';
import '../signUpScreen/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class HomePageParent extends StatelessWidget {
  // Peoples user;
  AuthRepository userRepository;

  HomePageParent({
    // required this.user, 
    required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(userRepository: userRepository),
      child: HomePage(
        // user: user, 
        userRepository: userRepository),
    );
  }
}

class HomePage extends StatelessWidget {
  // late Peoples user;
  late AuthBloc authBloc;
  late AuthRepository userRepository;

  HomePage({
    // required this.user, 
    required this.userRepository});

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);
    return WillPopScope(onWillPop: () async => false, child: Home(
      // userId: user.uid,
      ));
  }

  void navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpPageParent(userRepository: userRepository);
    }));
  }
}
