import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/profile.dart';
import 'package:piassa_application/screens/chatScreen/widgets/chatProfileWIdget.dart';
import 'package:piassa_application/screens/profileScreen/profileScreen.dart';
import 'package:piassa_application/screens/settingsScreen/settingsScreen.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(this.userName, this.userinfor, this.userIntro, this.userThumbnail);

  String userThumbnail;
  String userName;
  String userinfor;
  String userIntro;

  @override
  State<StatefulWidget> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(klightPink),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBarWidget(
              actionIcon: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Card(
                  shape: CircleBorder(),
                  shadowColor: Colors.grey,
                  elevation: 4,
                  color: Color(kWhite),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SettingsScreen();
                        }));
                      },
                      icon: Icon(
                        FontAwesomeIcons.slidersH,
                        color: Color(kDarkGrey),
                        size: 17,
                      )),
                ),
              ),
              colorVal: Color(klightPink),
              leadingWidth: 60,
              leadingIcon: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: CircleAvatar(
                  radius: 6,
                  backgroundImage: NetworkImage(
                    'https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg',
                  ),
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.arrow_back, color: Color(kPrimaryPink)),
              //   onPressed: () => Navigator.of(context).pop(),
              // ),
              title: Column(
                children: [
                  SizedBox(height: 4),
                  Text(
                    'Helina',
                    style: TextStyle(
                      fontSize: kTitleBoldFont,
                      fontWeight: FontWeight.bold,
                      color: Color(kWhite),
                    ),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                      fontSize: kSmallFont,
                      fontWeight: FontWeight.bold,
                      color: Color(kWhite),
                    ),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(kWhite),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Center(
                  child: ListView(children: [
                    _listItemOther(
                        context,
                        widget.userName,
                        widget.userThumbnail,
                        'Hello What are you doing?',
                        '11:30pm'),
                    _listItemOther(context, widget.userName,
                        widget.userThumbnail, 'How are you?', '11:41pm'),
                    _listItemMine(context, 'Nothing!', '11:51pm'),
                    _listItemMine(
                        context,
                        'Hello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHello',
                        '11:51pm')
                  ]),
                )),
                _buildTextComposer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listItemOther(BuildContext context, String name, String thumbnail,
      String message, String time) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProfileScreen();
                      }));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           // Profile(name: widget.userName, city: 'AA', age: '22', height: '1.63', education: 'Degree', occupation: 'Singer', religion: 'Catholic', sport: 'Daily', drink: 'drink', bio: 'I\'m a user', imageUrl: 'imageUrl');
                      //           UserProfile(
                      //               UserData(
                      //                   widget.userName,
                      //                   widget.userinfor,
                      //                   widget.userIntro,
                      //                   [widget.userThumbnail],
                      //                   ['Sleep', 'Movie']),
                      //               ParentClassType.Chat)),
                      // );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(
                          'https://img.freepik.com/free-photo/portrait-young-beautiful-african-girl-dark-wall_176420-5818.jpg?size=626&ext=jpg',
                          height: 60,
                          fit: BoxFit.cover,
                          width: 60),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: size.width - 150),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Text(
                              message,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Color(klightPink).withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            time,
                            style: TextStyle(
                                color: Color(kWhite),
                                fontSize: kExtraSmallFont),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItemMine(BuildContext context, String message, String time) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 14.0, right: 4, left: 8),
          //   child: Text(time),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                  constraints: BoxConstraints(maxWidth: size.width - 150),
                  decoration: BoxDecoration(
                    color: Color(klightPink).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Text(
                        message,
                        style: TextStyle(color: Color(kBlack)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
                width: 35,
                decoration: BoxDecoration(
                  color: Color(klightPink).withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      time,
                      style: TextStyle(
                          color: Color(kWhite), fontSize: kExtraSmallFont),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      //
      data: IconThemeData(color: Theme.of(context).accentColor), //
      child: Container(
        //modified
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            InkWell(
              onTap: () => _handleSubmitted(_textController.text),
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                    color: Color(klightPink),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16))),
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Send',
                    style: TextStyle(
                        color: Color(kWhite),
                        fontSize: kNormalFont,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitted(String text) async {
    try {} catch (e) {
      print(e);
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         content: Text(e.message),
      //       );
      //     }
      // );
    }
  }
}
