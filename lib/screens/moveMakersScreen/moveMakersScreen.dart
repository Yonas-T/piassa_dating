import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';

class MoveMakersScreen extends StatefulWidget {
  @override
  _MoveMakersScreenState createState() => _MoveMakersScreenState();
}

class _MoveMakersScreenState extends State<MoveMakersScreen> {
  TextEditingController movieCntrl = TextEditingController();
  TextEditingController bandCntrl = TextEditingController();
  TextEditingController petCntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(
            title: Text('Move Makers', style: TextStyle(fontSize: kTitleBoldFont, color: Color(kDarkGrey))),
            actionIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                color: Color(kPrimaryPink),
              ),
            ),
            leadingIcon: Container(),
            colorVal: Color(kWhite)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: 32),
                  TextField(
                    controller: movieCntrl,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color(kDarkGrey).withOpacity(0.02),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(kDarkGrey), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(kDarkGrey), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(kDarkGrey), width: 1)),
                      hintText: "Your favorite movie",
                      hintStyle: TextStyle(
                          color: Color(kDarkGrey), fontSize: kNormalFont),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: bandCntrl,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color(kDarkGrey).withOpacity(0.02),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(kDarkGrey), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(kDarkGrey), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(kDarkGrey), width: 1)),
                      hintText: "Your favorite movie",
                      hintStyle: TextStyle(
                          color: Color(kDarkGrey), fontSize: kNormalFont),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: petCntrl,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color(kDarkGrey).withOpacity(0.02),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(kDarkGrey), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(kDarkGrey), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(kDarkGrey), width: 1)),
                      hintText: "Your pet's name",
                      hintStyle: TextStyle(
                          color: Color(kDarkGrey), fontSize: kNormalFont),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
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
                    'Save',
                    style: TextStyle(
                        fontSize: kNormalFont, color: Color(kDarkGrey)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
