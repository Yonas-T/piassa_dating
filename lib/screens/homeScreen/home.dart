import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/screens/homeScreen/widgets/fullPhotoWidget.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  CardController? controller;

  List itemsTemp = [];
  int itemLength = 0;

  PageController? _pageController;

  static const List explore_json = [
    {
      "img":
          "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "Melat",
      "age": "20",
      "likes": ["Dancing", "Cooking", "Art"],
    },
    {
      "img":
          "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "Helina",
      "age": "18",
      "likes": ["Instagram", "Cooking"],
    },
    {
      "img":
          "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "Saron",
      "age": "22",
      "likes": ["Instagram", "Netflix", "Comedy"],
    },
    {
      "img":
          "https://image.shutterstock.com/image-photo/portrait-beautiful-happy-black-woman-600w-667483969.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "Hiwot",
      "age": "22",
      "likes": ["Travel", "Fashion", "Reading"],
    },
    {
      "img":
          "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "Selome",
      "age": "18",
      "likes": ["Model", "Fashion", "Working Out"],
    },
    {
      "img":
          "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "User",
      "age": "19",
      "likes": ["Shopping", "Travel", "Cat lover"],
    },
    {
      "img":
          "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "User",
      "age": "20",
      "likes": ["Model", "Nature", "Instagram"],
    },
    {
      "img":
          "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "User",
      "age": "18",
      "likes": ["Cooking", "Art", "Working Out"],
    },
    {
      "img":
          "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "User",
      "age": "18",
      "likes": ["Swimming", "Working Out"],
    },
    {
      "img":
          "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
      "userImages": [
        "https://thumbs.dreamstime.com/b/portrait-smiling-ethiopian-girl-woman-african-wearing-orange-red-sweater-jumper-colorful-bow-her-hair-black-165631021.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "User",
      "age": "19",
      "likes": ["Swag", "Dancing"],
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = explore_json;
      itemLength = explore_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kWhite),
      body: getBody(),
      // bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Container(
        height: size.height,
        child: TinderSwapCard(
          totalNum: itemLength,
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.75,
          minHeight: MediaQuery.of(context).size.height * 0.85,
          cardBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(kLightGrey).withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
          alignment: Alignment.bottomCenter,

                children: [
                PageView(
                      controller: _pageController = PageController(initialPage: 0),
                      children: _userProfile(size, index),
                      scrollDirection: Axis.vertical,
                    ),
                  // Container(
                  //   width: size.width,
                  //   height: size.height,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: NetworkImage(itemsTemp[index]['img']),
                  //         fit: BoxFit.cover),
                  //   ),
                  // ),
                  Container(
                    width: size.width,
                    height: size.height/3,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Color(kBlack).withOpacity(0.25),
                          Color(kBlack).withOpacity(0),
                        ],
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Expanded(
                                // width: size.width * 0.72,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          itemsTemp[index]['name'],
                                          style: TextStyle(
                                              color: Color(kWhite),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          itemsTemp[index]['age'],
                                          style: TextStyle(
                                            color: Color(kWhite),
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                            itemsTemp[index]['likes'].length,
                                            (indexLikes) {
                                          if (indexLikes == 0) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(kWhite),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(30),
                                                    color: Color(kWhite)
                                                        .withOpacity(0.4)),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 3,
                                                      bottom: 3,
                                                      left: 10,
                                                      right: 10),
                                                  child: Text(
                                                    itemsTemp[index]['likes']
                                                        [indexLikes],
                                                    style: TextStyle(
                                                        color: Color(kWhite)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Color(kWhite)
                                                      .withOpacity(0.2)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3,
                                                    bottom: 3,
                                                    left: 10,
                                                    right: 10),
                                                child: Text(
                                                  itemsTemp[index]['likes']
                                                      [indexLikes],
                                                  style: TextStyle(
                                                      color: Color(kWhite)),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          cardController: controller = CardController(),
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            /// Get swiping card's alignment
            if (align.x < 0) {
              //Card is LEFT swiping
            } else if (align.x > 0) {
              //Card is RIGHT swiping
            }
            // print(itemsTemp.length);
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            /// Get orientation & index of swiped card!
            if (index == (itemsTemp.length - 1)) {
              setState(() {
                itemLength = itemsTemp.length - 1;
              });
            }
          },
        ),
      ),
    );
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: Color(kWhite)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: List.generate(item_icons.length, (index) {
        //     return Container(
        //       width: item_icons[index]['size'],
        //       height: item_icons[index]['size'],
        //       decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Color(kWhite),
        //           boxShadow: [
        //             BoxShadow(
        //               color: grey.withOpacity(0.1),
        //               spreadRadius: 5,
        //               blurRadius: 10,
        //               // changes position of shadow
        //             ),
        //           ]),
        //       child: Center(
        //         child: SvgPicture.asset(
        //           item_icons[index]['icon'],
        //           width: item_icons[index]['icon_size'],
        //         ),
        //       ),
        //     );
        //   }),
        // ),
      ),
    );
  }

  List<Widget> _userProfile(
    Size size,
    int index,
  ) {
    List<Widget> _returnWidgetList = [];
    for (int i = 0; i < itemsTemp[index]['userImages'].length; i++) {
      Widget _userWidget = Stack(
        children: [
          GestureDetector(
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: Image.network(itemsTemp[index]['userImages'][i], fit: BoxFit.cover)
                // CachedNetworkImage(
                //   imageUrl: itemsTemp[index]['userImages'][i],
                //   placeholder: (context, url) => Container(
                //     transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                //     child: Container(
                //         width: double.infinity,
                //         height: MediaQuery.of(context).size.height * 0.77,
                //         child: Center(child: new CircularProgressIndicator())),
                //   ),
                //   errorWidget: (context, url, error) => new Icon(Icons.error),
                //   width: double.infinity,
                //   height: MediaQuery.of(context).size.height * 0.77,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            onLongPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullPhoto(
                            imageUrlList: itemsTemp[index]['userImages'],
                            initIndex: i,
                          )));
            },
          ),
          // Positioned(
          //   bottom: 4,
          //   left: 4,
          //   child: userInformation(itemsTemp[index],size)
          // ),
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
                itemCount: itemsTemp[index]['userImages'].length,
                orientation: Axis.vertical),
          ),
        ],
      );
      _returnWidgetList.add(_userWidget);
    }
    return _returnWidgetList;
  }
}
