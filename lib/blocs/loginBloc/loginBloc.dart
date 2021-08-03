import 'package:piassa_application/blocs/signinBloc/signinState.dart';

import './loginEvent.dart';
import './loginState.dart';
import '../../repositories/userRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late UserRepository userRepository;

  LoginBloc({required UserRepository userRepository}) : super(LoginInitialState()) {
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