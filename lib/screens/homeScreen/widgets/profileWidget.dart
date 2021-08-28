import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piassa_application/blocs/searchBloc/searchBloc.dart';
import 'package:piassa_application/blocs/searchBloc/searchEvent.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/repositories/searchRepository.dart';
import 'package:piassa_application/screens/homeScreen/widgets/iconWidget.dart';
import 'package:piassa_application/screens/homeScreen/widgets/userGender.dart';

import './photoWidget.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  var padding;
  var photoHeight;
  var photoWidth;
  var clipRadius;
  Peoples userData;
  var containerHeight;
  var containerWidth;
  var userId;

  ProfileWidget(
      {this.clipRadius,
      required this.userId,
      required this.userData,
      this.containerHeight,
      this.containerWidth,
      this.padding,
      this.photoHeight,
      this.photoWidth});

  late Peoples _currentUser;
  int difference = 0;
  int currentCardIndex = 0;
  final SearchRepository _searchRepository = SearchRepository();
  late SearchBloc _searchBloc;

  getDifference(GeoPoint userLocation) async {
    Position position = await Geolocator.getCurrentPosition();

    double location = Geolocator.distanceBetween(userLocation.latitude,
        userLocation.longitude, position.latitude, position.longitude);

    difference = location.toInt();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.005),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(10.0, 10.0),
            )
          ],
          borderRadius: BorderRadius.circular(size.height * 0.02),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              width: size.width * 0.95,
              height: size.height * 0.824,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.height * 0.02),
                child: PhotoWidget(
                  photoLink: userData.profilePictureURL,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.black54,
                    Colors.black87,
                    Colors.black
                  ], stops: [
                    0.1,
                    0.2,
                    0.4,
                    0.9
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  color: Colors.black45,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(size.height * 0.02),
                    bottomRight: Radius.circular(size.height * 0.02),
                  )),
              width: size.width * 0.9,
              height: size.height * 0.3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    Row(
                      children: <Widget>[
                        userGender(userData.gender),
                        Expanded(
                          child: Text(
                            " " + userData.name + ", ",
                            // +
                            // (DateTime.now().year - userData.age.toDate().year)
                            //     .toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.05),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        Text(
                          difference != null
                              ? (difference / 1000).floor().toString() +
                                  "km away"
                              : "away",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        iconWidget(Icons.clear, () {
                          _searchBloc.add(PassUserEvent(userId, userData.id));
                        }, size.height * 0.08, Colors.blue),
                        iconWidget(FontAwesomeIcons.solidHeart, () {
                          _searchBloc.add(
                            SelectUserEvent(userId, userData.id, _currentUser.name,
                                _currentUser.profilePictureURL),
                          );
                        }, size.height * 0.06, Colors.red),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
