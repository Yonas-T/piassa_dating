import './signinEvent.dart';
import './signinState.dart';
import '../../repositories/authRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  late AuthRepository userRepository;

  SigninBloc({required AuthRepository userRepository}) : super(SigninInitial()) {
    this.userRepository = userRepository;
  }

  @override
  // TODO: implement initialState
  SigninState get initialState => SigninInitial();

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is SigninButtonPressed) {
      yield SigninLoading();
      try {
        var user = await userRepository.signUpUserWithEmailPass(
            event.email, event.password);
        print("BLoC : ${user!.email}");
        yield SigninSuccessful(user);
      } catch (e) {
        yield SigninFailure(e.toString());
      }
    }
  }
}