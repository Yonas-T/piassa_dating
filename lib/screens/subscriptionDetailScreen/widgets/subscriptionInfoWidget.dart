import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piassa_application/blocs/subscriptionBloc/subscriptionBloc.dart';
import 'package:piassa_application/blocs/subscriptionBloc/subscriptionEvent.dart';
import 'package:piassa_application/blocs/subscriptionBloc/subscriptionState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/subscription.dart';
import 'package:piassa_application/repositories/subscriptionRepository.dart';

class SubscriptionInfoWidget extends StatefulWidget {
  Color colorWidget;
  Subscription subscriptionPassed;

  SubscriptionInfoWidget(
      {required this.colorWidget, required this.subscriptionPassed});

  @override
  _SubscriptionInfoWidgetState createState() => _SubscriptionInfoWidgetState();
}

class _SubscriptionInfoWidgetState extends State<SubscriptionInfoWidget> {
  SubscriptionRepository subscriptionRepository = SubscriptionRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubscriptionBloc(subscriptionRepository: subscriptionRepository),
      child: SubscriptionInfoChildWidget(
        subscriptionRepository: subscriptionRepository,
        colorWidget: widget.colorWidget,
        subscriptionPassed: widget.subscriptionPassed,
      ),
    );
  }
}

class SubscriptionInfoChildWidget extends StatefulWidget {
  Color colorWidget;
  Subscription subscriptionPassed;
  SubscriptionRepository subscriptionRepository;

  SubscriptionInfoChildWidget(
      {required this.subscriptionRepository,
      required this.colorWidget,
      required this.subscriptionPassed});
  @override
  _SubscriptionInfoChildWidgetState createState() =>
      _SubscriptionInfoChildWidgetState();
}

class _SubscriptionInfoChildWidgetState
    extends State<SubscriptionInfoChildWidget> {
  SubscriptionBloc? subscriptionBloc;

  @override
  void initState() {
    subscriptionBloc =
        SubscriptionBloc(subscriptionRepository: widget.subscriptionRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.subscriptionPassed.name,
                style:
                    TextStyle(fontSize: kTitleBoldFont, color: Color(kBlack))),
          ),
          SizedBox(height: 16),
          Container(
            height: 32,
            width: MediaQuery.of(context).size.width,
            color: widget.colorWidget,
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Description',
                      style: TextStyle(
                          fontSize: kTitleBoldFont,
                          fontWeight: FontWeight.bold,
                          color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text('Daily swipes',
                      style: TextStyle(
                          fontSize: kTitleBoldFont,
                          fontWeight: FontWeight.bold,
                          color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text('Period ',
                      style: TextStyle(
                          fontSize: kTitleBoldFont,
                          fontWeight: FontWeight.bold,
                          color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text('Price',
                      style: TextStyle(
                          fontSize: kTitleBoldFont,
                          fontWeight: FontWeight.bold,
                          color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text('Point',
                      style: TextStyle(
                          fontSize: kTitleBoldFont,
                          fontWeight: FontWeight.bold,
                          color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text('Type',
                      style: TextStyle(
                          fontSize: kTitleBoldFont,
                          fontWeight: FontWeight.bold,
                          color: Color(kBlack))),
                  SizedBox(height: 8),
                ],
              ),
              Container(width: 2, height: 200, color: Color(kBlack)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('description',
                      // widget.subscriptionPassed.description,
                      style: TextStyle(
                          fontSize: kNormalFont, color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text(
                      widget.subscriptionPassed.noDailyProfileSwipes.toString(),
                      style: TextStyle(
                          fontSize: kTitleBoldFont, color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text(widget.subscriptionPassed.period.toString(),
                      style: TextStyle(
                          fontSize: kTitleBoldFont, color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text(widget.subscriptionPassed.price.toString(),
                      style: TextStyle(
                          fontSize: kTitleBoldFont, color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text(widget.subscriptionPassed.point.toString(),
                      style: TextStyle(
                          fontSize: kTitleBoldFont, color: Color(kBlack))),
                  SizedBox(height: 8),
                  Text(widget.subscriptionPassed.subscriptionPackageType,
                      style: TextStyle(
                          fontSize: kTitleBoldFont, color: Color(kBlack))),
                  SizedBox(height: 8),
                ],
              ),
            ],
          ),
          SizedBox(height: 48),
          BlocListener<SubscriptionBloc, SubscriptionState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
              builder: (context, state) {
                print(state);
                if (state is SubscriptionInitialState) {
                  print('LOADED');
                  return Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(kLightGrey), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: kButtonHeight,
                    child: TextButton(
                        onPressed: () {
                          print(state);
                          subscriptionBloc!.add(SubscribeButtonPressed(
                              subscription: widget.subscriptionPassed));
                          print(state);
                          
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Color(kWhite),
                            padding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child: Text(
                          'Subscribe',
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kBlack)),
                        )),
                  );
                }
                if (state is SubscriptionLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(klightPink)),
                    ),
                  );
                }
                if (state is SubscriptionSuccessState) {
                  return Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(kLightGrey), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: kButtonHeight,
                    child: TextButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Color(kWhite),
                            padding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child: Text(
                          'Subscribed',
                          style: TextStyle(
                              fontSize: kNormalFont, color: Color(kBlack)),
                        )),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
