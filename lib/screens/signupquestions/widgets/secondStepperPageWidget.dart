import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileBloc.dart';
import 'package:piassa_application/blocs/basicProfileBloc/basicProfileEvent.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/screens/allDoneScreen/allDoneScreen.dart';
import 'package:piassa_application/screens/gallaryScreen/gallaryScreen.dart';
import 'package:piassa_application/services/basicProfileApiProvider.dart';

class SecondStepperPageWidget extends StatefulWidget {
  final User user;
  final BasicProfileRepository basicProfileRepository;

  const SecondStepperPageWidget(
      {Key? key, required this.user, required this.basicProfileRepository})
      : super(key: key);

  @override
  _SecondStepperPageWidgetState createState() =>
      _SecondStepperPageWidgetState();
}

class _SecondStepperPageWidgetState extends State<SecondStepperPageWidget> {
  RangeLabels labels = RangeLabels('1', "100");
  RangeValues values = RangeValues(1, 100);
  int divisions = 5;
  List strLabels = [];
  int _currentScore = 0;
  List _educationLevel = ['Diploma', 'Degree', 'Masters'];
  String selectedEducationLevel = '';
  int eduIndex = 0;
  late String _selectedReligion;

  Preference preferenceData = Preference(
      ageStart: 0,
      ageEnd: 0,
      religion: '',
      educationLevel: '',
      searchRadius: 0.0);

  List<String> _religions = ['Orthodox', 'Muslim', 'Protestant'];

  LinearGradient gradient = LinearGradient(colors: <Color>[
    Color(kPrimaryPink),
    Color(kPrimaryPurple),
  ]);

  @override
  void initState() {
    _selectedReligion = _religions[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onSubmitButtonPressed() {
      BlocProvider.of<BasicProfileBloc>(context).add(SubmitButtonPressed(
          ageStart: preferenceData.ageStart,
          ageEnd: preferenceData.ageEnd,
          religion: preferenceData.religion,
          educationLevel: preferenceData.educationLevel,
          searchRadius: preferenceData.searchRadius));
      print('after bloc');
      
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Age',
                        style: TextStyle(
                            fontSize: kNormalFont, color: Color(kBlack)),
                      ),
                      Text(
                        '${values.start.round()} - ${values.end.round()}',
                        style: TextStyle(
                            fontSize: kNormalFont, color: Color(kBlack)),
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
                    min: 1,
                    max: 100,
                    values: values,
                    labels: labels,
                    onChanged: (value) {
                      print("START: ${value.start}, End: ${value.end}");

                      setState(() {
                        values = value;
                        labels = RangeLabels(
                            "${value.start.toInt().toString()}",
                            "${value.end.toInt().toString()}");
                        preferenceData.ageStart = value.start.toInt();
                        preferenceData.ageEnd = value.end.toInt();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Distance',
                        style: TextStyle(
                            fontSize: kNormalFont, color: Color(kBlack)),
                      ),
                      Text(
                        '$_currentScore Km',
                        style: TextStyle(
                            fontSize: kNormalFont, color: Color(kBlack)),
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
                      value: _currentScore.toDouble(),
                      min: 0.0,
                      max: 10.0,
                      divisions: 10,
                      label: '$_currentScore',
                      onChanged: (double newValue) {
                        setState(() {
                          _currentScore = newValue.round();
                          preferenceData.searchRadius = newValue;
                        });
                      }),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Education',
                        style: TextStyle(
                            fontSize: kNormalFont, color: Color(kBlack)),
                      ),
                      Text(
                        '${_educationLevel[eduIndex]}',
                        style: TextStyle(
                            fontSize: kNormalFont, color: Color(kBlack)),
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
                          preferenceData.educationLevel =
                              _educationLevel[eduIndex];
                        });
                      }),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Container(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(kLightGrey), width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      color: Color(kWhite).withOpacity(0.5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: ExpansionTile(
                          title: Text(
                            _selectedReligion,
                            style: TextStyle(
                                fontSize: kNormalFont, color: Color(kBlack)),
                          ),
                          collapsedIconColor: Color(klightPink),
                          iconColor: Color(klightPink),
                          children: <Widget>[
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: _religions.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          preferenceData.religion =
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
                border: Border.all(color: Color(kLightGrey), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              width: MediaQuery.of(context).size.width,
              height: kButtonHeight,
              child: TextButton(
                  onPressed: () {
                    _onSubmitButtonPressed();
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
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(
                    'Save',
                    style:
                        TextStyle(fontSize: kButtonFont, color: Color(kBlack)),
                  )),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
