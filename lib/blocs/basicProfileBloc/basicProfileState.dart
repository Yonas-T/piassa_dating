import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';

abstract class BasicProfileState extends Equatable {}

class BasicProfileInitialState extends BasicProfileState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BasicProfileLoadingState extends BasicProfileState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BasicProfileSuccessState extends BasicProfileState {
  // Peoples user;
  // Preference preference;

  // BasicProfileSuccessState(
  //   this.user, 
  //   this.preference);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BasicProfileProceedState extends BasicProfileState {
  Peoples user;

  BasicProfileProceedState(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BasicProfileFailState extends BasicProfileState {
  String message;

  BasicProfileFailState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
