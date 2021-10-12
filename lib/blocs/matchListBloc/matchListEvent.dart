import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/education.dart';
import 'package:piassa_application/models/lifeStyle.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/models/userMatch.dart';

abstract class MatchListEvent extends Equatable {}

class LoadMatchedList extends MatchListEvent {
  @override
  List<Object> get props => [];
}

class MatchedUserPressed extends MatchListEvent {
  UserMatch matchedPerson;

  MatchedUserPressed({required this.matchedPerson});
  @override
  List<Object> get props => [matchedPerson];
}
