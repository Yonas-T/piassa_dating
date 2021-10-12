import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/userMatch.dart';

abstract class MatchQueueState extends Equatable {
  const MatchQueueState();

  @override
  List<Object> get props => [];
}

class InitialMatchQueueState extends MatchQueueState {}

class MatchQueueLoadingState extends MatchQueueState {}

class LoadedMatchQueueState extends MatchQueueState {
  final List<UserMatch> matchQueue;


  LoadedMatchQueueState(this.matchQueue);

  @override
  List<Object> get props => [matchQueue];
}


class MatchQueueFailState extends MatchQueueState {
  String message;

  MatchQueueFailState(this.message);

  @override
  List<Object> get props => [message];
}
