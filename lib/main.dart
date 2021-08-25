import 'package:firebase_core/firebase_core.dart';
import 'package:piassa_application/generalWidgets/tabs.dart';
import 'package:piassa_application/screens/educationAndProfessionScreen/educationAndProfessionScreen.dart';
import 'package:piassa_application/screens/homeScreen/home.dart';
import 'package:piassa_application/screens/likesListingScreen/likesListingScreen.dart';
import 'package:piassa_application/screens/profileInfoScreen/profileInfoScreen.dart';
import 'package:piassa_application/screens/profileScreen/profileScreen.dart';
import 'package:piassa_application/screens/settingsScreen/settingsScreen.dart';

import './blocs/authBloc/authBloc.dart';
import './blocs/authBloc/authState.dart';
import 'repositories/authRepository.dart';
import './screens/homeScreen/homeScreen.dart';
import './screens/loginScreen/loginScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authBloc/authEvent.dart';
import 'screens/forgotPasswordScreen/forgotPasswordScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository userRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: 
      BlocProvider(
        create: (context) =>
            AuthBloc(userRepository: userRepository)..add(AppStartedEvent()),
        child: 
        // LikesListingScreen()
        Appp(
          userRepository: userRepository,
        ),
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
          return Tabs(
            user: state.user,
            userId: state.user.uid, userRepository: userRepository,
          );
        } else if (state is UnauthenticatedState) {
          return LoginPageParent(userRepository: userRepository);
        }
        return Container();
      },
    );
  }
}
