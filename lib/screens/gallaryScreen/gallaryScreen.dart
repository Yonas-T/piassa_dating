import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';

class GallaryScreen extends StatefulWidget {

  @override
  _GallaryScreenState createState() => _GallaryScreenState();
}

class _GallaryScreenState extends State<GallaryScreen> {
XFile? _image;
final ImagePicker _picker = ImagePicker();

  _imgFromCamera() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kWhite),
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
            title: Text('Preference',
                style: TextStyle(
                    fontSize: kTitleBoldFont, color: Color(kBlack))),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text('Gallery', style: TextStyle(color: Color(kBlack), fontSize: kTitleFont)),
            SizedBox(height: 16),
            Row(
              children: [
                _image == null? Container() : Container(child: Image.file(File(_image!.path))),
                _image == null? Container() : Container(child: Image.file(File(_image!.path)))
                
              ]
            ),
            SizedBox(height: 16),
            Row(
              children: [
                _image == null? Container() : Container(child: Image.file(File(_image!.path))),
                _image == null? Container() : Container(child: Image.file(File(_image!.path)))
                
              ]
            ),
          ],
        ),
      ),
    );
  }
}