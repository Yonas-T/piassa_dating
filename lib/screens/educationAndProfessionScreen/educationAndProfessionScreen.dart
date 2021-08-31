import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';

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

  List<String> _universities = ['AAU', 'JU', 'BDU'];
  List<String> _professions = ['Lawyer', 'Accountant', 'Engineer'];

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
            leadingIcon: IconButton(
              icon:
                  Icon(Icons.arrow_back, color: Color(klightPink), size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Education and Profession', style: TextStyle(fontSize: kTitleBoldFont, fontWeight: FontWeight.bold, color: Color(kBlack))),
          ),
        ),
      ),
      // AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white10,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Color(kLightGrey).withOpacity(0.5)),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text(
      //     'Education & Profession',
      //     style: TextStyle(
      //       fontSize: kNormalFont,
      //       color: Color(kDarkGrey),
      //     ),
      //   ),
      // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check, color: Color(kLightGrey).withOpacity(0.5),))],
      // ),
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
                  Container(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(kLightGrey).withOpacity(0.5), width: 1),
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
                          side: BorderSide(color: Color(kLightGrey).withOpacity(0.5), width: 1),
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
                          borderSide:
                              BorderSide(color: Color(kLightGrey).withOpacity(0.5), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              BorderSide(color: Color(kLightGrey).withOpacity(0.5), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              BorderSide(color: Color(kLightGrey).withOpacity(0.5), width: 1)),
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
                          borderSide:
                              BorderSide(color: Color(kLightGrey).withOpacity(0.5), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              BorderSide(color: Color(kLightGrey).withOpacity(0.5), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              BorderSide(color: Color(kLightGrey).withOpacity(0.5), width: 1)),
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
                  border: Border.all(color: Color(klightPink).withOpacity(0.5), width: 1),
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
                          fontSize: kButtonFont, fontWeight: FontWeight.bold, color: Color(kBlack)),
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
