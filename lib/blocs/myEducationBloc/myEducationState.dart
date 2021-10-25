import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';

abstract class MyEducationState extends Equatable {}

class MyEducationInitialState extends MyEducationState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MyEducationLoadingState extends MyEducationState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MyEducationSuccessState extends MyEducationState {
  // Peoples user;
  // Preference preference;

  // MyEducationSuccessState(
  //   this.user, 
  //   this.preference);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MyEducationFailState extends MyEducationState {
  String message;

  MyEducationFailState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
