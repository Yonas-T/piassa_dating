import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:piassa_application/main.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  UserMatch profData;
  User user;

  AuthenticatedState(this.user, this.profData);

  @override
  // TODO: implement props
  List<Object> get props => [user, profData];
}

class HasProfileState extends AuthState {
  Peoples user;

  HasProfileState(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UnauthenticatedState extends AuthState {
  // String message;

  // UnauthenticatedState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LogOutInitial extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LogOutSuccessState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
