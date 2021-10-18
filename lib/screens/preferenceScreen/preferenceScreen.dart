import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/screens/allDoneScreen/allDoneScreen.dart';

class PreferenceScreen extends StatefulWidget {
  // final User user;
  // final AuthRepository userRepository;

  // const PreferenceScreen({Key? key, required this.user, required this.userRepository}) : super(key: key);

  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  RangeLabels labels = RangeLabels('18', "70");
  RangeValues values = RangeValues(18, 70);
  int divisions = 5;
  List strLabels = [];
  int _currentScore = 0;
  List _educationLevel = ['High School Diploma', 'Advanced Diploma', 'Bachelors Degree', 'Masters Degree', 'Doctorate', 'Other'];
  String selectedEducationLevel = '';
  int eduIndex = 0;
  late String _selectedUniversity;

  List<String> _universities = ['Orthodox', 'Muslim', 'Protestant', 'Other'];

  LinearGradient gradient = LinearGradient(colors: <Color>[
    Color(kPrimaryPink),
    Color(kPrimaryPurple),
  ]);

  @override
  void initState() {
    _selectedUniversity = 'Religion';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            leadingIcon: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(klightPink), size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Preference',
                style:
                    TextStyle(fontSize: kTitleBoldFont, color: Color(kBlack))),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                            _selectedUniversity,
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
                                itemCount: _universities.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
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
                    ),
                  ),
                ),
              ],
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
                      //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      //   return AllDoneScreen(user: widget.user, userRepository: widget.userRepository);
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
                      style: TextStyle(
                          fontSize: kButtonFont, color: Color(kBlack)),
                    )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
