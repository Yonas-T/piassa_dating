import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/blocs/authBloc/authBloc.dart';
import 'package:piassa_application/blocs/authBloc/authEvent.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/tabs.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
import 'package:piassa_application/screens/forgotPasswordScreen/forgotPasswordScreen.dart';
import 'package:piassa_application/screens/gallaryScreen/gallaryScreen.dart';
import 'package:piassa_application/screens/phoneLoginScreen/phoneLoginScreen.dart';
import 'package:piassa_application/screens/signupquestions/signupQuestions.dart';
import 'package:piassa_application/screens/signupquestions/widgets/secondStepperPageWidget.dart';
import 'package:piassa_application/utils/helper.dart';

import '../../blocs/loginBloc/loginBloc.dart';
import '../../blocs/loginBloc/loginEvent.dart';
import '../../blocs/loginBloc/loginState.dart';
import '../../repositories/authRepository.dart';
import '../homeScreen/homeScreen.dart';
import '../signUpScreen/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageParent extends StatelessWidget {
  final AuthRepository userRepository;

  LoginPageParent({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(userRepository: userRepository),
        ),
        BlocProvider(
          create: (context) => AuthBloc(userRepository: userRepository),
        )
      ],
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCntrlr = TextEditingController();
  TextEditingController passCntrlr = TextEditingController();
  FocusNode passfocus = FocusNode();
  bool isLoading = false;
  AuthRepository userRepository = AuthRepository();
  late LoginBloc loginBloc;
  late AuthBloc userBloc;

  BasicProfileRepository basicProfileRepository = BasicProfileRepository();
  MatchPreferenceRepository matchPreferenceRepository =
      MatchPreferenceRepository();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginBloc = LoginBloc(userRepository: userRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    userBloc = BlocProvider.of<AuthBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[Color(kPrimaryPink), Color(kPrimaryPurple)],
            ),
          ),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.fromLTRB(5, 48, 5, 5),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      navigateToSignupQuestionsScreen(context, state.user);
                    }

                    if (state is LoginFailState) {
                      Text('Can\'t Login, Try Again');
                    }
                  },
                  child: SingleChildScrollView(
                    dragStartBehavior: DragStartBehavior.down,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: kExtraLargeFont,
                                color: Color(kWhite)),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: TextFormField(
                                controller: emailCntrlr,
                                style: TextStyle(color: Color(kWhite)),
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Color(kWhite).withOpacity(0.4),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  hintText: "E-mail",
                                  hintStyle: TextStyle(
                                      color: Color(kWhite),
                                      fontSize: kNormalFont),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (text) => validateEmail(text),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: TextFormField(
                                controller: passCntrlr,
                                style: TextStyle(color: Color(kWhite)),
                                obscureText: true,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Color(kWhite).withOpacity(0.4),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Color(kWhite),
                                      fontSize: kNormalFont),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (text) => validatePassword(text),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is LoginInitialState) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: kButtonHeight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(kWhite),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4))),
                                      child: Text("Login",
                                          style: TextStyle(
                                              fontSize: kNormalFont,
                                              color: Color(kPrimaryPink))),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          loginBloc.add(
                                            LoginButtonPressed(
                                              email: emailCntrlr.text,
                                              password: passCntrlr.text,
                                            ),
                                          );
                                          FocusScope.of(context)
                                              .requestFocus(passfocus);
                                        }
                                      },
                                    ),
                                  );
                                }
                                if (state is LoginLoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(kWhite)),
                                    ),
                                  );
                                }
                                if (state is LoginFailState) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: kButtonHeight,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Color(kWhite),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4))),
                                      child: Text(state.message + ', Retry',
                                          style: TextStyle(
                                              fontSize: kNormalFont,
                                              color: Color(kWhite))),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          loginBloc.add(
                                            LoginButtonPressed(
                                              email: emailCntrlr.text,
                                              password: passCntrlr.text,
                                            ),
                                          );
                                          FocusScope.of(context)
                                              .requestFocus(passfocus);
                                        }
                                      },
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ]),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: kButtonHeight,
                          child: TextButton(
                            child: Text("Forgot Password?",
                                style: TextStyle(
                                    fontSize: kNormalFont,
                                    color: Color(kWhite))),
                            onPressed: () {
                              navigateToForgotPasswordScreen(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: kButtonHeight,
                          child: TextButton(
                            child: Text("Don't have an account?",
                                style: TextStyle(
                                    fontSize: kNormalFont,
                                    color: Color(kWhite))),
                            onPressed: () {
                              navigateToSignUpScreen(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width * .35,
                                color: Color(kWhite)),
                            Text(
                              'Or',
                              style: TextStyle(
                                  fontSize: kNormalFont, color: Color(kWhite)),
                            ),
                            Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width * .4,
                                color: Color(kWhite))
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       navigateToPhoneLoginScreen(context);
                        //     },
                        //     child: Text("Login with Phone")),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: kButtonHeight,
                          child: ElevatedButton.icon(
                            label: Text(
                              'Login with Facebook',
                              style: TextStyle(
                                fontSize: kNormalFont,
                                color: Color(kWhite),
                              ),
                            ),
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Icon(
                                FontAwesomeIcons.facebook,
                                color: Color(kWhite),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(kFacebookColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                side: BorderSide(
                                  color: Color(kFacebookColor),
                                ),
                              ),
                            ),
                            onPressed: () async => loginWithFacebook(context),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: kButtonHeight,
                          child: ElevatedButton.icon(
                            label: Text(
                              'Login with Google',
                              style: TextStyle(
                                fontSize: kNormalFont,
                                color: Color(kWhite),
                              ),
                            ),
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Icon(
                                FontAwesomeIcons.google,
                                color: Color(kWhite),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(kGoogleColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                side: BorderSide(
                                  color: Color(kGoogleColor),
                                ),
                              ),
                            ),
                            onPressed: () async => loginWithGoogle(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginWithGoogle(BuildContext context) async {
    try {
      await showProgress(context, 'Logging in, Please wait...', false);
      dynamic result = await userRepository.signInwithGoogle();
      print('=' * 20);
      print(result);
      await hideProgress();
      if (result != null && result is User) {
        // print('=' * 20);
        // print(result);
        // MyAppState.currentUser = result;
        // userBloc.add(AppStartedEvent());
        navigateToSignupQuestionsScreen(context, result);
        // pushAndRemoveUntil(context, HomeScreen(user: result), false);
      } else if (result != null && result is String) {
        showAlertDialog(context, 'Error', result);
      } else {
        showAlertDialog(context, 'Error', 'Couldn\'t login with google.');
      }
    } catch (e, s) {
      await hideProgress();
      print('_LoginScreen.loginWithGoogle $e $s');
      showAlertDialog(context, 'Error', 'Couldn\'t login with google.');
    }
  }

  loginWithFacebook(BuildContext context) async {
    try {
      await showProgress(context, 'Logging in, Please wait...', false);
      dynamic result = await userRepository.loginWithFacebook();
      await hideProgress();
      if (result != null && result is User) {
        // MyAppState.currentUser = result;

        navigateToSignupQuestionsScreen(context, result);
        // pushAndRemoveUntil(context, HomeScreen(user: result), false);
      } else if (result != null && result is String) {
        showAlertDialog(context, 'Error', result);
      } else {
        showAlertDialog(context, 'Error', 'Couldn\'t login with facebook.');
      }
    } catch (e, s) {
      await hideProgress();
      print('_LoginScreen.loginWithFacebook $e $s');
      showAlertDialog(context, 'Error', 'Couldn\'t login with facebook.');
    }
  }

  Widget buildFailureUi(String message) {
    print(message);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Failed, Retry $message",
            style: TextStyle(color: Color(kWhite)),
          ),
        ),
      ],
    );
  }

  void navigateToSignupQuestionsScreen(BuildContext context, User user) async {
    var profileData = await basicProfileRepository.fetchEntireProfile();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return profileData.fullName.isEmpty
          ? SignupQuestionsScreen(
              toEdit: false,
              user: user,
              basicProfileRepository: basicProfileRepository,
              matchPreferenceRepository: matchPreferenceRepository,
            )
          : !profileData.haveMatchPreference
              ? SecondStepperPageWidget(
                  toEdit: false,
                  basicProfileRepository: basicProfileRepository,
                  user: user)
              : profileData.userImages.isEmpty
                  ? GallaryScreen(
                      basicProfileRepository: basicProfileRepository,
                      toEdit: false,
                      user: user)
                  : profileData.userImages.isNotEmpty
                      ? Tabs(user: user, userRepository: userRepository)
                      : Tabs(user: user, userRepository: userRepository);

      // Tabs(user: user, userRepository: userRepository);
    }));
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpPageParent(userRepository: userRepository);
    }));
  }

  void navigateToPhoneLoginScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PhoneLoginParent(userRepository: userRepository);
    }));
  }

  void navigateToForgotPasswordScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ForgotPasswordScreen();
    }));
  }
}
