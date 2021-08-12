import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailCntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Text(
              "Forgot Password",
              style: TextStyle(fontSize: kHeadingFont, color: Color(kWhite)),
            ),
            // SizedBox(
            //   height: 32,
            // ),
            Column(
              children: <Widget>[
                Text(
                  "Please fill in your email address",
                  style: TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
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
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "E-mail",
                      hintStyle: TextStyle(
                          color: Color(kWhite), fontSize: kNormalFont),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: kButtonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(kWhite),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: Text("Continue",
                    style: TextStyle(
                        fontSize: kNormalFont, color: Color(kPrimaryPink))),
                onPressed: () {
                  // userSigninBloc.add(SigninButtonPressed(
                  //     email: emailCntrl.text,
                  //     password: passCntrlr.text));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
