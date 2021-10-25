import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piassa_application/blocs/moveMakerBloc/moveMakerBloc.dart';
import 'package:piassa_application/blocs/moveMakerBloc/moveMakerEvent.dart';
import 'package:piassa_application/blocs/moveMakerBloc/moveMakerState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/userMoveMaker.dart';
import 'package:piassa_application/repositories/moveMakerRepository.dart';
import 'package:piassa_application/services/moveMakerApiProvider.dart';

class MoveMakersScreen extends StatefulWidget {
  MoveMakerRepository moveMakerRepository = MoveMakerRepository();

  @override
  _MoveMakersScreenState createState() => _MoveMakersScreenState();
}

class _MoveMakersScreenState extends State<MoveMakersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MoveMakerBloc(moveMakerRepository: widget.moveMakerRepository),
      child: MoveMakersChildScreen(
          moveMakerRepository: widget.moveMakerRepository),
    );
  }
}

class MoveMakersChildScreen extends StatefulWidget {
  MoveMakerRepository moveMakerRepository;

  MoveMakersChildScreen({required this.moveMakerRepository});

  @override
  _MoveMakersChildScreenState createState() => _MoveMakersChildScreenState();
}

class _MoveMakersChildScreenState extends State<MoveMakersChildScreen> {
  TextEditingController questionOneController = TextEditingController();
  TextEditingController questionTwoController = TextEditingController();
  TextEditingController questionThreeController = TextEditingController();
  bool isLoading = true;

  List<MoveMaker> _moveMakerData = [];
  List<PostMoveMaker> _moveMakerToPost = [];

  String firstQuestion = '';
  String secondQuestion = '';
  String thirdQuestion = '';

  Future moveMakerValue() async {
    _moveMakerData = await MoveMakerApiProvider().fetchMoveMaker();
    print('MOVEMAKER: $_moveMakerData');
  }

  @override
  void initState() {
    isLoading = true;
    moveMakerValue().then((value) {
      firstQuestion = _moveMakerData[0].question;
      secondQuestion = _moveMakerData[1].question;
      thirdQuestion = _moveMakerData[2].question;
    }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onSaveMoveMakerButtonPressed() {
      _moveMakerToPost.clear();
      _moveMakerToPost.addAll([
        PostMoveMaker(
            moveMakerId: _moveMakerData[0].id,
            answer: questionOneController.text),
        PostMoveMaker(
            moveMakerId: _moveMakerData[1].id,
            answer: questionTwoController.text),
        PostMoveMaker(
            moveMakerId: _moveMakerData[2].id,
            answer: questionThreeController.text),
      ]);
      print(_moveMakerToPost);
      BlocProvider.of<MoveMakerBloc>(context)
          .add(SaveMoveMakerButtonPressed(moveMakerAnswers: _moveMakerToPost));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
            title: Text('Move Makers',
                style:
                    TextStyle(fontSize: kTitleBoldFont, color: Color(kBlack))),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(klightPink)),
            ))
          : BlocListener<MoveMakerBloc, MoveMakerState>(
              listener: (context, state) {
                if (state is MoveMakerSuccessState) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                color: Color(kWhite),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 32),
                            TextField(
                              controller: questionOneController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color(kWhite).withOpacity(0.5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kDarkGrey), width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kDarkGrey), width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kDarkGrey), width: 1)),
                                hintText: firstQuestion,
                                hintStyle: TextStyle(
                                    color: Color(kDarkGrey),
                                    fontSize: kNormalFont),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 24),
                            TextField(
                              controller: questionTwoController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color(kWhite).withOpacity(0.5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kDarkGrey), width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kDarkGrey), width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kDarkGrey), width: 1)),
                                hintText: secondQuestion,
                                hintStyle: TextStyle(
                                    color: Color(kDarkGrey),
                                    fontSize: kNormalFont),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 24),
                            TextField(
                              controller: questionThreeController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color(kWhite).withOpacity(0.5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kDarkGrey), width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kDarkGrey), width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Color(kDarkGrey), width: 1)),
                                hintText: thirdQuestion,
                                hintStyle: TextStyle(
                                    color: Color(kDarkGrey),
                                    fontSize: kNormalFont),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 32),
                          ],
                        ),
                      ),
                      BlocBuilder<MoveMakerBloc, MoveMakerState>(
                        builder: (context, state) {
                          if (state is MoveMakerInitialState) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(kDarkGrey), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),

                                // boxShadow: [
                                //   BoxShadow(
                                //       color: Color(kDarkGrey).withOpacity(0.5),
                                //       offset: Offset(0.0, 5.0),
                                //       blurRadius: 20.0)
                                // ],
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: kButtonHeight,
                              child: TextButton(
                                  onPressed: () {
                                    _onSaveMoveMakerButtonPressed();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: Color(kWhite),
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontSize: kNormalFont,
                                        color: Color(kBlack)),
                                  )),
                            );
                          }
                          if (state is MoveMakerLoadingState) {
                            return Center(
                                child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(klightPink)),
                            ));
                          }
                          if (state is MoveMakerFailState) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(kDarkGrey), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),

                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: Color(kDarkGrey).withOpacity(0.5),
                                    //       offset: Offset(0.0, 5.0),
                                    //       blurRadius: 20.0)
                                    // ],
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: kButtonHeight,
                                  child: TextButton(
                                      onPressed: () {
                                        _onSaveMoveMakerButtonPressed();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          primary: Color(kWhite),
                                          padding: EdgeInsets.all(8),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4))),
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            fontSize: kNormalFont,
                                            color: Color(kBlack)),
                                      )),
                                ),
                                SizedBox(height: 4),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Unable to upload movemaker. Retry',
                                        style: TextStyle(
                                            fontSize: kNormalFont,
                                            color: Colors.red),
                                      )
                                    ])
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
