import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {

  User user;

  LoginSuccessState(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginFailState extends LoginState {

  String message;

  LoginFailState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [];
}