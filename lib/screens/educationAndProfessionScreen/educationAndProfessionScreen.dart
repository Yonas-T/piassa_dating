import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piassa_application/blocs/myEducationBloc/myEducationBloc.dart';
import 'package:piassa_application/blocs/myEducationBloc/myEducationEvent.dart';
import 'package:piassa_application/blocs/myEducationBloc/myEducationState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/languageValue.dart';
import 'package:piassa_application/models/myEducation.dart';
import 'package:piassa_application/repositories/myEducationRepository.dart';
import 'package:piassa_application/services/myEducationApiProvider.dart';

class EducationAndProfessionScreen extends StatefulWidget {
  MyEducationRepository myEducationRepository = MyEducationRepository();

  @override
  _EducationAndProfessionScreenState createState() =>
      _EducationAndProfessionScreenState();
}

class _EducationAndProfessionScreenState
    extends State<EducationAndProfessionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyEducationBloc(myEducationRepository: widget.myEducationRepository)
            ..add(LoadUniversitiesAndProfessions()),
      child: EducationAndProfessionChildScreen(
        myEducationRepository: widget.myEducationRepository,
      ),
    );
  }
}

class EducationAndProfessionChildScreen extends StatefulWidget {
  MyEducationRepository myEducationRepository;

  EducationAndProfessionChildScreen({
    required this.myEducationRepository,
  });
  @override
  _EducationAndProfessionChildScreenState createState() =>
      _EducationAndProfessionChildScreenState();
}

class _EducationAndProfessionChildScreenState
    extends State<EducationAndProfessionChildScreen> {
  TextEditingController jobCntrl = TextEditingController();
  TextEditingController companyCntrl = TextEditingController();
  MyEducationBloc? myEducationBloc;

  String? _selectedUniversity;
  String? _selectedProfession;
  String? _selectedUniversityId;
  String? _selectedProfessionId;
  String? educationLevel;

  List<String> _universities = [];
  List<String> _professions = [];
  List _educationLevel = [
    'High School Diploma',
    'Advanced Diploma',
    'Bachelors Degree',
    'Masters Degree',
    'Doctorate',
    'Other'
  ];
  int eduIndex = 0;
  List<LanguageValue> _eduData = [];
  List<LanguageValue> _profData = [];

  Future educationAndProfValue() async {
    _eduData = await MyEducationApiProvider().fetchUniversities();
    _profData = await MyEducationApiProvider().fetchProfession();
  }

  @override
  void initState() {
    educationLevel = _educationLevel[eduIndex];
    setState(() {
      eduIndex = 0;
    });
    myEducationBloc = MyEducationBloc(
      myEducationRepository: widget.myEducationRepository,
    );

    educationAndProfValue().whenComplete(() {
      setState(() {
        _eduData.forEach((element) {
          _universities.add(element.englishValue);
        });
        _profData.forEach((element) {
          _professions.add(element.englishValue);
        });
      });
    });
    _selectedUniversity = 'University';
    _selectedProfession = 'Profession';
    _selectedUniversityId = '';
    _selectedProfessionId = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onSaveButtonPressed() {
      MyEducation educationData = MyEducation(
        educationLevel: _educationLevel[eduIndex],
        universityId: _selectedUniversityId!,
        professionId: _selectedProfessionId!,
        jobTitle: jobCntrl.text,
        company: companyCntrl.text,
      );

      BlocProvider.of<MyEducationBloc>(context).add(SaveEducationButtonPressed(
        education: educationData,
      ));
    }

    _onEditButtonPressed() {
      MyEducation educationData = MyEducation(
        educationLevel: _educationLevel[eduIndex],
        universityId: _selectedUniversityId!,
        professionId: _selectedProfessionId!,
        jobTitle: jobCntrl.text,
        company: companyCntrl.text,
      );

      BlocProvider.of<MyEducationBloc>(context).add(EditEducationButtonPressed(
        education: educationData,
      ));
    }

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
        child: BlocListener<MyEducationBloc, MyEducationState>(
          listener: (context, state) {
            if (state is MyEducationSuccessState) {
              Navigator.of(context).pop();
            }
            if (state is MyEducationLoadedState) {
              if (state.myEducationData.educationLevel ==
                      'High School Diploma') {
                    eduIndex = 0;
                  } else if (state.myEducationData.educationLevel ==
                      'Advanced Diploma') {
                    eduIndex = 1;
                  } else if (state.myEducationData.educationLevel ==
                      'Bachelors Degree') {
                    eduIndex = 2;
                  } else if (state.myEducationData.educationLevel ==
                      'Masters Degree') {
                    eduIndex = 3;
                  } else if (state.myEducationData.educationLevel ==
                      'Doctorate') {
                    eduIndex = 4;
                  } else {
                    eduIndex = 5;
                  }
                  _selectedUniversity =
                      state.myEducationData.university.englishValue;
                  _selectedProfession =
                      state.myEducationData.profession.englishValue;
                  jobCntrl.text = state.myEducationData.jobTitle;
                  companyCntrl.text = state.myEducationData.company;
            }
          },
          child: BlocBuilder<MyEducationBloc, MyEducationState>(
            builder: (context, state) {
              log(state.toString());

              if (state is MyEducationLoadedState) {
                if (state.myEducationData != null) {
                  
                  return Container(
                    color: Color(kWhite),
                    padding: EdgeInsets.all(16),
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
                                  educationLevel = _educationLevel[eduIndex];
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
                                key: GlobalKey(),
                                title: Text(
                                  _selectedUniversity!,
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                ),
                                collapsedIconColor: Color(klightPink),
                                iconColor: Color(klightPink),
                                children: <Widget>[
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: _eduData.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedUniversity =
                                                  _eduData[i].englishValue;
                                              _selectedUniversityId =
                                                  _eduData[i].id;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                16, 8, 8, 8),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _eduData[i].englishValue,
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
                                key: GlobalKey(),
                                title: Text(
                                  _selectedProfession!,
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                ),
                                collapsedIconColor: Color(klightPink),
                                iconColor: Color(klightPink),
                                children: <Widget>[
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: _profData.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedProfession =
                                                  _profData[i].englishValue;
                                              _selectedProfessionId =
                                                  _profData[i].id;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                16, 8, 8, 8),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _profData[i].englishValue,
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
                        SizedBox(height: 32),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(klightPink).withOpacity(0.5),
                                width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: kButtonHeight,
                          child: TextButton(
                              onPressed: () {
                                _onEditButtonPressed();
                                // MyEducation educationData = MyEducation(
                                //   educationLevel: _educationLevel[eduIndex],
                                //   universityId: _selectedUniversityId!,
                                //   professionId: _selectedProfessionId!,
                                //   jobTitle: jobCntrl.text,
                                //   company: companyCntrl.text,
                                // );
                                // myEducationBloc!.add(SaveEducationButtonPressed(
                                //     education: educationData));
                              },
                              style: TextButton.styleFrom(
                                  primary: Color(kWhite),
                                  padding: EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: kButtonFont,
                                    fontWeight: FontWeight.bold,
                                    color: Color(kBlack)),
                              )),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    color: Color(kWhite),
                    padding: EdgeInsets.all(16),
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
                                  educationLevel = _educationLevel[eduIndex];
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
                                key: GlobalKey(),
                                title: Text(
                                  _selectedUniversity!,
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                ),
                                collapsedIconColor: Color(klightPink),
                                iconColor: Color(klightPink),
                                children: <Widget>[
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: _eduData.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedUniversity =
                                                  _eduData[i].englishValue;
                                              _selectedUniversityId =
                                                  _eduData[i].id;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                16, 8, 8, 8),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _eduData[i].englishValue,
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
                                key: GlobalKey(),
                                title: Text(
                                  _selectedProfession!,
                                  style: TextStyle(
                                      fontSize: kNormalFont,
                                      color: Color(kBlack)),
                                ),
                                collapsedIconColor: Color(klightPink),
                                iconColor: Color(klightPink),
                                children: <Widget>[
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: _profData.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedProfession =
                                                  _profData[i].englishValue;
                                              _selectedProfessionId =
                                                  _profData[i].id;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                16, 8, 8, 8),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _profData[i].englishValue,
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
                        SizedBox(height: 32),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(klightPink).withOpacity(0.5),
                                width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: kButtonHeight,
                          child: TextButton(
                              onPressed: () {
                                _onSaveButtonPressed();
                                // MyEducation educationData = MyEducation(
                                //   educationLevel: _educationLevel[eduIndex],
                                //   universityId: _selectedUniversityId!,
                                //   professionId: _selectedProfessionId!,
                                //   jobTitle: jobCntrl.text,
                                //   company: companyCntrl.text,
                                // );
                                // myEducationBloc!.add(SaveEducationButtonPressed(
                                //     education: educationData));
                              },
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
                        )
                      ],
                    ),
                  );
                }
              }

              if (state is MyEducationLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(klightPink)),
                  ),
                );
              }
              if (state is MyEducationInitialState) {
                return Container(
                    color: Color(kWhite),
                    padding: EdgeInsets.all(16),
                    child: ListView(children: [
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
                                educationLevel = _educationLevel[eduIndex];
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
                              key: GlobalKey(),
                              title: Text(
                                _selectedUniversity!,
                                style: TextStyle(
                                    fontSize: kNormalFont,
                                    color: Color(kBlack)),
                              ),
                              collapsedIconColor: Color(klightPink),
                              iconColor: Color(klightPink),
                              children: <Widget>[
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: _eduData.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedUniversity =
                                                _eduData[i].englishValue;
                                            _selectedUniversityId =
                                                _eduData[i].id;
                                          });
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 8, 8, 8),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            _eduData[i].englishValue,
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
                              key: GlobalKey(),
                              title: Text(
                                _selectedProfession!,
                                style: TextStyle(
                                    fontSize: kNormalFont,
                                    color: Color(kBlack)),
                              ),
                              collapsedIconColor: Color(klightPink),
                              iconColor: Color(klightPink),
                              children: <Widget>[
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: _profData.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedProfession =
                                                _profData[i].englishValue;
                                            _selectedProfessionId =
                                                _profData[i].id;
                                          });
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 8, 8, 8),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            _profData[i].englishValue,
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
                      SizedBox(height: 32),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(klightPink).withOpacity(0.5),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: kButtonHeight,
                        child: TextButton(
                            onPressed: () {
                              // MyEducation educationData = MyEducation(
                              //   educationLevel: _educationLevel[eduIndex],
                              //   universityId: _selectedUniversityId!,
                              //   professionId: _selectedProfessionId!,
                              //   jobTitle: jobCntrl.text,
                              //   company: companyCntrl.text,
                              // );
                              // myEducationBloc!.add(
                              //     SaveButtonPressed(education: educationData));
                              _onSaveButtonPressed();
                              FocusScope.of(context).unfocus();
                            },
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
                      )
                    ]));
              }
              if (state is MyEducationFailState) {
                return Container(
                    color: Color(kWhite),
                    padding: EdgeInsets.all(16),
                    child: ListView(children: [
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
                                educationLevel = _educationLevel[eduIndex];
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
                              key: GlobalKey(),
                              title: Text(
                                _selectedUniversity!,
                                style: TextStyle(
                                    fontSize: kNormalFont,
                                    color: Color(kBlack)),
                              ),
                              collapsedIconColor: Color(klightPink),
                              iconColor: Color(klightPink),
                              children: <Widget>[
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: _eduData.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedUniversity =
                                                _eduData[i].englishValue;
                                            _selectedUniversityId =
                                                _eduData[i].id;
                                          });
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 8, 8, 8),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            _eduData[i].englishValue,
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
                              key: GlobalKey(),
                              title: Text(
                                _selectedProfession!,
                                style: TextStyle(
                                    fontSize: kNormalFont,
                                    color: Color(kBlack)),
                              ),
                              collapsedIconColor: Color(klightPink),
                              iconColor: Color(klightPink),
                              children: <Widget>[
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: _profData.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedProfession =
                                                _profData[i].englishValue;
                                            _selectedProfessionId =
                                                _profData[i].id;
                                          });
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 8, 8, 8),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            _profData[i].englishValue,
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
                      SizedBox(height: 32),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(klightPink).withOpacity(0.5),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: kButtonHeight,
                        child: TextButton(
                            onPressed: () {
                              // MyEducation educationData = MyEducation(
                              //   educationLevel: _educationLevel[eduIndex],
                              //   universityId: _selectedUniversityId!,
                              //   professionId: _selectedProfessionId!,
                              //   jobTitle: jobCntrl.text,
                              //   company: companyCntrl.text,
                              // );
                              // myEducationBloc!.add(
                              //     SaveButtonPressed(education: educationData));
                              _onSaveButtonPressed();
                              FocusScope.of(context).unfocus();
                            },
                            style: TextButton.styleFrom(
                                primary: Color(kWhite),
                                padding: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            child: Text(
                              'Failed, retry',
                              style: TextStyle(
                                  fontSize: kButtonFont,
                                  fontWeight: FontWeight.bold,
                                  color: Color(kBlack)),
                            )),
                      )
                    ]));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
