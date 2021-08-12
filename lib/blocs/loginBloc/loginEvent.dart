import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginButtonPressed extends LoginEvent {

  final String email, password;

  LoginButtonPressed({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
