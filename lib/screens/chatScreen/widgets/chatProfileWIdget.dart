import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:datingappmain/commons/userProfileCommon.dart';
// import 'package:datingappmain/setting/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/screens/homeScreen/widgets/fullPhotoWidget.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.userData, this.parentClassType);

  UserData userData;
  ParentClassType parentClassType;

  @override
  State createState() => new _UserProfile();
}

class _UserProfile extends State<UserProfile> with userProfileCommon {
  List<Choice> choices = <Choice>[
    const Choice(title: 'Edit', icon: Icons.edit),
    const Choice(title: 'Delete', icon: Icons.delete_outline),
  ];

  void _select(Choice choice) {
    if (choice.title == 'Edit') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(widget.userData.name,
                widget.userData.intro, widget.userData.userImages.first)),
      );
    } else {
      _showDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                widget.userData.name,
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              actions: <Widget>[
                widget.userData.name == myProfileName
                    ? PopupMenuButton<Choice>(
                        onSelected: _select,
                        itemBuilder: (BuildContext context) {
                          return choices.map((Choice choice) {
                            return PopupMenuItem<Choice>(
                              value: choice,
                              child: Row(
                                children: <Widget>[
                                  Icon(choice.icon),
                                  Text(' ${choice.title}'),
                                ],
                              ),
                            );
                          }).toList();
                        },
                      )
                    : Container(),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GestureDetector(
                          child: Container(
                            height: size.height,
                            width: size.width - 14,
                            color: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: CachedNetworkImage(
                                imageUrl: widget.userData.userImages.first,
                                placeholder: (context, url) => Container(
                                  transform:
                                      Matrix4.translationValues(0.0, 0.0, 0.0),
                                  child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.77,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Color(klightPink))))),
                                ),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.77,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => FullPhoto(
                          //               imageUrlList:
                          //                   widget.userData.userImages,
                          //               initIndex: 0,
                          //             ))),
                        ),
                        Positioned(
                            bottom: 4,
                            left: 4,
                            child: userInformation(widget.userData, size)),
                      ],
                    ),
                  ),
                  widget.parentClassType == ParentClassType.Lounge
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: bottomIconDataList
                                .map(bottomButtonWidget)
                                .toList(),
                          ),
                        )
                      : Container()
                ],
              ),
            )),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Do you want to delete your profile?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new MaterialButton(
              child: new Text(
                "No",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new MaterialButton(
              child: new Text(
                "Yes",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class EditProfile extends StatefulWidget {
  EditProfile(this.userName, this.userIntro, this.userThumbnail);

  String userName;
  String userIntro;
  String userThumbnail;
  @override
  State createState() => new _EditProfile();
}

enum GenderEnum { man, woman }

class _EditProfile extends State<EditProfile> {
  GenderEnum _userGender = GenderEnum.man;
  String _selectDateString = '1996-06-11';
  List<File> _imageList = List<File>.generate(4, (file) => File(''));

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 22, DateTime.now().month),
        firstDate: DateTime(
            DateTime.now().year - 60, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month,
            DateTime.now().day));
    if (picked != null && picked != DateTime.now())
      setState(() {
        _selectDateString = "${picked.toLocal()}".split(' ')[0];
      });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black, //change
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/40/97/a9/4097a9be2792b98cd3c1ed69088ec42f.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _userForm(),
                  _userPhotos(size),
                  _userIntro()
                ],
              ),
            ),
          ),
        ));
  }

  Widget _userIntro() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 6.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Introduce',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                width: 380,
                height: 200,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Type about you'),
                    controller: TextEditingController(text: widget.userIntro),
                  ),
                ))),
          ),
        ],
      ),
    );
  }

  Widget _userPhotos(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0, bottom: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 6.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Your photos',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new GestureDetector(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.width * 0.5,
                        child: Card(
                            child: Image.network(
                          widget.userThumbnail,
                          fit: BoxFit.fill,
                        )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new GestureDetector(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.width * 0.5,
                        child: Card(
                            child: Image.network(
                          'https://cdn.pixabay.com/photo/2016/03/27/17/40/black-and-white-1283231_1280.jpg',
                          fit: BoxFit.fill,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: size.width * 0.4,
                      height: size.width * 0.5,
                      child: Card(
                          child: (_imageList[2].path != '')
                              ? Image.file(
                                  _imageList[2],
                                  fit: BoxFit.fill,
                                )
                              : Icon(Icons.add_photo_alternate,
                                  size: 110, color: Colors.grey[700])),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: size.width * 0.4,
                      height: size.width * 0.5,
                      child: Card(
                          child: (_imageList[3].path != '')
                              ? Image.file(
                                  _imageList[3],
                                  fit: BoxFit.fill,
                                )
                              : Icon(Icons.add_photo_alternate,
                                  size: 110, color: Colors.grey[700])),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _userForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Personal Information',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.account_circle),
                        labelText: 'Name',
                        hintText: 'Type Name'),
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return 'Name is required';
                      } else {
                        return null;
                      }
                    },
                    controller: TextEditingController(text: myProfileName),
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.wc,
                      color: Colors.grey,
                    ),
                    Radio(
                      value: GenderEnum.man,
                      groupValue: _userGender,
                      onChanged: (GenderEnum? value) {
                        setState(() {
                          _userGender = value!;
                        });
                      },
                    ),
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          _userGender = GenderEnum.man;
                        });
                      },
                      child: Text('Man'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Radio(
                      value: GenderEnum.woman,
                      groupValue: _userGender,
                      onChanged: (GenderEnum? value) {
                        setState(() {
                          _userGender = value!;
                        });
                      },
                    ),
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          _userGender = GenderEnum.woman;
                        });
                      },
                      child: Text('Woman'),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  width: 360,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.cake,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Container(
                          width: 260,
                          child: ElevatedButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            child: Text(_selectDateString),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

mixin userProfileCommon {
  CardController cardController = CardController();

  Widget userInformation(UserData userData, Size size) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  userData.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 36,
                      shadows: [
                        Shadow(
                            blurRadius: 1.0,
                            color: Colors.black,
                            offset: Offset(0.6, 0.6))
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  userData.information,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      shadows: [
                        Shadow(
                            blurRadius: 1.0,
                            color: Colors.black,
                            offset: Offset(0.6, 0.6))
                      ]),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 12),
            child: Container(
              width: size.width - 20,
              child: Text(
                userData.intro,
                softWrap: true,
                style: TextStyle(fontSize: 22, color: Colors.white, shadows: [
                  Shadow(
                      blurRadius: 1.0,
                      color: Colors.black,
                      offset: Offset(0.6, 0.6))
                ]),
              ),
            ),
          ),
          Wrap(
            children: userData.interesting.map(interestingWidget).toList(),
          ),
        ],
      ),
    );
  }

  Widget interestingWidget(String interesting) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[700]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
          child: Text(
            interesting,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget bottomButtonWidget(BottomButtonData data) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new RawMaterialButton(
          onPressed: () {
            if (data.iconData == FontAwesomeIcons.times) {
              cardController.triggerLeft();
            } else if (data.iconData == FontAwesomeIcons.solidHeart) {
              cardController.triggerRight();
            } else if (data.iconData == FontAwesomeIcons.solidStar) {
              cardController.triggerUp();
            }
          },
          child: new FaIcon(
            data.iconData,
            color: data.iconColor,
            size: (data.iconData == FontAwesomeIcons.times ||
                    data.iconData == FontAwesomeIcons.solidHeart)
                ? 32.0
                : 20,
          ),
          shape: new CircleBorder(),
          elevation: 1.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(14.0),
        ),
      ),
    );
  }
}

enum ParentClassType {
  Lounge,
  Chat,
  EditProfile,
}

class BottomButtonData {
  IconData iconData;
  Color iconColor;
  BottomButtonData(this.iconData, this.iconColor);
}

class UserData {
  String name;
  String information;
  String intro;
  List<String> userImages;
  List<String> interesting;

  UserData(this.name, this.information, this.intro, this.userImages,
      this.interesting);
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

const chat1Image =
    'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const chat2Image =
    'https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const myProfileImage =
    'https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const myProfileName = 'James';

List<BottomButtonData> bottomIconDataList = [
  BottomButtonData(FontAwesomeIcons.redoAlt, Color(klightPink)),
  BottomButtonData(FontAwesomeIcons.times, Color(klightPink)),
  BottomButtonData(FontAwesomeIcons.solidStar, Color(klightPink)),
  BottomButtonData(FontAwesomeIcons.solidHeart, Color(klightPink)),
  BottomButtonData(FontAwesomeIcons.bolt, Color(klightPink)),
];
