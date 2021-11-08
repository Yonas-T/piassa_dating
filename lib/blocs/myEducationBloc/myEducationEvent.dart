import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/languageValue.dart';
import 'package:piassa_application/models/myEducation.dart';

abstract class MyEducationEvent extends Equatable {}

class SaveEducationButtonPressed extends MyEducationEvent {
  // final String gender;
  MyEducation education;

  SaveEducationButtonPressed(
      {required this.education});

  @override
  List<Object> get props =>
      [education];
}

class EditEducationButtonPressed extends MyEducationEvent {

  MyEducation education;

  EditEducationButtonPressed(
      {required this.education});

  @override
  List<Object> get props =>
      [education];
}

class LoadUniversitiesAndProfessions extends MyEducationEvent {
  @override
  List<Object> get props => [];
}

class SaveEducation extends MyEducationEvent {
  // final String gender;
  MyEducation education;

  SaveEducation({required this.education});

  @override
  List<Object> get props => [education];
}
