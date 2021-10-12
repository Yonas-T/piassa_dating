import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../repositories/authRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './phoneLoginEvent.dart';
import './phoneLoginState.dart';

class PhoneLoginBloc extends Bloc<PhoneLoginEvent, PhoneLoginState> {
  final AuthRepository? _userRepository;
  StreamSubscription? subscription;

  String verID = "";

  PhoneLoginBloc({required AuthRepository? userRepository})
      : _userRepository = userRepository,
        super(PhoneInitialLoginState());

  @override
  PhoneLoginState get initialState => PhoneInitialLoginState();

  @override
  Stream<PhoneLoginState> mapEventToState(
    PhoneLoginEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield PhoneLoadingState();

      subscription = sendOtp(event.phoNo).listen((event) {
        print('In phone Auth bloc: $event');
        add(event);
      });
    } else if (event is OtpSendEvent) {
        print('In phone OtpSendEvent: $event');
      yield OtpSentState();
    } else if (event is PhoneLoginCompleteEvent) {
      yield PhoneLoginCompleteState(event.firebaseUser);
    } else if (event is PhoneLoginExceptionEvent) {
      yield PhoneExceptionState(event.message);
    } else if (event is VerifyOtpEvent) {
      yield PhoneLoadingState();
      try {
        UserCredential result =
            await _userRepository!.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          yield PhoneLoginCompleteState(result.user!);
        } else {
          yield OtpExceptionState("Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState("Invalid otp!");
        print(e);
      }
    }
  }

  @override
  void onEvent(PhoneLoginEvent event) {
    // TODO: implement onEvent
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    // TODO: implement onError
    super.onError(error, stacktrace);
    print(stacktrace);
  }

  Future<void> close() async {
    print("Bloc closed");
    super.close();
  }

  Stream<PhoneLoginEvent> sendOtp(String phoNo) async* {
    StreamController<PhoneLoginEvent> eventStream = StreamController();
    final phoneVerificationCompleted = (AuthCredential authCredential) {
      _userRepository!.getCurrentUser();
      _userRepository!.getCurrentUser().catchError((onError) {
        print(onError);
      }).then((user) {
        eventStream.add(PhoneLoginCompleteEvent(user!));
        eventStream.close();
      });
    };
    final phoneVerificationFailed = (FirebaseAuthException authException) {
      print(authException.message);
      eventStream.add(PhoneLoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final phoneCodeSent = (String verId, [int? forceResent]) {
      this.verID = verId;
      eventStream.add(OtpSendEvent());
    };
    final phoneCodeAutoRetrievalTimeout = (String verid) {
      this.verID = verid;
      eventStream.close();
    };

    await _userRepository!.sendOtp(
        phoNo,
        Duration(seconds: 1),
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }
}
