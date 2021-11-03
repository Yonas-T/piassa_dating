import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/education.dart';
import 'package:piassa_application/models/lifeStyle.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/models/userMatch.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends SearchEvent {
  @override
  List<Object> get props => [];
}

class LoadedUserEvent extends SearchEvent {
  final String peopleId;

  LoadedUserEvent(this.peopleId);

  @override
  List<Object> get props => [peopleId];
}

class SelectUserEvent extends SearchEvent {
  final String recommendedId;
  final List<UserMatch> matchLoaded;

  SelectUserEvent(this.recommendedId, this.matchLoaded);

  @override
  List<Object> get props => [recommendedId, matchLoaded];
}

class PassUserEvent extends SearchEvent {
  final String recommendedId;
  final List<UserMatch> matchLoaded;

  PassUserEvent(this.recommendedId, this.matchLoaded);

  @override
  List<Object> get props => [recommendedId, matchLoaded];
}
