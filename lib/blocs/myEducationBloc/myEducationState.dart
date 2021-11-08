import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piassa_application/models/education.dart';
import 'package:piassa_application/models/languageValue.dart';
import 'package:piassa_application/models/myEducation.dart';
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

class MyEducationLoadedState extends MyEducationState {
  final Education myEducationData;
  final List<LanguageValue> universities;
  final List<LanguageValue> professions;

  MyEducationLoadedState(this.universities, this.professions, this.myEducationData);
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class MyEducationSuccessState extends MyEducationState {
  Education posted;
 
  MyEducationSuccessState(
    this.posted);

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
