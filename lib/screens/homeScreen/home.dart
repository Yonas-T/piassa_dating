import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:swipeable_card/swipeable_card.dart';

import 'package:piassa_application/blocs/searchBloc/searchBloc.dart';
import 'package:piassa_application/blocs/searchBloc/searchEvent.dart';
import 'package:piassa_application/blocs/searchBloc/searchState.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/repositories/searchRepository.dart';
import 'package:piassa_application/screens/homeScreen/widgets/iconWidget.dart';
import 'package:piassa_application/screens/homeScreen/widgets/profileWidget.dart';
import 'package:piassa_application/screens/homeScreen/widgets/userGender.dart';

class Home extends StatefulWidget {
  final String userId;

  const Home({Key? key, required this.userId}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SearchRepository _searchRepository = SearchRepository();
  late SearchBloc _searchBloc;
  late Peoples _user, _currentUser;
  int difference = 0;
  int currentCardIndex = 0;

  getDifference(GeoPoint userLocation) async {
    Position position = await Geolocator.getCurrentPosition();

    double location = Geolocator.distanceBetween(userLocation.latitude,
        userLocation.longitude, position.latitude, position.longitude);

    difference = location.toInt();
  }

  void swipeLeft() {
    print("left");

    // NOTE: it is your job to change the card
    setState(() => currentCardIndex++);
  }

  void swipeRight() {
    print("right");
    setState(() => currentCardIndex++);
  }

  List<Peoples> profileData = [];

  List<ProfileWidget> getProfileWidgets() {
    List<ProfileWidget> list = [];
      print('in get profile widget: ${profileData.length}');

    for (var i = 0; i < profileData.length; i++) {
      list.add(ProfileWidget(

        userId: widget.userId,
        userData: profileData[i],
      ));
    }
    return list;
  }

  @override
  void initState() {
    _searchBloc = SearchBloc(searchRepository: _searchRepository);

    profileData.add(Peoples(
        name: 'Test Person',
        id: '1',
        time: '10:00',
        gender: 'female',
        location: GeoPoint(10, 10),
        profilePictureURL:
            'https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg',
        lastMessage: 'Hey There'));
    profileData.add(Peoples(
        name: 'Another Person',
        id: '2',
        time: '04:00',
        gender: 'female',
        location: GeoPoint(10, 10),
        profilePictureURL:
            'https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg',
        lastMessage: 'Hello'));
    // getDifference(GeoPoint(10, 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable 
    SwipeableWidgetController _cardController = SwipeableWidgetController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<SearchBloc, SearchState>(
        bloc: _searchBloc,
        builder: (context, state) {
          if (state is InitialSearchState) {
            _searchBloc.add(
              LoadUserEvent(widget.userId),
            );
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(kPrimaryPurple)),
              ),
            );
          }
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(kPrimaryPurple)),
              ),
            );
          }
          if (state is LoadUserState) {
            _user = state.people;
            _currentUser = state.currentUser;

            getDifference(_user.location);
            // ignore: unnecessary_null_comparison
            if (_user.location == null) {
              return Text(
                "No One Here",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              );
            } else
              return currentCardIndex < profileData.length
                  ? Column(
                      children: [
                        SizedBox(height: 70),
                        SwipeableWidget(
                          key: ObjectKey(currentCardIndex),
                          animationDuration: 800,
                          child: getProfileWidgets()[currentCardIndex],
                          onLeftSwipe: () => swipeLeft(),
                          onRightSwipe: () => swipeRight(),
                          nextCards: <Widget>[
                            // show next card
                            // if there are no next cards, show nothing
                            if (!(currentCardIndex + 1 >= profileData.length))
                              Align(
                                alignment: Alignment.center,
                                child: getProfileWidgets()[currentCardIndex + 1],
                              ),
                          ],
                        ),
                        // if (currentCardIndex < profileData.length)
                        //   cardControllerRow(_cardController),
                      ],
                    )
                  : currentCardIndex == profileData.length ?Container(
                    child: Center(
                      child: Text(
                        'You finished your daily recommendation',
                        style: TextStyle(
                          fontSize: kNormalFont,
                          color: Color(kDarkGrey)
                        ),
                      ),
                    ),
                  ) : Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget cardControllerRow(SwipeableWidgetController cardController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          child: Text("Left"),
          onPressed: () => cardController.triggerSwipeLeft(),
        ),
        TextButton(
          child: Text("Right"),
          onPressed: () => cardController.triggerSwipeRight(),
        ),
      ],
    );
  }
}
