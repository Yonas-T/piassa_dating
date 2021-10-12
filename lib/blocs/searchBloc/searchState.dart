import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {}

class SearchLoadingState extends SearchState {}

class LoadUserState extends SearchState {
  final UserMatch userMatch;

  LoadUserState(this.userMatch);
  
  @override
  List<Object> get props => [userMatch];
}

class LoadedUserState extends SearchState {
  final List<UserMatch> userMatchLoaded;

  LoadedUserState(this.userMatchLoaded);
  
  @override
  List<Object> get props => [userMatchLoaded];
}

class LoadUserFailState extends SearchState {
  String message;

  LoadUserFailState(this.message);

  @override
  List<Object> get props => [message];
}
