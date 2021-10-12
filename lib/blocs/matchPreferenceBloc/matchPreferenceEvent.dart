import 'package:equatable/equatable.dart';

abstract class MatchPreferenceEvent extends Equatable {}

class SubmitButtonPressed extends MatchPreferenceEvent {
  // final String gender;
  final String id;
  final String gender;
  final int ageStart;
  final int ageEnd;
  final String religion;
  final String educationLevel;
  final double searchRadius;

  SubmitButtonPressed(
      {
      required this.id,
      required this.gender,
      required this.ageStart,
      required this.ageEnd,
      required this.religion,
      required this.educationLevel,
      required this.searchRadius});

  @override
  List<Object> get props =>
      [ageStart, ageEnd, religion, educationLevel, searchRadius];
}
