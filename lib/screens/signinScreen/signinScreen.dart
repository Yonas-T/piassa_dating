import '../../blocs/signinBloc/signinBloc.dart';
import '../../blocs/signinBloc/signinEvent.dart';
import '../../blocs/signinBloc/signinState.dart';
import '../../repositories/userRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../homeScreen/homeScreen.dart';
import '../loginScreen/loginScreen.dart';
import 'package:meta/meta.dart';

class SignUpPageParent extends StatelessWidget {
  UserRepository userRepository;

  SignUpPageParent({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninBloc(userRepository: userRepository),
      child: SignUpPage(userRepository: userRepository),
    );
  }
}

class SignUpPage extends StatelessWidget {
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController passCntrlr = TextEditingController();

  late String authResult;
  late SigninBloc userSigninBloc;
  late UserRepository userRepository;

  SignUpPage({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    userSigninBloc = BlocProvider.of<SigninBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: BlocListener<SigninBloc, SigninState>(
                  listener: (context, state) {
                    if (state is SigninSuccessful) {
                      navigateToHomeScreen(context, state.user);
                    }
                  },
                  child: BlocBuilder<SigninBloc, SigninState>(
                    builder: (context, state) {
                      if (state is SigninInitial) {
                        return buildInitialUi();
                      } else if (state is SigninLoading) {
                        return buildLoadingUi();
                      } else if (state is SigninFailure) {
                        return buildFailureUi(state.message);
                      } 
                      // else if (state is SigninSuccessful) {
                      //   emailCntrl.text = "";
                      //   passCntrlr.text = "";
                      //   return Container();
                      // }
                      return Container();
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  controller: emailCntrl,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: "E-mail",
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  controller: passCntrlr,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Password",
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: ElevatedButton(
                      child: Text("Sign Up"),
                      onPressed: () {
                        userSigninBloc.add(SigninButtonPressed(
                            email: emailCntrl.text, password: passCntrlr.text));
                      },
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text("Login Now"),
                      onPressed: () {
                        navigateToLoginPage(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInitialUi() {
    return Text("Waiting For Authentication");
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void navigateToHomeScreen(BuildContext context, User user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePageParent(user: user, userRepository: userRepository);
    }));
  }

  Widget buildFailureUi(String message) {
    return Text(
      message,
      style: TextStyle(color: Colors.red),
    );
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPageParent(userRepository: userRepository);
    }));
  }
}
