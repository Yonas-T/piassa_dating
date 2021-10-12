import './authEvent.dart';
import './authState.dart';
import '../../repositories/authRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository? userRepository;

  AuthBloc({required AuthRepository? userRepository})
      : super(AuthInitialState()) {
    this.userRepository = userRepository;
  }

  @override
  // TODO: implement initialState
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartedEvent) {
      try {
        bool isSignedIn = await userRepository!.isSignedIn();
        print('IS SIGNED IN: $isSignedIn');
        if (isSignedIn) {
          var user = await userRepository!.getCurrentUser();
          print('AUTH USER: $user');
          yield AuthenticatedState(user!);
        }
        // if (event is LogOutEvent) {
        //   print("LOG out Bloc");
        //   userRepository!.signOut();
        //   yield LogOutSuccessState();
        // } 
        else {
          yield UnauthenticatedState('UnAuth');
        }
      } catch (e) {
        yield UnauthenticatedState(e.toString());
      }
    }

    if (event is LogOutEvent) {
          print("LOG out Bloc");
          userRepository!.signOut();
          yield LogOutSuccessState();
        } else {
          yield UnauthenticatedState('UnAuth');
        }
  }
}
