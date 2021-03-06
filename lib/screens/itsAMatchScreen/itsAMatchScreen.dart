import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class ItsAMatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[Color(kPrimaryPink), Color(kPrimaryPurple)],
        ),
      ),
      child: Center(
          child: Stack(
        children: [
          Positioned(
            top: (MediaQuery.of(context).size.height / 2) - 170,
            left: (MediaQuery.of(context).size.width / 2) - 100,
            child: Text(
              'It\'s a Match',
              style: TextStyle(fontSize: kExtraLargeFont, color: Color(kWhite)),
            ),
          ),
          Positioned(
            bottom: (MediaQuery.of(context).size.height / 2) - 170,
            left: (MediaQuery.of(context).size.width / 2) - 105,
            child: Text(
              'Excepteur sint occaecat cupidatat',
              style: TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
            ),
          ),
          Positioned(
            bottom: (MediaQuery.of(context).size.height / 2) - 190,
            left: (MediaQuery.of(context).size.width / 2) - 140,
            child: Text(
              'non proident, sunt in culpa qui officia deserunt',
              style: TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
            ),
          ),
          Positioned(
            bottom: (MediaQuery.of(context).size.height / 2) - 210,
            left: (MediaQuery.of(context).size.width / 2) - 85,
            child: Text(
              'mollit anim id est laborum.',
              style: TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 2) - 70,
            left: (MediaQuery.of(context).size.width / 2) - 25,
            child: Container(
              height: 176,
              width: 176,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[Color(0XFFC52E96), Color(0XFFA827BE)],
                ),
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/474x/6b/7b/c5/6b7bc5c72055477530ef21012ad0fcae.jpg'),
                  radius: 80,
                ),
              ),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 2) - 70,
            left: (MediaQuery.of(context).size.width / 2) - 135,
            child: Container(
              height: 176,
              width: 176,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[Color(0XFFC52E96), Color(0XFFA827BE)],
                ),
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/portrait-young-beautiful-african-girl-dark-wall_176420-5818.jpg?size=626&ext=jpg'),
                  radius: 80,
                ),
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
