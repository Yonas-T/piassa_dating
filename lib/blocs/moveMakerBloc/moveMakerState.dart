import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/models/userMoveMaker.dart';

abstract class MoveMakerState extends Equatable {}

class MoveMakerInitialState extends MoveMakerState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GotMoveMakersState extends MoveMakerState {
  List<MoveMaker> mvMaker;

  GotMoveMakersState({required this.mvMaker});
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MoveMakerLoadingState extends MoveMakerState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MoveMakerSuccessState extends MoveMakerState {
  // Peoples user;
  // Preference preference;

  // MoveMakerSuccessState(
  //   this.user,
  //   this.preference);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MoveMakerFailState extends MoveMakerState {
  String message;

  MoveMakerFailState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
