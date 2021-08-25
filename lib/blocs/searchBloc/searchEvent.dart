import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends SearchEvent {
  final String peopleId;

  LoadUserEvent(this.peopleId);

  @override
  List<Object> get props => [peopleId];
}

class LoadedUserEvent extends SearchEvent {
  final String peopleId;

  LoadedUserEvent(this.peopleId);

  @override
  List<Object> get props => [peopleId];
}

class SelectUserEvent extends SearchEvent {
  final String currentPeopleId, selectedPeopleId, name, photoUrl;

  SelectUserEvent(this.currentPeopleId, this.selectedPeopleId, this.name, this.photoUrl);

  @override
  List<Object> get props => [currentPeopleId, selectedPeopleId, name, photoUrl];
}

class PassUserEvent extends SearchEvent {
  final String currentPeopleId, selectedPeopleId;

  PassUserEvent(this.currentPeopleId, this.selectedPeopleId);

  @override
  List<Object> get props => [currentPeopleId, selectedPeopleId];
}