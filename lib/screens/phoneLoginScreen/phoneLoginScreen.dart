import 'package:piassa_application/blocs/phoneAuthBloc/phoneAuthBloc.dart';
import 'package:piassa_application/blocs/phoneAuthBloc/phoneAuthEvent.dart';
import 'package:piassa_application/blocs/phoneAuthBloc/phoneAuthState.dart';
import 'package:piassa_application/blocs/phoneLoginBloc/phoneLoginBloc.dart';
import 'package:piassa_application/blocs/phoneLoginBloc/phoneLoginEvent.dart';
import 'package:piassa_application/blocs/phoneLoginBloc/phoneLoginState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/utils/editTextUtils.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

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

class PhoneLoginParent extends StatelessWidget {
  AuthRepository userRepository;

  PhoneLoginParent({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneLoginBloc(userRepository: userRepository),
      child: PhoneLoginPage(userRepository: userRepository),
    );
  }
}

class PhoneLoginPage extends StatefulWidget {
  late AuthRepository userRepository;

  PhoneLoginPage({required this.userRepository});

  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  TextEditingController phoneCntrl = TextEditingController();

  late String authResult;

  late PhoneLoginBloc phoneLoginBloc;
  late PhoneLoginBloc _phoneLoginBloc;

  @override
  void initState() {
    _phoneLoginBloc = BlocProvider.of<PhoneLoginBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    phoneLoginBloc = BlocProvider.of<PhoneLoginBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[Color(kPrimaryPink), Color(kPrimaryPurple)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: BlocListener<PhoneLoginBloc, PhoneLoginState>(
                  bloc: _phoneLoginBloc,
                  listener: (context, state) {
                    if (state is PhoneLoginCompleteState) {
                      navigateToHomeScreen(context, state.user);
                    }
                  },
                  child: BlocBuilder<PhoneLoginBloc, PhoneLoginState>(
                    builder: (context, state) {
                      return getViewAsPerState(state);
                    },
                  ),
                ),
              ),
              // getViewAsPerState(state),
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
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(kPrimaryPurple))),
    );
  }

  Widget getViewAsPerState(PhoneLoginState state) {
    print(state);
    if (state is Unauthenticated) {
      return NumberInput();
    } else if (state is OtpSentState || state is OtpExceptionState) {
      return OtpInput();
    } else if (state is PhoneLoadingState) {
      return LoadingIndicator();
    } else if (state is PhoneLoginCompleteState) {
      BlocProvider.of<PhoneAuthenticationBloc>(context)
          .add(PhoneLoggedIn(token: state.getUser().uid));
    } else {
      return NumberInput();
    }
    return Container();
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

  // void navigateToLoginPage(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return LoginPageParent(userRepository: widget.userRepository);
  //   }));
  // }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(kPrimaryPurple))),
      );
}

final _formKey = GlobalKey<FormState>();

class NumberInput extends StatelessWidget {
  TextEditingController _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 16, bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Text(
              'Login',
              style: TextStyle(fontSize: kExtraLargeFont, color: Color(kWhite)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Text(
              'Via Phone number',
              style: TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
            ),
          ),
          SizedBox(height: 100),
          Form(
            key: _formKey,
            child: EditTextUtils().getCustomEditTextArea(
                labelValue: "Enter phone number",
                hintValue: "911010100",
                controller: _phoneTextController,
                keyboardType: TextInputType.number,
                // icon: Icons.phone,
                validator: (value) {
                  return validateMobile(value!);
                }),
          ),
          SizedBox(height: 16),
          Container(
            width: MediaQuery.of(context).size.width,
            height: kButtonHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(kWhite),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Text("Send",
                  style: TextStyle(
                      fontSize: kButtonFont, color: Color(kPrimaryPink))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<PhoneLoginBloc>(context).add(
                      SendOtpEvent("+251" + _phoneTextController.value.text));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  String? validateMobile(String value) {
    if (value.length != 9)
      return 'Mobile Number must be of 9 digit';
    else
      return null;
  }
}

class OtpInput extends StatelessWidget {
  TextEditingController pinEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConstrainedBox(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 48, bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            PinCodeTextField(
              autofocus: true,
              controller: pinEditingController,
              hideCharacter: true,
              highlight: true,
              highlightColor: Color(kDarkGrey),
              defaultBorderColor: Color(kWhite),
              hasTextBorderColor: Color(kWhite),
              highlightPinBoxColor: Color(klightPink),
              maxLength: 6,
              onDone: (String pin) {
                BlocProvider.of<PhoneLoginBloc>(context)
                    .add(VerifyOtpEvent(pin));
              },
              pinBoxWidth: 50,
              pinBoxHeight: 64,
              hasUnderline: true,
              wrapAlignment: WrapAlignment.spaceAround,
              pinBoxDecoration:
                  ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinTextStyle: TextStyle(fontSize: 22.0),
              pinTextAnimatedSwitcherTransition:
                  ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
//                    highlightAnimation: true,
              highlightAnimationBeginColor: Colors.black,
              highlightAnimationEndColor: Colors.white12,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              height: kButtonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(kWhite),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                child: Text("Send",
                    style: TextStyle(
                        fontSize: kButtonFont, color: Color(kPrimaryPink))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<PhoneLoginBloc>(context)
                        .add(AppStartEvent());
                  }
                },
              ),
            )
          ],
        ),
      ),
      constraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }
}
