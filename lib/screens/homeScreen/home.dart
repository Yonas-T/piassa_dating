import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:piassa_application/blocs/searchBloc/searchBloc.dart';
import 'package:piassa_application/blocs/searchBloc/searchEvent.dart';
import 'package:piassa_application/blocs/searchBloc/searchState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/repositories/searchRepository.dart';
import 'package:piassa_application/screens/homeScreen/widgets/fullPhotoWidget.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class Home extends StatefulWidget {
  SearchRepository searchRepository;

  Home({required this.searchRepository});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  CardController? controller;
  late SearchBloc searchBloc;
  List itemsTemp = [];
  int itemLength = 0;
  List<UserMatch> matchLoaded = [];

  PageController? _pageController;

  static const List explore_json = [
    {
      "img":
          "https://img.freepik.com/free-photo/portrait-young-beautiful-african-girl-dark-wall_176420-5818.jpg?size=626&ext=jpg",
      "userImages": [
        "https://img.freepik.com/free-photo/portrait-young-beautiful-african-girl-dark-wall_176420-5818.jpg?size=626&ext=jpg",
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
        "https://i.pinimg.com/236x/ff/d0/d3/ffd0d35d790e8212797af70ad18318f2.jpg",
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
        "https://thumbs.dreamstime.com/b/ethiopian-dress-young-girl-wearing-white-traditional-95969103.jpg",
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
        "https://viva.pressbooks.pub/app/uploads/sites/42/2020/10/young-ethnic-woman-pointing-at-camera-3880943-scaled-1.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "Hiwot",
      "age": "22",
      "likes": ["Travel", "Fashion", "Reading"],
    },
    {
      "img": "https://live.staticflickr.com/2594/4069449255_9f4e09c928_n.jpg",
      "userImages": [
        "https://live.staticflickr.com/2594/4069449255_9f4e09c928_n.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "Selome",
      "age": "18",
      "likes": ["Model", "Fashion", "Working Out"],
    },
    {
      "img":
          "https://i.pinimg.com/originals/8e/6e/3f/8e6e3f007f3bfb5c568d5cfe207fe9d1.jpg",
      "userImages": [
        "https://i.pinimg.com/originals/8e/6e/3f/8e6e3f007f3bfb5c568d5cfe207fe9d1.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "User",
      "age": "19",
      "likes": ["Shopping", "Travel", "Cat lover"],
    },
    {
      "img":
          "https://i.pinimg.com/474x/6b/7b/c5/6b7bc5c72055477530ef21012ad0fcae.jpg",
      "userImages": [
        "https://i.pinimg.com/474x/6b/7b/c5/6b7bc5c72055477530ef21012ad0fcae.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "User",
      "age": "20",
      "likes": ["Model", "Nature", "Instagram"],
    },
    {
      "img":
          "https://i.pinimg.com/474x/6b/7b/c5/6b7bc5c72055477530ef21012ad0fcae.jpg",
      "userImages": [
        "https://i.pinimg.com/474x/6b/7b/c5/6b7bc5c72055477530ef21012ad0fcae.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "User",
      "age": "18",
      "likes": ["Cooking", "Art", "Working Out"],
    },
    {
      "img":
          "https://i.pinimg.com/474x/6b/7b/c5/6b7bc5c72055477530ef21012ad0fcae.jpg",
      "userImages": [
        "https://i.pinimg.com/474x/6b/7b/c5/6b7bc5c72055477530ef21012ad0fcae.jpg",
        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg",
        "https://image.shutterstock.com/image-photo/beautiful-african-american-woman-looking-600w-1683033049.jpg"
      ],
      "name": "User",
      "age": "18",
      "likes": ["Swimming", "Working Out"],
    },
    {
      "img":
          "https://i.pinimg.com/474x/6b/7b/c5/6b7bc5c72055477530ef21012ad0fcae.jpg",
      "userImages": [
        "https://i.pinimg.com/474x/6b/7b/c5/6b7bc5c72055477530ef21012ad0fcae.jpg",
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
    searchBloc = SearchBloc(searchRepository: widget.searchRepository);
    searchBloc.add(LoadUserEvent());
    print('3333333333333333333');
    setState(() {
      itemsTemp = explore_json;
      // itemLength = explore_json.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kWhite),
      body: BlocProvider<SearchBloc>(
        create: (_) => searchBloc,
        child: BlocListener<SearchBloc, SearchState>(
          listener: (context, state) {
            print(state);

            if (state is LoadUserFailState) {
              Center(
                child: Text('Load Failed'),
              );
            }
          },
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              print(state);

              if (state is InitialSearchState) {
                return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(klightPink))));
              } else if (state is SearchLoadingState) {
                return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(klightPink))));
              } else if (state is LoadedUserState) {
                // setState(() {
                // print('~~~${json.encode(state.userMatchLoaded[0])}');
                itemLength = state.userMatchLoaded.length;
                matchLoaded = state.userMatchLoaded;

                // });
                print('IN BLOC BUILDER: ${state.userMatchLoaded}');
                return getBody(context, matchLoaded);
              } else if (state is LoadUserFailState) {
                return Container();
              }
              return Container();
            },
          ),
        ),
      ),
      // bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody(BuildContext context, matchRecommendations) {
    var size = MediaQuery.of(context).size;
    print(itemLength);
    // print(json.encode(matchRecommendations[0]));
    return Padding(
      padding: const EdgeInsets.only(bottom: 1, top: 16),
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
                    controller: _pageController =
                        PageController(initialPage: 0),
                    children: _userProfile(size, index, matchRecommendations),
                    scrollDirection: Axis.vertical,
                  ),
                  // Container(
                  //   width: size.width,
                  //   height: size.height,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: NetworkImage(itemsTemp[index]['img']),te
                  //         fit: BoxFit.cover),
                  //   ),
                  // ),
                  Container(
                    width: size.width,
                    height: size.height / 6,
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
                                          matchRecommendations[index].fullName,
                                          // itemsTemp[index]['name'],
                                          style: TextStyle(
                                              color: Color(kWhite),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '',
                                          // itemsTemp[index]['age'],
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
                                      // child: Row(
                                      //   children: List.generate(
                                      //       itemsTemp[index]['likes'].length,
                                      //       (indexLikes) {
                                      //     if (indexLikes == 0) {
                                      //       return Padding(
                                      //         padding: const EdgeInsets.only(
                                      //             right: 8),
                                      //         child: Container(
                                      //           decoration: BoxDecoration(
                                      //               // border: Border.all(
                                      //               //     color: Color(kWhite),
                                      //               //     width: 2),
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                       30),
                                      //               color: Color(kWhite)
                                      //                   .withOpacity(0.2)),
                                      //           child: Padding(
                                      //             padding:
                                      //                 const EdgeInsets.only(
                                      //                     top: 3,
                                      //                     bottom: 3,
                                      //                     left: 10,
                                      //                     right: 10),
                                      //             child: Text(
                                      //               '',
                                      //               // itemsTemp[index]['likes']
                                      //               // [indexLikes],
                                      //               style: TextStyle(
                                      //                   color: Color(kWhite)),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       );
                                      //     }
                                      //     return Padding(
                                      //       padding:
                                      //           const EdgeInsets.only(right: 8),
                                      //       child: Container(
                                      //         decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(30),
                                      //             color: Color(kWhite)
                                      //                 .withOpacity(0.2)),
                                      //         child: Padding(
                                      //           padding: const EdgeInsets.only(
                                      //               top: 3,
                                      //               bottom: 3,
                                      //               left: 10,
                                      //               right: 10),
                                      //           child: Text(
                                      //             '',
                                      //             // itemsTemp[index]['likes']
                                      //             // [indexLikes],
                                      //             style: TextStyle(
                                      //                 color: Color(kWhite)),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     );
                                      //   }),
                                      // ),
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
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            /// Get orientation & index of swiped card!
            print('#######');
            print(matchRecommendations!.length);
            print('INDEX: $index');
            if (index == (matchRecommendations.length - 1)) {
              setState(() {
                itemLength = matchRecommendations.length - 1;
              });
              print(matchRecommendations[index].id);
              if (orientation == CardSwipeOrientation.LEFT) {
                passUserFunction(matchRecommendations[index].id);
              } else if (orientation == CardSwipeOrientation.RIGHT) {
                selectUserFunction(matchRecommendations[index].id);
              }
            }
            print('INDEX222: $index');
          },
        ),
      ),
    );
  }

  void passUserFunction(indx) {
    searchBloc.add(PassUserEvent(indx));
  }

  void selectUserFunction(indx) {
    searchBloc.add(SelectUserEvent(indx));
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
      Size size, int index, List<UserMatch> matchRecommendations) {
    List<Widget> _returnWidgetList = [];
    // print(json.encode(matchRecommendations[index]));
    print('000000000${matchRecommendations[index].fullName}');
    // print('LIST: ${matchRecommendations[index].userImages.length}');
    for (int i = 0; i < matchRecommendations[index].userImages.length; i++) {
      Widget _userWidget = Stack(
        children: [
          GestureDetector(
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: matchRecommendations[index]
                              .userImages[i]
                              .verificationStatus ==
                          'VERIFIED'
                      ? ExtendedImage.network(
                          matchRecommendations[index].userImages[i].filePath,
                          // width: ScreenUtil.instance.setWidth(400),
                          // height: ScreenUtil.instance.setWidth(400),
                          fit: BoxFit.fill,
                          cache: true,
                          // border: Border.all(color: Colors.red, width: 1.0),
                          // shape: boxShape,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          //cancelToken: cancellationToken,
                        )
// Image.network(
//                           matchRecommendations[index].userImages[i].filePath,
//                           fit: BoxFit.cover)
                      : Container()
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
            onVerticalDragUpdate: (dragUpdateDetails) {
              List<String> imgList = [];
              for (var i = 0;
                  i < matchRecommendations[index].userImages.length;
                  i++) {
                imgList.add(matchRecommendations[index].userImages[i].filePath);
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullPhoto(
                            imageUrlList: imgList,
                            initIndex: i,
                          )));
            },
            // onLongPress: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => FullPhoto(
            //                 imageUrlList: itemsTemp[index]['userImages'],
            //                 initIndex: i,
            //               )));
            // },
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
                itemCount: matchRecommendations[index].userImages.length,
                orientation: Axis.vertical),
          ),
        ],
      );
      _returnWidgetList.add(_userWidget);
    }
    return _returnWidgetList;
  }
}
