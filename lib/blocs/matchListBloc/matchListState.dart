import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/userMatch.dart';

abstract class MatchListState extends Equatable {
  const MatchListState();

  @override
  List<Object> get props => [];
}

class InitialMatchListState extends MatchListState {}

class MatchListLoadingState extends MatchListState {}

class LoadedMatchListState extends MatchListState {
  final List<UserMatch> matchList;


  LoadedMatchListState(this.matchList);

  @override
  List<Object> get props => [matchList];
}


class MatchListFailState extends MatchListState {
  String message;

  MatchListFailState(this.message);

  @override
  List<Object> get props => [message];
}
