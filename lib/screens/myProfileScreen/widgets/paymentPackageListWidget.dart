import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piassa_application/blocs/subscriptionBloc/subscriptionBloc.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/subscription.dart';
import 'package:piassa_application/repositories/subscriptionRepository.dart';
import 'package:piassa_application/screens/subscriptionDetailScreen/subscriptionDetailScreen.dart';

class PaymentPackageListWidget extends StatefulWidget {
  List<Subscription> subscription;
  SubscriptionRepository subscriptionRepository = SubscriptionRepository();
  PaymentPackageListWidget({required this.subscription});
  @override
  _PaymentPackageListWidgetState createState() =>
      _PaymentPackageListWidgetState();
}

class _PaymentPackageListWidgetState extends State<PaymentPackageListWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 8),
          InkWell(
            onTap: () {
              print(widget.subscription);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return SubscriptionDetailScreen(
                    subscriptionRepository: widget.subscriptionRepository,
                    subscriptionDetail: widget.subscription[0]);
              }));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Color(kDarkGrey),
                height: 90,
                width: 160,
                child: Center(
                  child: Text(
                    'Basic Package',
                    style:
                        TextStyle(color: Color(kWhite), fontSize: kNormalFont),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[Color(kPrimaryPink), Color(kPrimaryPurple)],
                )),
                height: 90,
                width: 160,
                child: Center(
                  child: Text(
                    'Premium Package',
                    style:
                        TextStyle(color: Color(kWhite), fontSize: kNormalFont),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SubscriptionDetailScreen(
                    subscriptionRepository: widget.subscriptionRepository,
                    subscriptionDetail: widget.subscription[1]);
              }));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[Color(0xFFAA6A20), Color(0XFFFFC888)],
                )),
                height: 90,
                width: 160,
                child: Center(
                  child: Text(
                    'Golden Package',
                    style:
                        TextStyle(color: Color(kWhite), fontSize: kNormalFont),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
