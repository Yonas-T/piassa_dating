import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/userMoveMaker.dart';

abstract class MoveMakerEvent extends Equatable {}

class SaveMoveMakerButtonPressed extends MoveMakerEvent {
  // final String gender;
  List<PostMoveMaker> moveMakerAnswers;

  SaveMoveMakerButtonPressed({required this.moveMakerAnswers});

  @override
  List<Object> get props => [moveMakerAnswers];
}

class LoadMoveMaker extends MoveMakerEvent {
  @override
  List<Object> get props => [];
}
