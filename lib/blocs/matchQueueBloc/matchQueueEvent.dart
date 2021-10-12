import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/education.dart';
import 'package:piassa_application/models/lifeStyle.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/models/userMatch.dart';

abstract class MatchQueueEvent extends Equatable {}

class LoadMatchQueue extends MatchQueueEvent {
  @override
  List<Object> get props => [];
}

class LoadMatch extends MatchQueueEvent {
  @override
  List<Object> get props => [];
}

class LikeMatchQueue extends MatchQueueEvent {
  String likedId;

  LikeMatchQueue({required this.likedId});

  @override
  List<Object> get props => [likedId];
}

// class LoadMatchedList extends MatchQueueEvent {
//   @override
//   List<Object> get props => [];
// }

class MatchedUserPressed extends MatchQueueEvent {
  UserMatch matchedPerson;

  MatchedUserPressed({required this.matchedPerson});
  @override
  List<Object> get props => [matchedPerson];
}
