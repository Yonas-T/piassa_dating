import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileBloc.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileEvent.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileState.dart';
import 'package:piassa_application/blocs/matchPreferenceBloc/matchPreferenceBloc.dart';
import 'package:piassa_application/blocs/matchPreferenceBloc/matchPreferenceEvent.dart';
import 'package:piassa_application/blocs/matchPreferenceBloc/matchPreferenceState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
import 'package:piassa_application/repositories/uploadImageRepository.dart';
import 'package:piassa_application/screens/allDoneScreen/allDoneScreen.dart';
import 'package:piassa_application/screens/gallaryScreen/gallaryScreen.dart';
import 'package:piassa_application/screens/signupquestions/widgets/stepProgressWidget.dart';
import 'package:piassa_application/services/basicProfileApiProvider.dart';
import 'package:piassa_application/services/myProfileApiProvider.dart';
import 'package:piassa_application/utils/sheredPref.dart';

class SecondStepperPageWidget extends StatelessWidget {
  bool toEdit;
  final MatchPreferenceRepository matchPreferenceRepository =
      MatchPreferenceRepository();
  final BasicProfileRepository basicProfileRepository;
  final User user;

  SecondStepperPageWidget({
    required this.toEdit,
    required this.basicProfileRepository,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchPreferenceBloc(
          matchPreferenceRepository: matchPreferenceRepository),
      child: SecondStepperPageWidgetChild(
        toEditChild: toEdit,
        basicProfileRepository: basicProfileRepository,
        user: user,
      ),
    );
  }
}

class SecondStepperPageWidgetChild extends StatefulWidget {
  bool toEditChild;
  final User user;
  final BasicProfileRepository basicProfileRepository;

  SecondStepperPageWidgetChild(
      {Key? key,
      required this.toEditChild,
      required this.user,
      required this.basicProfileRepository})
      : super(key: key);

  @override
  _SecondStepperPageWidgetChildState createState() =>
      _SecondStepperPageWidgetChildState();
}

class _SecondStepperPageWidgetChildState
    extends State<SecondStepperPageWidgetChild> {
  RangeLabels labels = RangeLabels('18', "70");
  RangeValues? values;
  int divisions = 5;
  List strLabels = [];
  int _distance = 0;
  List _educationLevel = [
    'High School Diploma',
    'Advanced Diploma',
    'Bachelors Degree',
    'Masters Degree',
    'Doctorate',
    'Other'
  ];
  String selectedEducationLevel = '';
  int eduIndex = 0;
  late String _selectedReligion;
  Preference? preferenceData;
  bool buttonVal = false;
  List<String> _religions = ['Orthodox', 'Muslim', 'Protestant', 'Other'];
  bool isLoading = false;
  bool gotData = false;
  UserMatch? _myProfile;
  LinearGradient gradient = LinearGradient(colors: <Color>[
    Color(kPrimaryPink),
    Color(kPrimaryPurple),
  ]);

  Future myProfile() async {
    _myProfile = await MyProfileApiProvider().fetchMyProfile();
  }

  @override
  void initState() {
    gotData = false;
    print('Got Data: $gotData');
    myProfile().then((value) {
      print(_myProfile!.matchPreference);
      print(widget.toEditChild);
      if (widget.toEditChild) {
        values = RangeValues(_myProfile!.matchPreference.ageStart.toDouble(),
            _myProfile!.matchPreference.ageEnd.toDouble());
        _distance = _myProfile!.matchPreference.searchRadius.round();
        if (_myProfile!.matchPreference.educationLevel ==
            'High School Diploma') {
          eduIndex = 0;
        } else if (_myProfile!.matchPreference.educationLevel ==
            'Advanced Diploma') {
          eduIndex = 1;
        } else if (_myProfile!.matchPreference.educationLevel ==
            'Bachelors Degree') {
          eduIndex = 2;
        } else if (_myProfile!.matchPreference.educationLevel ==
            'Masters Degree') {
          eduIndex = 3;
        } else if (_myProfile!.matchPreference.educationLevel == 'Doctorate') {
          eduIndex = 4;
        } else {
          eduIndex = 5;
        }
        _selectedReligion = _myProfile!.matchPreference.religion;
      }
      setState(() {
      gotData = true;
      });
    print('Got Data: $gotData');
    });
    values = RangeValues(18, 70);
    preferenceData = Preference(
        // gender: 'female',
        id: '',
        gender: '',
        ageStart: 0,
        ageEnd: 0,
        religion: '',
        educationLevel: '',
        searchRadius: 0.0);
    _selectedReligion = 'Religion';
    

    super.initState();
  }

  StepProgressWidget _getStepProgress() {
    return StepProgressWidget(
      curStep: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    _onSubmitButtonPressed() {
      print(preferenceData!.educationLevel);
      print(preferenceData!.ageEnd);
      print(preferenceData!.ageStart);
      // print(preferenceData.gender);
      print(preferenceData!.searchRadius);
      print(preferenceData!.religion);

      BlocProvider.of<MatchPreferenceBloc>(context).add(SubmitButtonPressed(
          id: preferenceData!.id,
          gender: preferenceData!.gender,
          ageStart: preferenceData!.ageStart,
          ageEnd: preferenceData!.ageEnd,
          religion: preferenceData!.religion,
          educationLevel: preferenceData!.educationLevel,
          searchRadius: preferenceData!.searchRadius));
      print('after bloc in build');
    }

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
            leadingIcon: widget.toEditChild
                ? IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: Color(klightPink), size: 30),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : Container(),
            title: Text('Preference',
                style:
                    TextStyle(fontSize: kTitleBoldFont, color: Color(kBlack))),
          ),
        ),
      ),
      body: !gotData
          ? Center(child: CircularProgressIndicator())
          : BlocListener<MatchPreferenceBloc, MatchPreferenceState>(
              listener: (context, state) {
                print(state);
                if (state is MatchPreferenceSuccessState) {
                  navigateToGallaryScreen(context
                      // , state.user
                      );
                  SetSharedPrefValue().setSignupValue('HasPreferenceValue');
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.toEditChild
                        ? Container()
                        : Container(height: 15.0, child: _getStepProgress()),
                    SizedBox(height: 24),
                    BlocBuilder<MatchPreferenceBloc, MatchPreferenceState>(
                        builder: (context, state) {
                      if (state is MatchPreferenceInitialState) {
                        return Container();
                      } else if (state is MatchPreferenceLoadingState) {
                        isLoading = true;
                      } else if (state is MatchPreferenceFailState) {
                        print(state.message);
                        isLoading = false;
                      }
                      return Container();
                    }),
                    Expanded(
                      child: ListView(
                        children: [
                          SizedBox(height: 32),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Age',
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                ),
                                Text(
                                  '${values!.start.round()} - ${values!.end.round()}',
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                )
                              ],
                            ),
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 5,
                              activeTickMarkColor: Color(kWhite),
                              thumbColor: Color(kWhite),
                              inactiveTickMarkColor: Color(kWhite),
                              disabledInactiveTickMarkColor: Color(kWhite),
                              rangeThumbShape: RoundRangeSliderThumbShape(
                                elevation: 4,
                                pressedElevation: 8,
                                disabledThumbRadius: 12,
                                enabledThumbRadius: 12,
                              ),
                              disabledActiveTickMarkColor: Color(kWhite),
                            ),
                            child: RangeSlider(
                              divisions: divisions,
                              activeColor: Color(klightPink),
                              inactiveColor: Colors.grey[300],
                              min: 18,
                              max: 70,
                              values: values!,
                              labels: labels,
                              onChanged: (value) {
                                print(
                                    "START: ${value.start}, End: ${value.end}");

                                setState(() {
                                  values = value;
                                  labels = RangeLabels(
                                      "${value.start.toInt().toString()}",
                                      "${value.end.toInt().toString()}");
                                  preferenceData!.ageStart =
                                      value.start.toInt();
                                  preferenceData!.ageEnd = value.end.toInt();
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Distance',
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                ),
                                Text(
                                  '$_distance Km',
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                )
                              ],
                            ),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 5,
                              activeTrackColor: Color(klightPink),
                              inactiveTrackColor: Colors.grey[300],
                              thumbColor: Color(klightPink),
                              thumbShape: RoundSliderThumbShape(
                                  elevation: 4,
                                  pressedElevation: 8,
                                  disabledThumbRadius: 12,
                                  enabledThumbRadius: 12),
                            ),
                            child: Slider(
                                value: _distance.toDouble(),
                                min: 0.0,
                                max: 10.0,
                                divisions: 10,
                                label: '$_distance',
                                onChanged: (double newValue) {
                                  setState(() {
                                    _distance = newValue.round();
                                    preferenceData!.searchRadius = newValue;
                                  });
                                }),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Education',
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                ),
                                Text(
                                  '${_educationLevel[eduIndex]}',
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                )
                              ],
                            ),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 5,
                              activeTrackColor: Color(klightPink),
                              inactiveTrackColor: Colors.grey[300],
                              thumbColor: Color(klightPink),
                              thumbShape: RoundSliderThumbShape(
                                  elevation: 4,
                                  pressedElevation: 8,
                                  disabledThumbRadius: 12,
                                  enabledThumbRadius: 12),
                            ),
                            child: Slider(
                                value: eduIndex.toDouble(),
                                min: 0,
                                max: _educationLevel.length - 1.toDouble(),
                                divisions: _educationLevel.length - 1,
                                label: '${_educationLevel[eduIndex]}',
                                onChanged: (double newValue) {
                                  print(newValue);
                                  setState(() {
                                    eduIndex = newValue.round();
                                    preferenceData!.educationLevel =
                                        _educationLevel[eduIndex];
                                  });
                                }),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(kLightGrey), width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedReligion,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _religions.length,
                                          itemBuilder: (context, i) {
                                            return Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  16, 8, 8, 8),
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    preferenceData!.religion =
                                                        _religions[i];
                                                    _selectedReligion =
                                                        _religions[i];
                                                  });
                                                },
                                                child: Text(
                                                  _religions[i],
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(kLightGrey), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: kButtonHeight,
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(klightPink))))
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    buttonVal = true;
                                  });
                                  _onSubmitButtonPressed();
                                  setState(() {
                                    buttonVal = false;
                                  });
                                  // Navigator.of(context)
                                  //     .push(MaterialPageRoute(builder: (context) {
                                  //   return GallaryScreen(
                                  //       user: widget.user,
                                  //       basicProfileRepository:
                                  //           widget.basicProfileRepository);
                                  // }));
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Color(kWhite),
                                    padding: EdgeInsets.all(8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: kButtonFont,
                                      color: Color(kBlack)),
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void navigateToGallaryScreen(BuildContext context
      // , Peoples user
      ) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return GallaryScreen(
        basicProfileRepository: widget.basicProfileRepository,
      );
      // Tabs(user: user, userRepository: userRepository);
    }));
  }
}
