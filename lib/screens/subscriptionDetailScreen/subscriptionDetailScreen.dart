import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/blocs/subscriptionBloc/subscriptionBloc.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/models/subscription.dart';
import 'package:piassa_application/repositories/subscriptionRepository.dart';
import 'package:piassa_application/screens/subscriptionDetailScreen/widgets/subscriptionInfoWidget.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  SubscriptionRepository subscriptionRepository;
  Subscription subscriptionDetail;

  SubscriptionDetailScreen(
      {required this.subscriptionDetail, required this.subscriptionRepository});

  @override
  _SubscriptionDetailScreenState createState() =>
      _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarWidget(
              title: Text(
                'Subscriptions',
                style:
                    TextStyle(fontSize: kTitleBoldFont, color: Color(kWhite)),
              ),
              actionIcon: Card(
                  shape: CircleBorder(),
                  elevation: 1,
                  color: Color(kWhite),
                  child: Container()
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       FontAwesomeIcons.slidersH,
                  //       color: Color(kPrimaryPink),
                  //     )),
                  ),
              leadingIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(kWhite),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              colorVal: Color(klightPink)),
        ),
        body: SubscriptionInfoWidget(
          colorWidget:
              widget.subscriptionDetail.name == 'Free Subscription Package'
                  ? Color(kDarkGrey)
                  : widget.subscriptionDetail.name == 'Monthly Package'
                      ? Color(0xFFAA6A20)
                      : Color(kWhite),
          subscriptionPassed: widget.subscriptionDetail,
        ));
  }
}
