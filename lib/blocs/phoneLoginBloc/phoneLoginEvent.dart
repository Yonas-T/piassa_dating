import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneLoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends PhoneLoginEvent {
  final String phoNo;

  SendOtpEvent(this.phoNo);
}

class AppStartEvent extends PhoneLoginEvent {}

class VerifyOtpEvent extends PhoneLoginEvent {
  final String otp;

  VerifyOtpEvent(this.otp);
}


class OtpSendEvent extends PhoneLoginEvent {}

class PhoneLoginCompleteEvent extends PhoneLoginEvent {
  final User firebaseUser;
  PhoneLoginCompleteEvent(this.firebaseUser);
}

class PhoneLoginExceptionEvent extends PhoneLoginEvent {
  final String message;

  PhoneLoginExceptionEvent(this.message);
}