import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

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

class UnauthenticatedState extends AuthState {
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