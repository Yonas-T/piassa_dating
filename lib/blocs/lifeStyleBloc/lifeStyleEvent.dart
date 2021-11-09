import 'package:equatable/equatable.dart';

abstract class LifeStyleEvent extends Equatable {}

class SaveLifeStyleButtonPressed extends LifeStyleEvent {
  // final String gender;
  String? id;
  int smooking;
  int drinking;
  int kids;
  int religion;
  int physicalExercise;
  int relationshipStatus;

  SaveLifeStyleButtonPressed(
      {required this.drinking,
      required this.id,
      required this.kids,
      required this.physicalExercise,
      required this.relationshipStatus,
      required this.religion,
      required this.smooking});

  @override
  List<Object> get props =>
      [smooking, drinking, kids, religion, physicalExercise, relationshipStatus];
}

class EditLifeStyleButtonPressed extends LifeStyleEvent {
  // final String gender;
  String? id;
  int smooking;
  int drinking;
  int kids;
  int religion;
  int physicalExercise;
  int relationshipStatus;

  EditLifeStyleButtonPressed(
      {required this.drinking,
      required this.id,
      required this.kids,
      required this.physicalExercise,
      required this.relationshipStatus,
      required this.religion,
      required this.smooking});

  @override
  List<Object> get props =>
      [smooking, drinking, kids, religion, physicalExercise, relationshipStatus];
}

class LoadMyLifeStyle extends LifeStyleEvent {

@override
  List<Object> get props => [];

}
