import 'package:equatable/equatable.dart';

abstract class SigninEvent extends Equatable {}

class SigninButtonPressed extends SigninEvent {

  String email, password;

  SigninButtonPressed({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}