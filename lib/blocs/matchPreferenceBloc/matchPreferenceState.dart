import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';

abstract class MatchPreferenceState extends Equatable {}

class MatchPreferenceInitialState extends MatchPreferenceState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MatchPreferenceLoadingState extends MatchPreferenceState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MatchPreferenceSuccessState extends MatchPreferenceState {
  // Peoples user;
  // Preference preference;

  // MatchPreferenceSuccessState(
  //   this.user, 
  //   this.preference);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MatchPreferenceFailState extends MatchPreferenceState {
  String message;

  MatchPreferenceFailState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
