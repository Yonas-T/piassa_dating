import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/models/peoples.dart';

class MatchSearchBarWidget extends StatefulWidget {
  final List<Peoples> listOfPeoples;
  final double height;
  MatchSearchBarWidget({required this.height, required this.listOfPeoples});
  @override
  _MatchSearchBarWidgetState createState() => _MatchSearchBarWidgetState();
}

class _MatchSearchBarWidgetState extends State<MatchSearchBarWidget> {
  TextEditingController searchCntrlr = TextEditingController();
  List<String> lists = [];
  List<String> listsFilter = [];

  @override
  void initState() {
    widget.listOfPeoples.map((ppl) {
      lists.add(ppl.fullName);
    });
    listsFilter = lists;

    super.initState();
  }

  void filter(String inputString) {
    listsFilter =
        lists.where((i) => i.toLowerCase().contains(inputString)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      height: widget.height,
      color: Color(kDarkGrey),
      child: TextField(
        controller: searchCntrlr,
        decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.search, color: Color(kWhite),),
            border: UnderlineInputBorder(borderSide: BorderSide(color: Color(kWhite))),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(kWhite))),
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: kNormalFont, color: Color(kWhite)),
            fillColor: Color(kDarkGrey),
            focusColor: Color(kDarkGrey),
            disabledBorder: InputBorder.none),
        onChanged: (text) {
          text = text.toLowerCase();
          filter(text);
        },
      ),
    );
  }
}
