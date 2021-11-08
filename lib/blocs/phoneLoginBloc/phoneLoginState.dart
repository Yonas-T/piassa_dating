import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneLoginState extends Equatable {}

class PhoneInitialLoginState extends PhoneLoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OtpSentState extends PhoneLoginState {
  @override
  List<Object> get props => [];
}

class PhoneLoadingState extends PhoneLoginState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends PhoneLoginState {
  @override
  List<Object> get props => [];
}

class PhoneLoginCompleteState extends PhoneLoginState {
  User user;

  PhoneLoginCompleteState(this.user);
  User getUser(){
   return user;
  }
  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class PhoneExceptionState extends PhoneLoginState {
  String message;

  PhoneExceptionState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class OtpExceptionState extends PhoneLoginState {
  String message;

  OtpExceptionState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}