import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:piassa_application/models/peoples.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {

  User user;

  AuthenticatedState(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HasProfileState extends AuthState {

  Peoples user;

  HasProfileState(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
class UnauthenticatedState extends AuthState {
  String message;

  UnauthenticatedState(this.message);

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