import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileBloc.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileEvent.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
import 'package:piassa_application/screens/gallaryScreen/gallaryScreen.dart';
import 'package:piassa_application/screens/signupquestions/widgets/secondStepperPageWidget.dart';
import 'package:piassa_application/screens/signupquestions/widgets/stepProgressWidget.dart';
import 'package:piassa_application/services/basicProfileApiProvider.dart';
import 'package:piassa_application/utils/helper.dart';
import 'package:piassa_application/utils/sheredPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupQuestionsScreen extends StatelessWidget {
  bool toEdit;
  final BasicProfileRepository basicProfileRepository;
  final MatchPreferenceRepository matchPreferenceRepository;
  final User user;
  SignupQuestionsScreen(
      {required this.matchPreferenceRepository,
      required this.basicProfileRepository,
      required this.user,
      required this.toEdit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BasicProfileBloc(
          basicProfileRepository: basicProfileRepository,
          matchPreferenceRepository: matchPreferenceRepository),
      child: SignupQuestionsScreenChild(
        toEditChild: toEdit,
        basicProfileRepository: basicProfileRepository,
        user: user,
      ),
    );
  }
}

class SignupQuestionsScreenChild extends StatefulWidget {
  final bool toEditChild;
  final User user;
  final BasicProfileRepository basicProfileRepository;

  const SignupQuestionsScreenChild(
      {Key? key,
      required this.user,
      required this.basicProfileRepository,
      required this.toEditChild})
      : super(key: key);

  @override
  _SignupQuestionsScreenChildState createState() =>
      _SignupQuestionsScreenChildState();
}

class _SignupQuestionsScreenChildState
    extends State<SignupQuestionsScreenChild> {
  TextEditingController nameCntrl = TextEditingController();
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController heightCntrl = TextEditingController();
  TextEditingController headlineCntrl = TextEditingController();
  TextEditingController dateCntrl = TextEditingController();

  late String _selectedCountry;
  late String _selectedGender;
  late int pageViewIndex;
  late String emailData;
  FirebaseAuth auth = FirebaseAuth.instance;
  BasicProfileRepository basicProfileRepository = BasicProfileRepository();
  

  Peoples basicProfileData = Peoples(
      userName: '',
      fullName: '',
      gender: '',
      email: '',
      height: 0.0,
      birthDay: '',
      nationality: '',
      headline: '',
      longitude: 0.0,
      latitude: 0.0);
  FocusNode passfocus = new FocusNode();
  bool isLoading = false;
  List<String> _countries = ['Ethiopia', 'US', 'UK'];
  List<String> _gender = ['Male', 'Female'];
  List<Widget> pageViewList = [];
  Peoples? _profileData;

  StepProgressWidget _getStepProgress() {
    return StepProgressWidget(
      curStep: 1,
    );
  }

  // changePageView(i) {
  //   setState(() {
  //     _curPage = i + 1;
  //   });
  //   print('page view 2 $_curPage');
  // }

  getPosition() async {
    await Geolocator.getCurrentPosition().then((value) {
      basicProfileData.latitude = value.latitude;
      basicProfileData.longitude = value.longitude;
    });
  }

  Future profileValue() async {
    _profileData = await BasicProfileApiProvider().fetchBasicProfile();
    print('PROFILEdATA: $_profileData');
  }

  @override
  void initState() {
    profileValue().then((value) {
      if (widget.toEditChild) {
      print('in edit mode');
      _selectedCountry = _profileData!.nationality;
      _selectedGender = _profileData!.gender;
      nameCntrl.text = _profileData!.fullName;
      emailCntrl.text = _profileData!.email;
      heightCntrl.text = _profileData!.height.toString();
      headlineCntrl.text = _profileData!.headline;
      dateCntrl.text = _profileData!.birthDay;
    }
    });
    if (auth.currentUser!.email!.isNotEmpty) {
      emailData = auth.currentUser!.email!;
      emailCntrl.text = auth.currentUser!.email!;
    }

    

    pageViewIndex = 0;
    _selectedCountry = 'Nationality';
    _selectedGender = 'Gender';
    getPosition();
    super.initState();
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  // Random _rnd = Random();

  // String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
  //     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  PageController _pgController = PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    _onProceedButtonPressed() {
      BlocProvider.of<BasicProfileBloc>(context).add(
        ProceedButtonPressed(
            birthDay: dateCntrl.text,
            email: emailCntrl.text,
            fullName: nameCntrl.text,
            gender: basicProfileData.gender,
            headline: headlineCntrl.text,
            height: double.parse(heightCntrl.text),
            longitude: basicProfileData.longitude,
            latitude: basicProfileData.latitude,
            nationality: basicProfileData.nationality,
            userName: auth.currentUser!.uid),
      );
    }

    pageViewList = [
      ListView(
        children: [
          TextField(
            controller: nameCntrl,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.white),
              errorText: validateName(nameCntrl.text),
              filled: true,
              fillColor: Color(kWhite).withOpacity(0.5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              hintText: "Full name",
              hintStyle:
                  TextStyle(color: Color(kDarkGrey), fontSize: kNormalFont),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 16),
          TextField(
            controller: emailCntrl,
            readOnly: true,
            // enabled: false,
            // enableInteractiveSelection: false,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red),
              errorText: validateEmail(emailCntrl.text),
              filled: true,
              fillColor: Color(kWhite).withOpacity(0.5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              hintText: "email",
              hintStyle:
                  TextStyle(color: Color(kDarkGrey), fontSize: kNormalFont),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(kLightGrey), width: 1)),
            child: ExpansionTile(
              key: GlobalKey(),
              title: Text(
                _selectedCountry,
                style: TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
              ),
              iconColor: Color(klightPink),
              collapsedIconColor: Color(klightPink),
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
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              basicProfileData.nationality = _countries[i];
                              _selectedCountry = _countries[i];
                            });
                          },
                          child: Text(
                            _countries[i],
                            style: TextStyle(
                                fontSize: kNormalFont, color: Color(kBlack)),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
          SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(kLightGrey), width: 1)),
            child: ExpansionTile(
              key: GlobalKey(),
              title: Text(
                _selectedGender,
                style: TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
              ),
              iconColor: Color(klightPink),
              collapsedIconColor: Color(klightPink),
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _gender.length,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              basicProfileData.gender = _gender[i];
                              _selectedGender = _gender[i];
                            });
                          },
                          child: Text(
                            _gender[i],
                            style: TextStyle(
                                fontSize: kNormalFont, color: Color(kBlack)),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
          SizedBox(height: 32),
          GestureDetector(
            onTap: () {
              // FocusScope.of(context).requestFocus(FocusNode());
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1975, 1, 1),
                  maxTime: DateTime(2019, 12, 31),
                  theme: DatePickerTheme(
                      // headerColor: Colors.black,
                      backgroundColor: Color(kWhite),
                      itemStyle: TextStyle(
                          color: Color(klightPink),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      doneStyle:
                          TextStyle(color: Color(klightPink), fontSize: 16)),
                  onChanged: (date) {
                // _dateController.text =
                //     date.toString().substring(0, 10);
              }, onConfirm: (date) {
                // FocusScope.of(context)
                //     .requestFocus(FocusNode());
                dateCntrl.text = date.toString().substring(0, 10);
                FocusScope.of(context).requestFocus(passfocus);

                // print('confirm $date');
              }, currentTime: DateTime.utc(2005, 8, 15), locale: LocaleType.en);
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: dateCntrl,

                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(klightPink).withOpacity(0.6)),
                  ),
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: kPrimaryNavy.withOpacity(0.4)),
                  // ),
                  filled: false,
                  focusedBorder: new OutlineInputBorder(
                    borderSide: BorderSide(color: Color(klightPink)),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(35.0),
                    ),
                  ),
                  hintText: 'Date of Birth',
                  // '${('Date of birth'.tr().toString())}',
                  hintStyle:
                      TextStyle(color: Color(klightPink).withOpacity(0.6)),

                  contentPadding: EdgeInsets.only(left: 16),
                ),
                // keyboardType: TextInputType.phone,
                onSaved: (value) {
                  // print(value);
                  basicProfileData.birthDay = value!;
                },
                // maxLength: 8,
                // maxLengthEnforced: false,
                validator: (String? arg) {
                  if (arg!.length == 0)
                    return 'Please provide a valid date.';
                  else
                    return null;
                },
                // TextInputFormatters are applied in sequence.
              ),
            ),
          ),
          SizedBox(height: 32),
          TextField(
            controller: heightCntrl,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Color(kWhite).withOpacity(0.5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              hintText: "Height",
              hintStyle:
                  TextStyle(color: Color(kDarkGrey), fontSize: kNormalFont),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          TextField(
            controller: headlineCntrl,
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Color(kWhite).withOpacity(0.5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(kLightGrey), width: 1)),
              hintText: "Tell us something about you",
              hintStyle:
                  TextStyle(color: Color(kDarkGrey), fontSize: kNormalFont),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(kLightGrey), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            width: MediaQuery.of(context).size.width,
            height: kButtonHeight,
            child: TextButton(
                onPressed: () {
                  print(' not passed function');
                  _onProceedButtonPressed();
                  print('passed function');
                  FocusScope.of(context).unfocus();
                  // changePageView(1);
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Color(kWhite),
                    padding: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                child: Text(
                  'Proceed',
                  style: TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
                )),
          ),
          SizedBox(
            height: 48,
          ),
        ],
      ),
      // Container(
      //   child: SecondStepperPageWidget(
      //     user: widget.user,
      //     basicProfileRepository: widget.basicProfileRepository,
      //   ),
      // )
    ];

    return Scaffold(
      backgroundColor: Color(kWhite),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
            title: Text('Profile',
                style:
                    TextStyle(fontSize: kTitleBoldFont, color: Color(kBlack))),
          ),
        ),
      ),
      body: BlocListener<BasicProfileBloc, BasicProfileState>(
          listener: (context, state) {
            print(state);
            if (state is BasicProfileProceedState) {
              navigateToSecondStepperScreen(context);
              SetSharedPrefValue().setSignupValue('HasBasicProfileValue');
              // print(state);
              // changePageView(1);
              // // setState(() {
              // //   pageViewIndex = 1;
              // // });
              // _pgController.nextPage(
              //     duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
            }
          },
          child: Container(
            // padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(height: 15.0, child: _getStepProgress()),
                SizedBox(height: 24),
                BlocBuilder<BasicProfileBloc, BasicProfileState>(
                    builder: (context, state) {
                  if (state is BasicProfileInitialState) {
                    return Container();
                  } else if (state is BasicProfileLoadingState) {
                    isLoading = true;
                  } else if (state is BasicProfileFailState) {
                    print(state.message);
                    return Container(
                      child: Text(state.message),
                    );
                    // isLoading = false;
                  }
                  return Container();
                }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 8.0, right: 16, bottom: 8),
                    child: ListView(
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
                                  color: Color(kLightGrey), width: 1)),
                          child: ExpansionTile(
                            key: GlobalKey(),
                            title: Text(
                              _selectedCountry,
                              style: TextStyle(
                                  fontSize: kNormalFont, color: Color(kBlack)),
                            ),
                            iconColor: Color(klightPink),
                            collapsedIconColor: Color(klightPink),
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
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            basicProfileData.nationality =
                                                _countries[i];
                                            _selectedCountry = _countries[i];
                                          });
                                        },
                                        child: Text(
                                          _countries[i],
                                          style: TextStyle(
                                              fontSize: kNormalFont,
                                              color: Color(kBlack)),
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Color(kLightGrey), width: 1)),
                          child: ExpansionTile(
                            key: GlobalKey(),
                            title: Text(
                              _selectedGender,
                              style: TextStyle(
                                  fontSize: kNormalFont, color: Color(kBlack)),
                            ),
                            iconColor: Color(klightPink),
                            collapsedIconColor: Color(klightPink),
                            children: <Widget>[
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: _gender.length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            basicProfileData.gender =
                                                _gender[i];
                                            _selectedGender = _gender[i];
                                          });
                                        },
                                        child: Text(
                                          _gender[i],
                                          style: TextStyle(
                                              fontSize: kNormalFont,
                                              color: Color(kBlack)),
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        GestureDetector(
                          onTap: () {
                            // FocusScope.of(context).requestFocus(FocusNode());
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1975, 1, 1),
                                maxTime: DateTime(2019, 12, 31),
                                theme: DatePickerTheme(
                                    // headerColor: Colors.black,
                                    backgroundColor: Color(kWhite),
                                    itemStyle: TextStyle(
                                        color: Color(kBlack),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    doneStyle: TextStyle(
                                        color: Color(kBlack),
                                        fontSize: 16)), onChanged: (date) {
                              // _dateController.text =
                              //     date.toString().substring(0, 10);
                            }, onConfirm: (date) {
                              // FocusScope.of(context)
                              //     .requestFocus(FocusNode());
                              dateCntrl.text = date.toString().substring(0, 10);
                              FocusScope.of(context).requestFocus(passfocus);

                              // print('confirm $date');
                            },
                                currentTime: DateTime.utc(2005, 8, 15),
                                locale: LocaleType.en);
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: dateCntrl,

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(kWhite).withOpacity(0.5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kLightGrey), width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kLightGrey), width: 1)),
                                // focusedBorder: UnderlineInputBorder(
                                //   borderSide: BorderSide(color: kPrimaryNavy.withOpacity(0.4)),
                                // ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kLightGrey), width: 1)),
                                hintText: 'Date of Birth',
                                // '${('Date of birth'.tr().toString())}',
                                hintStyle: TextStyle(
                                    color: Color(kLightGrey),
                                    fontSize: kNormalFont),

                                contentPadding: EdgeInsets.only(left: 16),
                              ),
                              // keyboardType: TextInputType.phone,
                              onSaved: (value) {
                                // print(value);
                                basicProfileData.birthDay = value!;
                              },
                              // maxLength: 8,
                              // maxLengthEnforced: false,
                              validator: (String? arg) {
                                if (arg!.length == 0)
                                  return 'Please provide a valid date.';
                                else
                                  return null;
                              },
                              // TextInputFormatters are applied in sequence.
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        TextField(
                          controller: heightCntrl,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.red),
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
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: headlineCntrl,
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
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(klightPink))),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(kLightGrey), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: kButtonHeight,
                                child: TextButton(
                                    onPressed: () {
                                      print(' not passed function');
                                      _onProceedButtonPressed();
                                      print('passed function');
                                      FocusScope.of(context).unfocus();
                                      // changePageView(1);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Color(kWhite),
                                        padding: EdgeInsets.all(8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4))),
                                    child: Text(
                                      'Proceed',
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    )),
                              ),
                        SizedBox(
                          height: 48,
                        ),
                      ],
                    ),

                    // PageView.builder(
                    //   controller: _pgController,
                    //   itemCount: pageViewList.length,
                    //   itemBuilder: (context, pageViewIndex) {
                    //     return pageViewList[pageViewIndex];
                    //   },
                    //   physics: NeverScrollableScrollPhysics(),
                    //   // onPageChanged: (i) {
                    //   //   changePageView(i);
                    //   // },
                    // ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void navigateToSecondStepperScreen(BuildContext context
      // , Peoples user
      ) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SecondStepperPageWidget(
          user: widget.user,
          basicProfileRepository: widget.basicProfileRepository);
      // Tabs(user: user, userRepository: userRepository);
    }));
  }
}
