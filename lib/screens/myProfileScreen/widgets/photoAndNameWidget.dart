import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class PhotoAndNameWidget extends StatefulWidget {
  
  @override
  _PhotoAndNameWidgetState createState() => _PhotoAndNameWidgetState();
}

class _PhotoAndNameWidgetState extends State<PhotoAndNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg'),
          radius: 64,
          child: Align(
              alignment: Alignment.bottomRight,
              child: Card(
                shape: CircleBorder(),
                elevation: 4,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      size: 24.0,
                      color: Color(kDarkGrey),
                    ),
                  ),
                ),
              ),
            ),
        ),
        SizedBox(height: 4),
        Text('Name', style: TextStyle(fontSize: kLargeFont, color: Color(kBlack)),)
      ],
    );
  }
}