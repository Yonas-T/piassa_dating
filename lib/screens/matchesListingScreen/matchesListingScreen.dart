
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piassa_application/blocs/matchListBloc/matchListBloc.dart';
import 'package:piassa_application/blocs/matchListBloc/matchListEvent.dart';
import 'package:piassa_application/blocs/matchListBloc/matchListState.dart';
import 'package:piassa_application/blocs/matchQueueBloc/matchQueueBloc.dart';
import 'package:piassa_application/blocs/matchQueueBloc/matchQueueEvent.dart';
import 'package:piassa_application/blocs/matchQueueBloc/matchQueueState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/userImage.dart';
import 'package:piassa_application/repositories/matchListRepository.dart';
import 'package:piassa_application/screens/chatScreen/chatScreen.dart';
import 'package:piassa_application/screens/matchesListingScreen/widgets/singleMatchesListWidget.dart';

class MatchesListingScreen extends StatelessWidget {
  MatchListRepository matchListRepository = MatchListRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MatchQueueBloc(matchListRepository: matchListRepository),
      child:
          MatchesListingChildScreen(matchListRepository: matchListRepository),
    );
  }
}

class MatchesListingChildScreen extends StatefulWidget {
  MatchListRepository matchListRepository;
  MatchesListingChildScreen({required this.matchListRepository});

  @override
  _MatchesListingChildScreenState createState() =>
      _MatchesListingChildScreenState();
}

class _MatchesListingChildScreenState extends State<MatchesListingChildScreen> {
  bool _isLiked = false;
  late MatchQueueBloc matchQueueBloc;
  late MatchListBloc matchListBloc;
  String profileImg = '';

  @override
  void initState() {
    _isLiked = false;
    matchQueueBloc =
        MatchQueueBloc(matchListRepository: widget.matchListRepository);
    matchListBloc =
        MatchListBloc(matchListRepository: widget.matchListRepository);
    matchQueueBloc.add(LoadMatchQueue());

    matchListBloc.add(LoadMatchedList());
    // _matchesList.add(Peoples(
    //     userName: 'Test Person',
    //     fullName: '1',
    //     gender: '10:00',
    //     email: 'female',
    //     latitude: GeoPoint(10, 10).latitude,
    //     longitude: GeoPoint(10, 10).longitude,
    //     birthDay: '12/12/12',
    //     nationality: 'Ethiopian',
    //     headline: 'asdfgh',
    //     height: 1.7));
    // _matchesList.add(Peoples(
    //     userName: 'Test Person',
    //     fullName: '1',
    //     gender: '10:00',
    //     email: 'female',
    //     latitude: GeoPoint(10, 10).latitude,
    //     longitude: GeoPoint(10, 10).longitude,
    //     birthDay: '12/12/12',
    //     nationality: 'Ethiopian',
    //     headline: 'asdfgh',
    //     height: 1.7));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kWhite),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'New Likes',
                style: TextStyle(
                  fontSize: kButtonFont,
                  color: Color(kBlack),
                ),
              ),
            ),
            BlocProvider(
              create: (_) => matchQueueBloc,
              child: BlocListener<MatchQueueBloc, MatchQueueState>(
                listener: (context, state) {
                  print(state);

                  if (state is MatchQueueFailState) {
                    Container(
                      height: 100,
                      child: Center(
                        child: Text('Load Failed'),
                      ),
                    );
                  }
                },
                child: BlocBuilder<MatchQueueBloc, MatchQueueState>(
                    builder: (context, state) {
                  if (state is InitialMatchQueueState) {
                    return Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .14,
                      ),
                    );
                  } else if (state is MatchQueueLoadingState) {
                    return Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .14,
                      ),
                    );
                  } else if (state is MatchQueueFailState) {
                    return Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .14,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Unable to Load your matche queue. Try to check your connection!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kBlack)),
                        ),
                      ),
                    );
                  } else if (state is LoadedMatchQueueState) {
                    return Container(
                      height: MediaQuery.of(context).size.height * .14,
                      padding: EdgeInsets.only(left: 20),
                      child: state.matchQueue.length == 0
                          ? Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                            )
                          : ListView.builder(
                              // shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.matchQueue.length,
                              itemBuilder: (context, i) {
                                List<UserImage> images =
                                    state.matchQueue[i].userImages;
                                // log('Profile IMg: ${json.encode(state.matchQueue[i])}');
                                for (var img in images) {
                                  if (img.fileType == 'PROFILE' &&
                                      img.fileType == 'VERIFIED') {
                                    setState(() {
                                      profileImg = img.filePath;
                                    });
                                    print('Profile IMg: $images');
                                  }
                                }

                                return Container(
                                  padding: EdgeInsets.only(left: 4, right: 4),
                                  child: CircleAvatar(
                                    radius: 44,
                                    backgroundColor: Color(klightPink),
                                    child: CircleAvatar(
                                      backgroundColor: Color(kWhite),
                                      backgroundImage: NetworkImage(
                                        '$profileImg',
                                      ),
                                      radius: 40,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Card(
                                          shape: CircleBorder(),
                                          elevation: 6,
                                          child: InkWell(
                                            onTap: () {
                                              matchQueueBloc.add(LikeMatchQueue(
                                                  likedId:
                                                      state.matchQueue[i].id));
                                              setState(() {
                                                _isLiked = true;
                                                state.matchQueue.length--;
                                                // Navigator.of(context).push(
                                                //     MaterialPageRoute(
                                                //         builder: (context) {
                                                //   return ItsAMatchScreen();
                                                // }));
                                              });
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 12.0,
                                              child: !_isLiked
                                                  ? Icon(
                                                      Icons.favorite,
                                                      size: 14.0,
                                                      color: Colors.red,
                                                    )
                                                  : Icon(
                                                      Icons.check,
                                                      size: 10.0,
                                                      color: Colors.green,
                                                    ),
                                              // ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    );
                  }
                  return Container();
                }),
              ),
            ),

            // Container(
            //   height: MediaQuery.of(context).size.height * .14,
            //   padding: EdgeInsets.only(left: 20),
            //   child: ListView.builder(
            //       // shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemCount: _matchesList.length,
            //       itemBuilder: (context, i) {
            //         return Container(
            //           padding: EdgeInsets.only(left: 4, right: 4),
            //           child: CircleAvatar(
            //             radius: 44,
            //             backgroundColor: Color(kDarkGrey),
            //             child: CircleAvatar(
            //               backgroundImage: NetworkImage(
            //                 '_matchesList[i].profilePictureURL',
            //               ),
            //               radius: 40,
            //               child: Align(
            //                 alignment: Alignment.bottomRight,
            //                 child: Card(
            //                   shape: CircleBorder(),
            //                   elevation: 6,
            //                   child: InkWell(
            //                     onTap: () {
            //                       setState(() {
            //                         _isLiked = true;

            //                         Navigator.of(context).push(
            //                             MaterialPageRoute(builder: (context) {
            //                           return ItsAMatchScreen();
            //                         }));
            //                       });
            //                     },
            //                     child: CircleAvatar(
            //                       backgroundColor: Colors.white,
            //                       radius: 8.0,
            //                       child: !_isLiked
            //                           ? Icon(
            //                               Icons.favorite,
            //                               size: 10.0,
            //                               color: Colors.red,
            //                             )
            //                           : Icon(
            //                               Icons.check,
            //                               size: 10.0,
            //                               color: Colors.green,
            //                             ),
            //                       // ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         );
            //       }),
            // ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Color(kLightGrey).withOpacity(0.6),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Matches',
                style: TextStyle(
                  fontSize: kButtonFont,
                  color: Color(kBlack),
                ),
              ),
            ),
            SizedBox(height: 4),
            BlocProvider(
              create: (_) => matchListBloc,
              child: BlocListener<MatchListBloc, MatchListState>(
                listener: (context, state) {
                  print(state);

                  if (state is MatchQueueFailState) {
                    Container(
                      height: 100,
                      child: Center(
                        child: Text('Load Failed'),
                      ),
                    );
                  }
                },
                child: BlocBuilder<MatchListBloc, MatchListState>(
                    builder: (context, state) {
                  if (state is InitialMatchListState) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(klightPink))),
                    );
                  } else if (state is MatchListFailState) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                        child: Text(
                          'Unable to Load your matches. Try to check your connection!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kBlack)),
                        ),
                      ),
                    );
                  } else if (state is LoadedMatchListState) {
                    return Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: 0.8,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        children: state.matchList.map((value) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.35,
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ChatScreen(
                                        'Helina',
                                        'Female / 5km / 44m',
                                        'I bring a lot of energy to what I do and always have some leftover to get into trouble on the weekends at my fav. local bar. (If you play your cards right, maybe we can meet there.)',
                                        "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg");
                                  }));
                                },
                                child: SingleMatchesListWidget(
                                  userData: value,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else if (state is MatchListLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(klightPink))),
                    );
                  }
                  return Container();
                }),
              ),
            ),
            // Expanded(
            //   child: GridView.count(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 4,
            //     mainAxisSpacing: 4,
            //     childAspectRatio: 0.8,
            //     scrollDirection: Axis.vertical,
            //     physics: BouncingScrollPhysics(),
            //     children: _matchesList.map((value) {
            //       return InkWell(
            //         onTap: () {},
            //         child: Container(
            //           width: MediaQuery.of(context).size.width * 0.45,
            //           height: MediaQuery.of(context).size.height * 0.35,
            //           alignment: Alignment.center,
            //           child: InkWell(
            //             onTap: () {
            //               Navigator.of(context)
            //                   .push(MaterialPageRoute(builder: (context) {
            //                 return ChatScreen(
            //                     'Helina',
            //                     'Female / 5km / 44m',
            //                     'I bring a lot of energy to what I do and always have some leftover to get into trouble on the weekends at my fav. local bar. (If you play your cards right, maybe we can meet there.)',
            //                     "https://image.shutterstock.com/image-photo/blackskin-beauty-woman-healthy-happy-600w-1932957806.jpg");
            //               }));
            //             },
            //             child: SingleMatchesListWidget(
            //               userData: value,
            //             ),
            //           ),
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
