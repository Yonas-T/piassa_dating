import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class BasicProfileEvent extends Equatable {}

class ProceedButtonPressed extends BasicProfileEvent {
  final String userName,
      fullName,
      gender,
      email,
      birthDay,
      nationality,
      headline;

  final double longitude;
  final double latitude;
  final double height;

  ProceedButtonPressed(
      {required this.userName,
      required this.fullName,
      required this.gender,
      required this.email,
      required this.height,
      required this.birthDay,
      required this.nationality,
      required this.headline,
      required this.longitude,
      required this.latitude});

  @override
  List<Object> get props => [
        userName,
        fullName,
        gender,
        email,
        height,
        birthDay,
        nationality,
        headline,
        longitude,
        latitude
      ];
}

class SubmitButtonPressed extends BasicProfileEvent {
  final int ageStart;
  final int ageEnd;
  final String religion;
  final String educationLevel;
  final double searchRadius;

  SubmitButtonPressed(
      {required this.ageStart,
      required this.ageEnd,
      required this.religion,
      required this.educationLevel,
      required this.searchRadius});

  @override
  List<Object> get props =>
      [ageStart, ageEnd, religion, educationLevel, searchRadius];
}
