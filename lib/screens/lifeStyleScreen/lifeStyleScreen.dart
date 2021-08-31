import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';

class LifeStyleScreen extends StatefulWidget {
  @override
  _LifeStyleScreenState createState() => _LifeStyleScreenState();
}

class _LifeStyleScreenState extends State<LifeStyleScreen> {
  late String _selectedReligion;
  late String _selectedRnStatus;
  late String _selectedKids;
  late String _selectedWorkout;
  late String _selectedDrinking;
  late String _selectedSmoking;

  List<String> _religions = ['Orthodox', 'Muslim', 'Protestant'];
  List<String> _rnStatuses = ['Married', 'Single'];
  List<String> _kids = ['No', '1', '2', '3'];
  List<String> _workouts = ['Daily', 'Twice a week', 'Thrice a week'];
  List<String> _drinkings = ['Occasionally', 'Daily', 'Never'];
  List<String> _smokings = ['Yes', 'No'];

  @override
  void initState() {
    _selectedReligion = 'Religion';
    _selectedRnStatus = 'Relationship status';
    _selectedKids = "Do you want kids?";
    _selectedWorkout = 'Workout ';
    _selectedDrinking = 'Drinking';
    _selectedSmoking = 'Smoking';

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
              icon: Icon(Icons.arrow_back, color: Color(klightPink), size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Life Style',
                style: TextStyle(
                    fontSize: kTitleBoldFont, color: Color(kBlack))),
          ),
        ),
      ),
      body: Container(
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
                        side: BorderSide(
                            color: Color(kLightGrey).withOpacity(0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    color: Color(kWhite).withOpacity(0.3),
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
                                  child: Text(
                                    _religions[i],
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
                SizedBox(height: 12),
                Container(
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color(kLightGrey).withOpacity(0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    color: Color(kWhite).withOpacity(0.3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: ExpansionTile(
                        title: Text(
                          _selectedRnStatus,
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
                              itemCount: _rnStatuses.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _rnStatuses[i],
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
                SizedBox(height: 12),
                Container(
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color(kLightGrey).withOpacity(0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    color: Color(kWhite).withOpacity(0.3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: ExpansionTile(
                        title: Text(
                          _selectedKids,
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
                              itemCount: _kids.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _kids[i],
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
                SizedBox(height: 12),
                Container(
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color(kLightGrey).withOpacity(0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    color: Color(kWhite).withOpacity(0.3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: ExpansionTile(
                        title: Text(
                          _selectedWorkout,
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
                              itemCount: _workouts.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _workouts[i],
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
                SizedBox(height: 12),
                Container(
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color(kLightGrey).withOpacity(0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    color: Color(kWhite).withOpacity(0.3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: ExpansionTile(
                        title: Text(
                          _selectedDrinking,
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
                              itemCount: _drinkings.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _drinkings[i],
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
                SizedBox(height: 12),
                Container(
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color(kLightGrey).withOpacity(0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    color: Color(kWhite).withOpacity(0.3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: ExpansionTile(
                        title: Text(
                          _selectedSmoking,
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
                              itemCount: _smokings.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _smokings[i],
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
                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(kLightGrey).withOpacity(0.5), width: 1),
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
                            fontSize: kButtonFont, color: Color(kBlack)),
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
