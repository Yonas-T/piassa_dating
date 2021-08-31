import 'package:piassa_application/constants/constants.dart';

import '../../blocs/signinBloc/signinBloc.dart';
import '../../blocs/signinBloc/signinEvent.dart';
import '../../blocs/signinBloc/signinState.dart';
import '../../repositories/authRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../homeScreen/homeScreen.dart';
import '../loginScreen/loginScreen.dart';
import 'package:meta/meta.dart';

class SignUpPageParent extends StatelessWidget {
  AuthRepository userRepository;

  SignUpPageParent({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninBloc(userRepository: userRepository),
      child: SignUpPage(userRepository: userRepository),
    );
  }
}

class SignUpPage extends StatefulWidget {
  late AuthRepository userRepository;

  SignUpPage({required this.userRepository});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController phoneCntrl = TextEditingController();
  TextEditingController nameCntrl = TextEditingController();

  TextEditingController passCntrlr = TextEditingController();

  late String authResult;

  late SigninBloc userSigninBloc;

  late String _selectedCountry;

  List<String> _countries = ['Ethiopia', 'USA', 'UK'];

  @override
  void initState() {
    _selectedCountry = _countries[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userSigninBloc = BlocProvider.of<SigninBloc>(context);
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 32,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
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

                      return Container();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextField(
                        controller: nameCntrl,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(kWhite).withOpacity(0.4),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Full name",
                          hintStyle: TextStyle(
                              color: Color(kWhite), fontSize: kNormalFont),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextField(
                        controller: emailCntrl,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(kWhite).withOpacity(0.4),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "E-mail",
                          hintStyle: TextStyle(
                              color: Color(kWhite), fontSize: kNormalFont),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Container(
                        child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: Color(kWhite)),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: Color(kWhite).withOpacity(0.4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: ExpansionTile(
                            // backgroundColor: Color(kWhite).withOpacity(0.4),
                            title: Text(
                              _selectedCountry,
                              style: TextStyle(
                                  fontSize: kNormalFont, color: Color(kWhite)),
                            ),
                            children: <Widget>[
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: _countries.length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _countries[i],
                                        style: TextStyle(
                                            fontSize: kNormalFont,
                                            color: Color(kWhite)),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    )),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextField(
                        controller: phoneCntrl,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(kWhite).withOpacity(0.4),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Phone number",
                          hintStyle: TextStyle(
                              color: Color(kWhite), fontSize: kNormalFont),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextField(
                        controller: passCntrlr,
                        obscureText: true,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(kWhite).withOpacity(0.4),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color(kWhite), fontSize: kNormalFont),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: kButtonHeight,
                      child: TextButton(
                        child: Text("Login",
                            style: TextStyle(
                                fontSize: kNormalFont, color: Color(kWhite))),
                        onPressed: () {
                          navigateToLoginPage(context);
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: kButtonHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(kWhite),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: Text("Register",
                            style: TextStyle(
                                fontSize: kNormalFont,
                                color: Color(kPrimaryPink))),
                        onPressed: () {
                          userSigninBloc.add(SigninButtonPressed(
                              email: emailCntrl.text,
                              password: passCntrlr.text));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInitialUi() {
    return Text(
      "Register",
      style: TextStyle(fontSize: kHeadingFont, color: Color(kWhite)),
    );
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(kPrimaryPurple))
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context, User user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePageParent(user: user, userRepository: widget.userRepository);
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
      return LoginPageParent(userRepository: widget.userRepository);
    }));
  }
}
