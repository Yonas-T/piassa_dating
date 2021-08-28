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
    _selectedUniversity = _universities[0];
    _selectedProfession = _professions[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBarWidget(
          actionIcon: IconButton(onPressed: () {}, icon: Icon(Icons.check, color: Color(kPrimaryPink),)),
          colorVal: Color(kDarkGrey),
          leadingIcon: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(kPrimaryPink)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: 'education',
        ),
      ),
      // AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white10,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Color(kPrimaryPink)),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text(
      //     'Education & Profession',
      //     style: TextStyle(
      //       fontSize: kNormalFont,
      //       color: Color(kDarkGrey),
      //     ),
      //   ),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check, color: Color(kPrimaryPink),))],
      // ),
      body: Container(
        padding: EdgeInsets.all(8),
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
                        side: BorderSide(color: Color(kPrimaryPink), width: 2),
                        borderRadius: BorderRadius.circular(16)),
                    color: Color(kPrimaryPink).withOpacity(0.02),
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
                SizedBox(height: 32),
                Container(
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(kPrimaryPink), width: 2),
                        borderRadius: BorderRadius.circular(16)),
                    color: Color(kPrimaryPink).withOpacity(0.02),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ExpansionTile(
                        title: Text(
                          _selectedProfession,
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
                                    _professions[i],
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
                    fillColor: Color(kPrimaryPink).withOpacity(0.02),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Color(kPrimaryPink), width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Color(kPrimaryPink), width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Color(kPrimaryPink), width: 2)),
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
                    fillColor: Color(kPrimaryPink).withOpacity(0.02),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Color(kPrimaryPink), width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Color(kPrimaryPink), width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Color(kPrimaryPink), width: 2)),
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
                  color: Color(kPrimaryPink),
                  width: 2
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)),

                boxShadow: [
                  BoxShadow(
                      color: Color(kPrimaryPink).withOpacity(0.5),
                      offset: Offset(0.0, 5.0),
                      blurRadius: 20.0)
                ],
              ),
              width: MediaQuery.of(context).size.width,
              height: kButtonHeight,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(kWhite),
                    padding: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: kNormalFont, color: Color(kDarkGrey)),
                  )),
            ),
            SizedBox(height: 48,),
          ],
        ),
      ),
    );
  }
}
