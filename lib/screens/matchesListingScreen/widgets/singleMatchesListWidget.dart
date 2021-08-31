import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/screens/homeScreen/widgets/photoWidget.dart';
import 'package:piassa_application/screens/homeScreen/widgets/userGender.dart';

class SingleMatchesListWidget extends StatefulWidget {
  var padding;
  var photoHeight;
  var photoWidth;
  var clipRadius;
  Peoples userData;
  var containerHeight;
  var containerWidth;
  var userId;

  SingleMatchesListWidget({this.clipRadius, this.containerHeight, this.containerWidth, this.padding, this.photoHeight, this.photoWidth, required this.userData, this.userId});
  @override
  _SingleMatchesListWidgetState createState() => _SingleMatchesListWidgetState();
}

class _SingleMatchesListWidgetState extends State<SingleMatchesListWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              width: size.width * 0.45,
              height: size.height * 0.7,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: PhotoWidget(
                  photoLink: widget.userData.profilePictureURL,
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
             width: size.width * 0.4,
              height: size.height * 0.18,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    Row(
                      children: <Widget>[
                        userGender(widget.userData.gender),
                        Expanded(
                          child: Text(
                            " " + widget.userData.name + " ,22 ",
                            // +
                            // (DateTime.now().year - userData.age.toDate().year)
                            //     .toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 8,
                        ),
                        Text(
                          "Addis Ababa",
                          style: TextStyle(color: Colors.white, fontSize: kExtraSmallFont)
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: <Widget>[
                    //     iconWidget(Icons.clear, () {
                    //       _searchBloc.add(PassUserEvent(userId, userData.id));
                    //     }, size.height * 0.08, Colors.blue),
                    //     iconWidget(FontAwesomeIcons.solidHeart, () {
                    //       _searchBloc.add(
                    //         SelectUserEvent(userId, userData.id, _currentUser.name,
                    //             _currentUser.profilePictureURL),
                    //       );
                    //     }, size.height * 0.06, Colors.red),
                    //   ],
                    // )
                  ],
                ),
              ),
            )
          ],
        );
  }
}
