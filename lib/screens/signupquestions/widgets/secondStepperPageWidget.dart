import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/screens/allDoneScreen/allDoneScreen.dart';

class SecondStepperPageWidget extends StatefulWidget {
  final User user;
  final AuthRepository userRepository;

  const SecondStepperPageWidget({Key? key, required this.user, required this.userRepository}) : super(key: key);

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
  late String _selectedUniversity;

  List<String> _universities = ['Orthodox', 'Muslim', 'Protestant'];

  LinearGradient gradient = LinearGradient(colors: <Color>[
    Color(kPrimaryPink),
    Color(kPrimaryPurple),
  ]);

  @override
  void initState() {
    _selectedUniversity = _universities[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Age',
                      style: TextStyle(
                          fontSize: kNormalFont, color: Color(kDarkGrey)),
                    ),
                    Text(
                      '${values.start} - ${values.end}',
                      style: TextStyle(
                          fontSize: kNormalFont, color: Color(kDarkGrey)),
                    )
                  ],
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 5,
                ),
                child: RangeSlider(
                  divisions: divisions,
                  activeColor: Color(kPrimaryYellow),
                  inactiveColor: Colors.grey[300],
                  min: 1,
                  max: 100,
                  values: values,
                  labels: labels,
                  onChanged: (value) {
                    print("START: ${value.start}, End: ${value.end}");
          
                    setState(() {
                      values = value;
                      labels = RangeLabels("${value.start.toInt().toString()}",
                          "${value.start.toInt().toString()}");
                    });
                  },
                ),
              ),
              SizedBox(height: 32,),
          
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Distance',
                      style: TextStyle(
                          fontSize: kNormalFont, color: Color(kDarkGrey)),
                    ),
                    Text(
                      '$_currentScore Km',
                      style: TextStyle(
                          fontSize: kNormalFont, color: Color(kDarkGrey)),
                    )
                  ],
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 5,
                  activeTrackColor: Color(kPrimaryYellow),
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Color(kPrimaryYellow),
                  // thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                  // overlayShape: RoundSliderOverlayShape(overlayRadius: 35),
                  // overlayColor: Color(kPrimaryYellow),
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
              SizedBox(height: 32,),
          
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Education',
                      style: TextStyle(
                          fontSize: kNormalFont, color: Color(kDarkGrey)),
                    ),
                    Text(
                      '${_educationLevel[eduIndex]}',
                      style: TextStyle(
                          fontSize: kNormalFont, color: Color(kDarkGrey)),
                    )
                  ],
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 5,
                  activeTrackColor: Color(kPrimaryYellow),
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Color(kPrimaryYellow),
                  // thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                  // overlayShape: RoundSliderOverlayShape(overlayRadius: 35),
                  // overlayColor: Color(kPrimaryYellow),
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
                          SizedBox(height: 32,),
          
              Container(
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(kDarkGrey), width: 1),
                      borderRadius: BorderRadius.circular(16)),
                  color: Color(kDarkGrey).withOpacity(0.02),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: ExpansionTile(
                      title: Text(
                        _selectedUniversity,
                        style: TextStyle(
                            fontSize: kNormalFont, color: Color(kDarkGrey)),
                      ),
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
                                      color: Color(kDarkGrey)),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 48,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
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
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return AllDoneScreen(user: widget.user, userRepository: widget.userRepository);
                }));
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
                      TextStyle(fontSize: kNormalFont, color: Color(kDarkGrey)),
                )),
          ),
          // SizedBox(
          //   height: 8,
          // ),
        ],
      ),
    );
  }
}
