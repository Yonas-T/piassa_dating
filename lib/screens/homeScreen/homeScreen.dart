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
  User user;
  AuthRepository userRepository;

  HomePageParent({required this.user, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(userRepository: userRepository),
      child: HomePage(user: user, userRepository: userRepository),
    );
  }
}

class HomePage extends StatelessWidget {
  late User user;
  late HomePageBloc homePageBloc;
  late AuthRepository userRepository;

  HomePage({required this.user, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    return WillPopScope(onWillPop: () async => false, child: Home(userId: user.uid,));
  }

  void navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpPageParent(userRepository: userRepository);
    }));
  }
}
