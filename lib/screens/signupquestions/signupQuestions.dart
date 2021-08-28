import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/screens/signupquestions/widgets/secondStepperPageWidget.dart';
import 'package:piassa_application/screens/signupquestions/widgets/stepProgressWidget.dart';

class SignupQuestionsScreen extends StatefulWidget {
  final User user;
  final AuthRepository userRepository;

  const SignupQuestionsScreen({Key? key, required this.user, required this.userRepository}) : super(key: key);

  @override
  _SignupQuestionsScreenState createState() =>
      _SignupQuestionsScreenState();
}

class _SignupQuestionsScreenState
    extends State<SignupQuestionsScreen> {
  TextEditingController jobCntrl = TextEditingController();
  TextEditingController companyCntrl = TextEditingController();
  TextEditingController nameCntrl = TextEditingController();
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController heightCntrl = TextEditingController();
  TextEditingController tellSomethingCntrl = TextEditingController();

  late String _selectedUniversity;

  List<String> _universities = ['Ethiopia', 'US', 'UK'];

  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 100.0;

  Color _activeColor = Color(kDarkGrey);

  Color _inactiveColor = Colors.grey;

  TextStyle _headerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  int _curPage = 1;

  StepProgressWidget _getStepProgress() {
    return StepProgressWidget(
      _curPage,
      _stepProgressViewHeight,
      _stepCircleRadius,
      _activeColor,
      _inactiveColor,
      _headerStyle,
      _stepStyle,
      padding: EdgeInsets.only(
        left: 0.0,
        right: 0.0,
      ),
    );
  }

  @override
  void initState() {
    _selectedUniversity = _universities[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white10,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Color(kDarkGrey)),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text(
      //     'Education & Profession',
      //     style: TextStyle(
      //       fontSize: kNormalFont,
      //       color: Color(kDarkGrey),
      //     ),
      //   ),
      //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check, color: Color(kDarkGrey),))],
      // ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(height: 20.0, child: _getStepProgress()),
            Expanded(
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
                          fillColor: Color(kDarkGrey).withOpacity(0.02),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
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
                          fillColor: Color(kDarkGrey).withOpacity(0.02),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          hintText: "email",
                          hintStyle: TextStyle(
                              color: Color(kDarkGrey), fontSize: kNormalFont),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 32),
                      Container(
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Color(kDarkGrey), width: 1),
                              borderRadius: BorderRadius.circular(16)),
                          color: Color(kDarkGrey).withOpacity(0.02),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: ExpansionTile(
                              title: Text(
                                _selectedUniversity,
                                style: TextStyle(
                                    fontSize: kNormalFont,
                                    color: Color(kDarkGrey)),
                              ),
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
                                              color: Color(kDarkGrey)),
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      TextField(
                        controller: jobCntrl,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(kDarkGrey).withOpacity(0.02),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          hintText: "Job",
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
                          fillColor: Color(kDarkGrey).withOpacity(0.02),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          hintText: "Company",
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
                          fillColor: Color(kDarkGrey).withOpacity(0.02),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color(kDarkGrey), width: 1)),
                          hintText: "Tell us something about you",
                          hintStyle: TextStyle(
                              color: Color(kDarkGrey), fontSize: kNormalFont),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(kDarkGrey), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(16)),

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
                                    borderRadius: BorderRadius.circular(16))),
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                  fontSize: kNormalFont,
                                  color: Color(kDarkGrey)),
                            )),
                      ),
                      SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                  Container(
                    child: SecondStepperPageWidget(user: widget.user, userRepository: widget.userRepository,),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
