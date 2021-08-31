import 'package:flutter/material.dart';
import 'package:piassa_application/constants/constants.dart';

class StepProgressWidget extends StatelessWidget {
  int curStep;

  StepProgressWidget({required this.curStep});

  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(children: [
            Container(
              color: curStep >= 1 ? Color(klightPink) : Color(kWhite),
              height: 15,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            Container(
              color: curStep == 2 ? Color(klightPink) : Color(kWhite),
              height: 15,
              width: MediaQuery.of(context).size.width * 0.5,
            )
          ]
              ),
        ],
      ),
    );
  }
}
