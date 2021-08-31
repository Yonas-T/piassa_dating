import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/screens/signupquestions/widgets/secondStepperPageWidget.dart';
import 'package:piassa_application/screens/signupquestions/widgets/stepProgressWidget.dart';

class SignupQuestionsScreen extends StatefulWidget {
  final User user;
  final AuthRepository userRepository;

  const SignupQuestionsScreen(
      {Key? key, required this.user, required this.userRepository})
      : super(key: key);

  @override
  _SignupQuestionsScreenState createState() => _SignupQuestionsScreenState();
}

class _SignupQuestionsScreenState extends State<SignupQuestionsScreen> {
  TextEditingController jobCntrl = TextEditingController();
  TextEditingController companyCntrl = TextEditingController();
  TextEditingController nameCntrl = TextEditingController();
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController heightCntrl = TextEditingController();
  TextEditingController tellSomethingCntrl = TextEditingController();

  late String _selectedCountry;

  List<String> _universities = ['Ethiopia', 'US', 'UK'];

  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 100.0;

  Color _activeColor = Color(klightPink);

  Color _inactiveColor = Color(kWhite);

  TextStyle _headerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  int _curPage = 1;

  StepProgressWidget _getStepProgress() {
    return StepProgressWidget(curStep: _curPage,);
  }

  @override
  void initState() {
    _selectedCountry = 'Nationality';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kWhite),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 16.0),
          child: AppBarWidget(
            actionIcon: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(klightPink), shape: BoxShape.circle),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.check,
                      color: Color(kWhite),
                      size: 14,
                    ))),
            colorVal: Color(kWhite),
            leadingIcon: Container(),
            title: Text('Preference',
                style:
                    TextStyle(fontSize: kTitleBoldFont, color: Color(kBlack))),
          ),
        ),
      ),
      body: Container(
        // padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(height: 15.0, child: _getStepProgress()),
            SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top:8.0, right: 16, bottom: 8),
                child: PageView(
                  onPageChanged: (i) {
                    setState(() {
                      _curPage = i + 1;
                    });
                  },
                  children: [
                    ListView(
                      children: [
                        TextField(
                          controller: nameCntrl,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(kWhite).withOpacity(0.5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            hintText: "Full name",
                            hintStyle: TextStyle(
                                color: Color(kDarkGrey), fontSize: kNormalFont),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: emailCntrl,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(kWhite).withOpacity(0.5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            hintText: "email",
                            hintStyle: TextStyle(
                                color: Color(kDarkGrey), fontSize: kNormalFont),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 32),
                        Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Color(kLightGrey),
                            width: 1
                          )
                          ),
                          child: ExpansionTile(
                            title: Text(
                              _selectedCountry,
                              style: TextStyle(
                                  fontSize: kNormalFont,
                                  color: Color(kBlack)),
                            ),
                            iconColor: Color(klightPink),
                            collapsedIconColor: Color(klightPink),
                            children: <Widget>[
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: _universities.length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 8, 8, 8),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _universities[i],
                                        style: TextStyle(
                                            fontSize: kNormalFont,
                                            color: Color(kBlack)),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        TextField(
                          controller: jobCntrl,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(kWhite).withOpacity(0.5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            hintText: "Birth day",
                            hintStyle: TextStyle(
                                color: Color(kDarkGrey), fontSize: kNormalFont),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 32),
                        TextField(
                          controller: companyCntrl,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(kWhite).withOpacity(0.5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            hintText: "Height",
                            hintStyle: TextStyle(
                                color: Color(kDarkGrey), fontSize: kNormalFont),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: companyCntrl,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(kWhite).withOpacity(0.5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Color(kLightGrey), width: 1)),
                            hintText: "Tell us something about you",
                            hintStyle: TextStyle(
                                color: Color(kDarkGrey), fontSize: kNormalFont),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(kLightGrey), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(4)),

                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Color(kDarkGrey).withOpacity(0.5),
                            //       offset: Offset(0.0, 5.0),
                            //       blurRadius: 20.0)
                            // ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: kButtonHeight,
                          child: TextButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Color(kWhite),
                                  padding: EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                              child: Text(
                                'Proceed',
                                style: TextStyle(
                                    fontSize: kNormalFont, color: Color(kBlack)),
                              )),
                        ),
                        SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                    Container(
                      child: SecondStepperPageWidget(
                        user: widget.user,
                        userRepository: widget.userRepository,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
