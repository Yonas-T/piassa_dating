import 'package:flutter/material.dart';

class StepProgressWidget extends StatelessWidget {
  StepProgressWidget(
    int curStep,
    double height,
    double dotRadius,
    Color activeColor,
    Color inactiveColor,
    TextStyle headerStyle,
    TextStyle stepsStyle, {
    Key? key,
    required this.padding,
    this.lineHeight = 10.0,
  })  : _curStep = curStep,
        _dotRadius = dotRadius,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _headerStyle = headerStyle,
        _stepStyle = stepsStyle,
        assert(height >= 2 * dotRadius),
        super(key: key);

  //list of texts to be shown for each step
  final List<String> _stepsText = ['x', 'y'];
  //cur step identifier
  final int _curStep;
  //active color
  final Color _activeColor;
  //in-active color
  final Color _inactiveColor;
  //dot radius
  final double _dotRadius;
  //container padding
  final EdgeInsets padding;
  //line height
  final double lineHeight;
  //header textstyle
  final TextStyle _headerStyle;
  //steps text
  final TextStyle _stepStyle;

  List<Widget> _buildDots(double _dotWidth) {
    var wids = <Widget>[];
    _stepsText.asMap().forEach((i, text) {
      var circleColor =
          (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;

      var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;

      wids.add(Container(
        height: _dotRadius,
        width: _dotWidth,
        color: circleColor,
      ));

      //add a line separator
      //0-------0--------0
      // if (i != _stepsText.length - 1) {
      //   wids.add(
      //     Expanded(
      //       child: Container(
      //         height: lineHeight,
      //         color: lineColor,
      //       ),
      //     ),
      //   );
      // }
    });

    return wids;
  }

  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            children: _buildDots(MediaQuery.of(context).size.width * 0.48),
          ),
        ],
      ),
    );
  }
}
