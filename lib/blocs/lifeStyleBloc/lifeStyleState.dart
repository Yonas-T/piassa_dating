import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piassa_application/models/lifeStyle.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';

abstract class LifeStyleState extends Equatable {}

class LifeStyleInitialState extends LifeStyleState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LifeStyleLoadingState extends LifeStyleState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LifeStyleLoadedState extends LifeStyleState {
  LifeStyle lifeStyle;

  LifeStyleLoadedState(this.lifeStyle);


  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LifeStyleSuccessState extends LifeStyleState {
  // Peoples user;
  // Preference preference;

  // LifeStyleSuccessState(
  //   this.user, 
  //   this.preference);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LifeStyleFailState extends LifeStyleState {
  String message;

  LifeStyleFailState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
