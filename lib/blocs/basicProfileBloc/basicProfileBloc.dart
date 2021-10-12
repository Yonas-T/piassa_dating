import 'dart:async';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
import './basicProfileEvent.dart';
import './basicProfileState.dart';
import 'package:bloc/bloc.dart';

class BasicProfileBloc extends Bloc<BasicProfileEvent, BasicProfileState> {
  BasicProfileRepository? basicProfileRepository;
  MatchPreferenceRepository? matchPreferenceRepository;
  Peoples? basicProfileToProceed;
  Preference? preferencetoSubmit;

  BasicProfileBloc({required BasicProfileRepository basicProfileRepository, required MatchPreferenceRepository matchPreferenceRepository})
      : super(BasicProfileInitialState()) {
    this.basicProfileRepository = basicProfileRepository;
    this.matchPreferenceRepository = matchPreferenceRepository;
  }

  @override
  BasicProfileState? get initialState => BasicProfileInitialState();

  @override
  Stream<BasicProfileState> mapEventToState(BasicProfileEvent event) async* {
    if (event is ProceedButtonPressed) {
      yield BasicProfileLoadingState();
      try {
        print('BEFORE BLOC');

        basicProfileToProceed = Peoples(
            userName: event.userName,
            fullName: event.fullName,
            gender: event.gender,
            email: event.email,
            height: event.height,
            birthDay: event.birthDay,
            nationality: event.nationality,
            headline: event.headline,
            longitude: event.longitude,
            latitude: event.latitude);
        print(basicProfileToProceed!.userName);
        var userBasicProfile = await basicProfileRepository!.postBasicProfile(
            basicProfileToProceed!.userName,
            basicProfileToProceed!.fullName,
            basicProfileToProceed!.gender,
            basicProfileToProceed!.email,
            basicProfileToProceed!.height,
            basicProfileToProceed!.birthDay,
            basicProfileToProceed!.nationality,
            basicProfileToProceed!.headline,
            basicProfileToProceed!.latitude,
            basicProfileToProceed!.longitude);

        // yield BasicProfileSuccessState(user);
        print(userBasicProfile.userName);
        print('AFTER BLOC');
        yield BasicProfileProceedState(userBasicProfile);
      } catch (e) {
        yield BasicProfileFailState(e.toString());
      }
    }
  }
}
