import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/myEducation.dart';

class EducationAndProfessionScreen extends StatefulWidget {
  @override
  _EducationAndProfessionScreenState createState() =>
      _EducationAndProfessionScreenState();
}

class _EducationAndProfessionScreenState
    extends State<EducationAndProfessionScreen> {
  TextEditingController jobCntrl = TextEditingController();
  TextEditingController companyCntrl = TextEditingController();

  late String _selectedUniversity;
  late String _selectedProfession;
  MyEducation? myEducationData;


  List<String> _universities = ['AAU', 'JU', 'BDU'];
  List<String> _professions = ['Lawyer', 'Accountant', 'Engineer'];
  List _educationLevel = [
    'High School Diploma',
    'Advanced Diploma',
    'Bachelors Degree',
    'Masters Degree',
    'Doctorate',
    'Other'
  ];
  int eduIndex = 0;


  @override
  void initState() {
    _selectedUniversity = 'University';
    _selectedProfession = 'Profession';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Text('Education and Profession',
                style: TextStyle(
                    fontSize: kTitleBoldFont,
                    fontWeight: FontWeight.bold,
                    color: Color(kBlack))),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color(kWhite),
          padding: EdgeInsets.all(16),
          child: Column(
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
                            myEducationData!.educationLevel =
                                _educationLevel[eduIndex];
                          });
                        }),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color(kLightGrey).withOpacity(0.5),
                              width: 1),
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
                  SizedBox(height: 32),
                  Container(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color(kLightGrey).withOpacity(0.5),
                              width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      color: Color(kWhite).withOpacity(0.5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: ExpansionTile(
                          title: Text(
                            _selectedProfession,
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
                                      _professions[i],
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
                              color: Color(kLightGrey).withOpacity(0.5),
                              width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                              color: Color(kLightGrey).withOpacity(0.5),
                              width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                              color: Color(kLightGrey).withOpacity(0.5),
                              width: 1)),
                      hintText: "Job Title",
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
                              color: Color(kLightGrey).withOpacity(0.5),
                              width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                              color: Color(kLightGrey).withOpacity(0.5),
                              width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                              color: Color(kLightGrey).withOpacity(0.5),
                              width: 1)),
                      hintText: "Company",
                      hintStyle: TextStyle(
                          color: Color(kDarkGrey), fontSize: kNormalFont),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ],
              )),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(klightPink).withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                width: MediaQuery.of(context).size.width,
                height: kButtonHeight,
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        primary: Color(kWhite),
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: kButtonFont,
                          fontWeight: FontWeight.bold,
                          color: Color(kBlack)),
                    )),
              ),
              SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
