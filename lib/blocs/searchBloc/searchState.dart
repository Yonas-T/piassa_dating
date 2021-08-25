import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/peoples.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {}

class LoadingState extends SearchState {}

class LoadUserState extends SearchState {
  final Peoples people, currentUser;

  LoadUserState(this.people, this.currentUser);
  
  @override
  List<Object> get props => [people, currentUser];
}
