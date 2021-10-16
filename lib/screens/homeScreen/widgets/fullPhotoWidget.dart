import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/profile.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/screens/profileScreen/widgets/infoTextWidget.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class FullPhoto extends StatefulWidget {
  final List<String> imageUrlList;
  final int initIndex;
  UserMatch matchRecommendation;

  FullPhoto(
      {required this.imageUrlList,
      required this.initIndex,
      required this.matchRecommendation});
  @override
  State createState() => new _FullPhoto();
}

class _FullPhoto extends State<FullPhoto> {
  PageController? _pageController;
  List<String> imageListStrings = [];
  int? currentIndex;

  List<Profile> _profile = [];

  @override
  void initState() {
    _profile.add(Profile(
        name: 'Person',
        age: '23',
        city: 'Addis Ababa',
        drink: 'Occasionally',
        education: 'Bachelors Degree',
        height: '173cm',
        occupation: 'Accountant',
        religion: 'Orthodox',
        sport: 'Daily',
        imageUrl:
            'https://img.freepik.com/free-photo/portrait-young-beautiful-african-girl-dark-wall_176420-5818.jpg?size=626&ext=jpg',
        bio: 'I am an easy going person.'));

    for (String imageUrl in widget.imageUrlList) {
      if (imageUrl != "") {
        imageListStrings.add(imageUrl);
      }
      print(widget.matchRecommendation);

      super.initState();
    }

    _pageController = PageController(initialPage: widget.initIndex);

    setState(() {
      currentIndex = widget.initIndex;
    });
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(imageListStrings[index]),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 1.5,
                    );
                  },
                  itemCount: imageListStrings.length,
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                event.expectedTotalBytes!.toDouble(),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(klightPink)),
                      ),
                    ),
                  ),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  onPageChanged: onPageChanged,
                  pageController: _pageController,
                ),
                Positioned(
                  right: 12,
                  top: 30,
                  child: ScrollingPageIndicator(
                      dotColor: Colors.white,
                      dotSelectedColor: Color(klightPink),
                      dotSize: 6,
                      dotSelectedSize: 10,
                      dotSpacing: 16,
                      controller: _pageController,
                      itemCount: imageListStrings.length,
                      orientation: Axis.vertical),
                ),
                // Container(
                //   padding: const EdgeInsets.all(20.0),
                //   child: Text(
                //     "${currentIndex! + 1} / ${imageListStrings.length}",
                //     style: const TextStyle(
                //       color: Colors.white,
                //       fontSize: 17.0,
                //       decoration: null,
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(kWhite),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    child: SingleChildScrollView(
                      child: InfoTextWidget(
                          recommended: widget.matchRecommendation),
                    ),
                  ),
                )
              ],
            )),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
