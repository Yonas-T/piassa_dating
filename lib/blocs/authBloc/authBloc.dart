import 'package:piassa_application/services/basicProfileApiProvider.dart';

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
      yield AuthInitialState();
      try {
        final isSignedIn = await userRepository!.isSignedIn();
        print('IS SIGNED IN: $isSignedIn');
        if (isSignedIn) {
          var user = await userRepository!.getCurrentUser();
          print('in signed in $user');
          var profData;
          BasicProfileApiProvider()
              .fetchEntireProfile()
              .then((value) => profData = value);
          print('AUTH USER: $user');
          yield AuthenticatedState(user, profData);
        } else {
          yield UnauthenticatedState('Is signed in: false');
        }
      } catch (e) {
        yield UnauthenticatedState(e.toString());
      }
    }

    if (event is LoggedIn) {
      var profData;
      BasicProfileApiProvider()
          .fetchEntireProfile()
          .then((value) => profData = value);
      yield AuthenticatedState(
          await userRepository!.getCurrentUser(), profData);
    }

    if (event is LoggedOut) {
      yield UnauthenticatedState('');
      userRepository!.signOut();
    }

    if (event is LogOutEvent) {
      // yield UnauthenticatedState();

      userRepository!.signOut();
      yield LogOutSuccessState();
    } else {
      yield UnauthenticatedState('');
    }
  }
}
