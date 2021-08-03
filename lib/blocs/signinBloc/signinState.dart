import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SigninState extends Equatable {}

class SigninInitial extends SigninState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SigninLoading extends SigninState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SigninSuccessful extends SigninState {

  User user;

  SigninSuccessful(this.user);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SigninFailure extends SigninState {

  String message;

  SigninFailure(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}