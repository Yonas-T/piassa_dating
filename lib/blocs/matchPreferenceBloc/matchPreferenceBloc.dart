import 'dart:async';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
import './matchPreferenceEvent.dart';
import './matchPreferenceState.dart';
import 'package:bloc/bloc.dart';

class MatchPreferenceBloc extends Bloc<MatchPreferenceEvent, MatchPreferenceState> {
  MatchPreferenceRepository? matchPreferenceRepository;
  // Peoples? matchPreferenceToProceed;
  Preference? preferencetoSubmit;

  MatchPreferenceBloc({required MatchPreferenceRepository matchPreferenceRepository})
      : super(MatchPreferenceInitialState()) {
    this.matchPreferenceRepository = matchPreferenceRepository;
  }

  @override
  MatchPreferenceState? get initialState => MatchPreferenceInitialState();

  @override
  Stream<MatchPreferenceState> mapEventToState(MatchPreferenceEvent event) async* {
    if (event is SubmitButtonPressed) {
      yield MatchPreferenceLoadingState();
      try {
       
        preferencetoSubmit = Preference(
            // gender: event.gender,
            ageStart: event.ageStart,
            ageEnd: event.ageEnd,
            religion: event.religion,
            educationLevel: event.educationLevel,
            searchRadius: event.searchRadius,
            gender: event.gender,
            id: event.id
            );
        print('Inside the bloc: ${preferencetoSubmit!.educationLevel}');

        Preference userMatchPreference = await matchPreferenceRepository!
            .postMyPreference(
                preferencetoSubmit!.ageStart,
                preferencetoSubmit!.ageEnd,
                preferencetoSubmit!.religion,
                preferencetoSubmit!.educationLevel,
                preferencetoSubmit!.searchRadius);
        print('MATCH PREF: $userMatchPreference');
        yield MatchPreferenceSuccessState();
      } catch (e) {
        yield MatchPreferenceFailState(e.toString());
      }
    }
  }
}









