import 'dart:developer';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:geocoding/geocoding.dart';
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

  @override
  void initState() {
    searchBloc = SearchBloc(searchRepository: widget.searchRepository);
    searchBloc.add(LoadUserEvent());
    print('3333333333333333333');

    super.initState();
  }

  Future<String> _getAddressFromLatLng(lat, lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      print('placemark: $placemarks');

      Placemark place = placemarks[0];

      // _currentAddress = "${place.locality}";
      // print('City address: $_currentAddress');
      return place.locality!;
    } catch (e) {
      print(e);

      return e.toString();
    }
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

            // if (state is LoadUserFailState) {
            //   Center(
            //     child: Text('Load Failed'),
            //   );
            // }
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
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Unable to Load Recommendations. Try to check your connection!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: kNormalFont, color: Color(kBlack)),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
      // bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody(BuildContext context, List<UserMatch> matchRecommendations) {
    var size = MediaQuery.of(context).size;
    Future<String> cityAddress;
    if (matchRecommendations[0].latitude != null &&
        matchRecommendations[0].longitude != null) {
      cityAddress = _getAddressFromLatLng(
          matchRecommendations[0].latitude, matchRecommendations[0].longitude);
    }

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
                                          '${matchRecommendations[index].fullName}, ',
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
                                          (DateTime.now().year -
                                                  DateTime.parse(
                                                          matchRecommendations[
                                                                  index]
                                                              .birthDay)
                                                      .year)
                                              .toString(),
                                          style: TextStyle(
                                            color: Color(kWhite),
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        FutureBuilder(
                                            future: _getAddressFromLatLng(
                                                28.6139391, 77.2068325),
                                            // _getAddressFromLatLng(matchRecommendations[index].latitude, matchRecommendations[index].longitude),
                                            initialData: '',
                                            builder: (context,
                                                AsyncSnapshot<String> text) {
                                              return Text(text.data!,
                                                  style: TextStyle(
                                                      fontSize: kTitleBoldFont,
                                                      color: Color(kWhite)));
                                            }),
                                      ],
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
            print(matchRecommendations.length);
            print('INDEX: $index');
            print(matchRecommendations[index].id);

            setState(() {
              itemLength = matchRecommendations.length - 1;
            });
            print(matchRecommendations[index].id);
            if (orientation == CardSwipeOrientation.LEFT) {
              passUserFunction(matchRecommendations[index].id, matchLoaded);
            } else if (orientation == CardSwipeOrientation.RIGHT) {
              selectUserFunction(matchRecommendations[index].id, matchLoaded);
            }

            print('INDEX222: $index');
          },
        ),
      ),
    );
  }

  void passUserFunction(indx, matchLoaded) {
    searchBloc.add(PassUserEvent(indx, matchLoaded));
    log('PASS');
  }

  void selectUserFunction(indx, matchLoaded) {
    searchBloc.add(SelectUserEvent(indx, matchLoaded));
    log('like');
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
                  child: ExtendedImage.network(
                    matchRecommendations[index].userImages[i].filePath,
                    // width: ScreenUtil.instance.setWidth(400),
                    // height: ScreenUtil.instance.setWidth(400),
                    fit: BoxFit.fill,
                    cache: true,
                    // border: Border.all(color: Colors.red, width: 1.0),
                    // shape: boxShape,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    //cancelToken: cancellationToken,
                  )),
            ),
            onTap: () {
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
                            matchRecommendation: matchRecommendations[index],
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
