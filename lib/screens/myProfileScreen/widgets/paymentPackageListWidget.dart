import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class PaymentPackageListWidget extends StatefulWidget {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Color(kDarkGrey),
              height: 90,
              width: 160,
              child: Center(
                child: Text(
                  'Basic Package',
                  style: TextStyle(color: Color(kWhite), fontSize: kNormalFont),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          ClipRRect(
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
                  style: TextStyle(color: Color(kWhite), fontSize: kNormalFont),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          ClipRRect(
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
                  style: TextStyle(color: Color(kWhite), fontSize: kNormalFont),
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
