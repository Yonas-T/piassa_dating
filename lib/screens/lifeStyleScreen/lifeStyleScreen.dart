import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piassa_application/blocs/lifeStyleBloc/lifeStyleBloc.dart';
import 'package:piassa_application/blocs/lifeStyleBloc/lifeStyleEvent.dart';
import 'package:piassa_application/blocs/lifeStyleBloc/lifeStyleState.dart';
import 'package:piassa_application/blocs/myEducationBloc/myeducationEvent.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/lifeStyle.dart';
import 'package:piassa_application/repositories/lifeStyleRepository.dart';

class LifeStyleScreen extends StatefulWidget {
  LifeStyleRepository lifeStyleRepository = LifeStyleRepository();
  @override
  _LifeStyleScreenState createState() => _LifeStyleScreenState();
}

class _LifeStyleScreenState extends State<LifeStyleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LifeStyleBloc(lifeStyleRepository: widget.lifeStyleRepository)
            ..add(LoadMyLifeStyle()),
      child:
          LifeStyleScreenChild(lifeStyleRepository: widget.lifeStyleRepository),
    );
  }
}

class LifeStyleScreenChild extends StatefulWidget {
  LifeStyleRepository lifeStyleRepository;

  LifeStyleScreenChild({required this.lifeStyleRepository});
  @override
  _LifeStyleScreenChildState createState() => _LifeStyleScreenChildState();
}

class _LifeStyleScreenChildState extends State<LifeStyleScreenChild> {
  late String _selectedReligion;
  late String _selectedRnStatus;
  late String _selectedKids;
  late String _selectedWorkout;
  late String _selectedDrinking;
  late String _selectedSmoking;
  LifeStyle? lifeStyle;

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

    lifeStyle = LifeStyle(
        smooking: 0,
        drinking: 0,
        kids: 0,
        religion: 0,
        physicalExercise: 0,
        relationshipStatus: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onSaveButtonPressed() {
      BlocProvider.of<LifeStyleBloc>(context).add(SaveLifeStyleButtonPressed(
          drinking: lifeStyle!.drinking,
          id: lifeStyle!.id,
          kids: lifeStyle!.kids,
          physicalExercise: lifeStyle!.physicalExercise,
          relationshipStatus: lifeStyle!.relationshipStatus,
          religion: lifeStyle!.religion,
          smooking: lifeStyle!.smooking));
    }

    _onEditButtonPressed() {
      BlocProvider.of<LifeStyleBloc>(context).add(EditLifeStyleButtonPressed(
          drinking: lifeStyle!.drinking,
          id: lifeStyle!.id,
          kids: lifeStyle!.kids,
          physicalExercise: lifeStyle!.physicalExercise,
          relationshipStatus: lifeStyle!.relationshipStatus,
          religion: lifeStyle!.religion,
          smooking: lifeStyle!.smooking));
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
                icon:
                    Icon(Icons.arrow_back, color: Color(klightPink), size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('Life Style',
                  style: TextStyle(
                      fontSize: kTitleBoldFont, color: Color(kBlack))),
            ),
          ),
        ),
        body: BlocListener<LifeStyleBloc, LifeStyleState>(
          listener: (context, state) {
            if (state is LifeStyleSuccessState) {
              Navigator.of(context).pop();
            }
            if (state is LifeStyleLoadedState) {
              setState(() {
                _selectedReligion = state.lifeStyle.religion == 0
                    ? 'Religion'
                    : state.lifeStyle.religion == 1
                        ? 'Orthodox'
                        : state.lifeStyle.religion == 2
                            ? 'Muslim'
                            : state.lifeStyle.religion == 3
                                ? 'Protestant'
                                : 'Religion';
                _selectedRnStatus = state.lifeStyle.relationshipStatus == 0
                    ? 'Relationship status'
                    : state.lifeStyle.relationshipStatus == 1
                        ? 'Married'
                        : state.lifeStyle.relationshipStatus == 2
                            ? 'Single'
                            : 'Relationship status';
                _selectedKids = state.lifeStyle.kids == 0
                    ? 'No'
                    : state.lifeStyle.kids == 1
                        ? '1'
                        : state.lifeStyle.kids == 2
                            ? '2'
                            : state.lifeStyle.kids == 3
                                ? '3'
                                : 'Do you want kids?';
                _selectedWorkout = state.lifeStyle.physicalExercise == 0
                    ? 'Workout'
                    : state.lifeStyle.physicalExercise == 1
                        ? 'Daily'
                        : state.lifeStyle.physicalExercise == 2
                            ? 'Twice a week'
                            : state.lifeStyle.physicalExercise == 3
                                ? 'Thrice a week'
                                : 'Workout';
                _selectedDrinking = state.lifeStyle.drinking == 0
                    ? 'Drinking'
                    : state.lifeStyle.drinking == 1
                        ? 'Occasionally'
                        : state.lifeStyle.drinking == 2
                            ? 'Daily'
                            : state.lifeStyle.drinking == 3
                                ? 'Never'
                                : 'Drinking';
                _selectedSmoking = state.lifeStyle.smooking == 0
                    ? 'Smoking'
                    : state.lifeStyle.smooking == 1
                        ? 'Yes'
                        : state.lifeStyle.smooking == 2
                            ? 'No'
                            : 'Smoking';
              });
            }
          },
          child: BlocBuilder<LifeStyleBloc, LifeStyleState>(
            // bloc: LifeStyleBloc(
            //     lifeStyleRepository: widget.lifeStyleRepository),
            builder: (context, state) {
              print(state);
              if (state is LifeStyleLoadingState) {
                return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(klightPink))));
              }
              if (state is LifeStyleLoadedState) {
                return Container(
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
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedReligion,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _religions.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  lifeStyle!.religion = i;
                                                  _selectedReligion =
                                                      _religions[i];
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedRnStatus,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _rnStatuses.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedRnStatus =
                                                      _rnStatuses[i];
                                                  lifeStyle!
                                                      .relationshipStatus = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _rnStatuses[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedKids,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _kids.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedKids = _kids[i];
                                                  lifeStyle!.kids = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _kids[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedWorkout,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _workouts.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedWorkout =
                                                      _workouts[i];
                                                  lifeStyle!.physicalExercise =
                                                      i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _workouts[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedDrinking,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _drinkings.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedDrinking =
                                                      _drinkings[i];
                                                  lifeStyle!.drinking = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _drinkings[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedSmoking,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _smokings.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedSmoking =
                                                      _smokings[i];
                                                  lifeStyle!.smooking = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _smokings[i],
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
                            SizedBox(height: 12),
                            Container(
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(kLightGrey).withOpacity(0.5),
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: kButtonHeight,
                              child: TextButton(
                                  onPressed: () {
                                    _onEditButtonPressed();
                                  },
                                  style: TextButton.styleFrom(
                                      primary: Color(kWhite),
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontSize: kButtonFont,
                                        color: Color(kBlack)),
                                  )),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              if (state is LifeStyleInitialState) {
                return Container(
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
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedReligion,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _religions.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  lifeStyle!.religion = i;
                                                  _selectedReligion =
                                                      _religions[i];
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedRnStatus,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _rnStatuses.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedRnStatus =
                                                      _rnStatuses[i];
                                                  lifeStyle!
                                                      .relationshipStatus = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _rnStatuses[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedKids,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _kids.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedKids = _kids[i];
                                                  lifeStyle!.kids = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _kids[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedWorkout,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _workouts.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedWorkout =
                                                      _workouts[i];
                                                  lifeStyle!.physicalExercise =
                                                      i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _workouts[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedDrinking,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _drinkings.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedDrinking =
                                                      _drinkings[i];
                                                  lifeStyle!.drinking = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _drinkings[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedSmoking,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _smokings.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedSmoking =
                                                      _smokings[i];
                                                  lifeStyle!.smooking = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _smokings[i],
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
                            SizedBox(height: 12),
                            Container(
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(kLightGrey).withOpacity(0.5),
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: kButtonHeight,
                              child: TextButton(
                                  onPressed: () {
                                    _onSaveButtonPressed();
                                  },
                                  style: TextButton.styleFrom(
                                      primary: Color(kWhite),
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontSize: kButtonFont,
                                        color: Color(kBlack)),
                                  )),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              if (state is LifeStyleFailState) {
                return Container(
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
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedReligion,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _religions.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  lifeStyle!.religion = i;
                                                  _selectedReligion =
                                                      _religions[i];
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedRnStatus,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _rnStatuses.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedRnStatus =
                                                      _rnStatuses[i];
                                                  lifeStyle!
                                                      .relationshipStatus = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _rnStatuses[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedKids,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _kids.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedKids = _kids[i];
                                                  lifeStyle!.kids = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _kids[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedWorkout,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _workouts.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedWorkout =
                                                      _workouts[i];
                                                  lifeStyle!.physicalExercise =
                                                      i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _workouts[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedDrinking,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _drinkings.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedDrinking =
                                                      _drinkings[i];
                                                  lifeStyle!.drinking = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _drinkings[i],
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
                            SizedBox(height: 12),
                            Container(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color(kLightGrey).withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                color: Color(kWhite).withOpacity(0.3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: ExpansionTile(
                                    key: GlobalKey(),
                                    title: Text(
                                      _selectedSmoking,
                                      style: TextStyle(
                                          fontSize: kNormalFont,
                                          color: Color(kBlack)),
                                    ),
                                    collapsedIconColor: Color(klightPink),
                                    iconColor: Color(klightPink),
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: _smokings.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedSmoking =
                                                      _smokings[i];
                                                  lifeStyle!.smooking = i;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 8, 8, 8),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _smokings[i],
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
                            SizedBox(height: 12),
                            Container(
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(kLightGrey).withOpacity(0.5),
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: kButtonHeight,
                              child: TextButton(
                                  onPressed: () {
                                    _onSaveButtonPressed();
                                  },
                                  style: TextButton.styleFrom(
                                      primary: Color(kWhite),
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  child: Text(
                                    'Failed, Retry',
                                    style: TextStyle(
                                        fontSize: kButtonFont,
                                        color: Color(kBlack)),
                                  )),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ));
  }
}
