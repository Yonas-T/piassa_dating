import 'dart:async';

import 'package:piassa_application/blocs/signinBloc/signinState.dart';

import './loginEvent.dart';
import './loginState.dart';
import '../../repositories/authRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late AuthRepository userRepository;
  StreamSubscription? subscription;

  String verID = "";

  LoginBloc({required AuthRepository userRepository}) : super(LoginInitialState()) {
    this.userRepository = userRepository;
  }

  @override
  // TODO: implement initialState
  LoginState? get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      try {
        var user = await userRepository.signInEmailAndPassword(
            event.email, event.password);
        yield LoginSuccessState(user!);
      } catch (e) {
        yield LoginFailState(e.toString());
      }
    }
  }
}