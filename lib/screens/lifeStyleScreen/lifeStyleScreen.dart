import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class LifeStyleScreen extends StatefulWidget {
  @override
  _LifeStyleScreenState createState() =>
      _LifeStyleScreenState();
}

class _LifeStyleScreenState
    extends State<LifeStyleScreen> {

  late String _selectedReligion;
  late String _selectedRnStatus;
  late String _selectedKids;
  late String _selectedWorkout;
  late String _selectedDrinking;
  late String _selectedSmoking;

  List<String> _religions = ['Orthodox', 'Muslim', 'Protestant'];
  List<String> _rnStatuses = ['Married', 'Single'];
  List<String> _kids = ['1', '2', '3'];
  List<String> _workouts = ['Daily', 'Twice a week', 'Thrice a week'];
  List<String> _drinkings = ['Occasionally', 'Daily', 'Never'];
  List<String> _smokings = ['Yes', 'No'];


  @override
  void initState() {
    _selectedReligion = _religions[0];
    _selectedRnStatus = _rnStatuses[0];
    _selectedKids = _kids[0];
    _selectedWorkout = _workouts[0];
    _selectedDrinking = _drinkings[0];
    _selectedSmoking = _smokings[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(kPrimaryPink)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Education & Profession',
          style: TextStyle(
            fontSize: kNormalFont,
            color: Color(kDarkGrey),
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check, color: Color(kPrimaryPink),))],
      ),
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
                          _selectedReligion,
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kDarkGrey)),
                        ),
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
                                        color: Color(kDarkGrey)),
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
                        side: BorderSide(color: Color(kPrimaryPink), width: 2),
                        borderRadius: BorderRadius.circular(16)),
                    color: Color(kPrimaryPink).withOpacity(0.02),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ExpansionTile(
                        title: Text(
                          _selectedRnStatus,
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kDarkGrey)),
                        ),
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
                                        color: Color(kDarkGrey)),
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
                        side: BorderSide(color: Color(kPrimaryPink), width: 2),
                        borderRadius: BorderRadius.circular(16)),
                    color: Color(kPrimaryPink).withOpacity(0.02),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ExpansionTile(
                        title: Text(
                          _selectedKids,
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kDarkGrey)),
                        ),
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
                                        color: Color(kDarkGrey)),
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
                        side: BorderSide(color: Color(kPrimaryPink), width: 2),
                        borderRadius: BorderRadius.circular(16)),
                    color: Color(kPrimaryPink).withOpacity(0.02),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ExpansionTile(
                        title: Text(
                          _selectedWorkout,
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kDarkGrey)),
                        ),
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
                                        color: Color(kDarkGrey)),
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
                        side: BorderSide(color: Color(kPrimaryPink), width: 2),
                        borderRadius: BorderRadius.circular(16)),
                    color: Color(kPrimaryPink).withOpacity(0.02),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ExpansionTile(
                        title: Text(
                          _selectedDrinking,
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kDarkGrey)),
                        ),
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
                                        color: Color(kDarkGrey)),
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
                        side: BorderSide(color: Color(kPrimaryPink), width: 2),
                        borderRadius: BorderRadius.circular(16)),
                    color: Color(kPrimaryPink).withOpacity(0.02),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ExpansionTile(
                        title: Text(
                          _selectedSmoking,
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kDarkGrey)),
                        ),
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
                                        color: Color(kDarkGrey)),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),

              ],
            )),
            Container(
              margin: EdgeInsets.all(4),
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
