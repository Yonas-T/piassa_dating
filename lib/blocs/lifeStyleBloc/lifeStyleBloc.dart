import 'dart:async';
import 'package:piassa_application/models/LifeStyle.dart';
import 'package:piassa_application/repositories/lifeStyleRepository.dart';
import './lifeStyleEvent.dart';
import './lifeStyleState.dart';
import 'package:bloc/bloc.dart';

class LifeStyleBloc extends Bloc<LifeStyleEvent, LifeStyleState> {
  LifeStyleRepository? lifeStyleRepository;
  // Peoples? LifeStyleToProceed;
  LifeStyle? lifeStyleToSubmit;

  LifeStyleBloc({required LifeStyleRepository lifeStyleRepository})
      : super(LifeStyleInitialState()) {
    this.lifeStyleRepository = lifeStyleRepository;
  }

  @override
  LifeStyleState? get initialState => LifeStyleInitialState();

  @override
  Stream<LifeStyleState> mapEventToState(LifeStyleEvent event) async* {
    if (event is SaveLifeStyleButtonPressed) {
      yield LifeStyleLoadingState();
      try {
        print('after pressed');
        lifeStyleToSubmit = LifeStyle(
            id: '',
            smooking: event.smooking,
            drinking: event.drinking,
            kids: event.kids,
            religion: event.religion,
            physicalExercise: event.physicalExercise,
            relationshipStatus: event.relationshipStatus);
        print('Inside the bloc: ${lifeStyleToSubmit!.drinking}');
        // bool x = event.isEdit!;
        // print('bool $x');
        // if (x) {
        //   await lifeStyleRepository!.patchLifeStyle(
        //       lifeStyleToSubmit!.id,
        //       lifeStyleToSubmit!.smooking,
        //       lifeStyleToSubmit!.drinking,
        //       lifeStyleToSubmit!.kids,
        //       lifeStyleToSubmit!.religion,
        //       lifeStyleToSubmit!.physicalExercise,
        //       lifeStyleToSubmit!.relationshipStatus);
        // } else {
        await lifeStyleRepository!.postLifeStyle(
            lifeStyleToSubmit!.id,
            lifeStyleToSubmit!.smooking,
            lifeStyleToSubmit!.drinking,
            lifeStyleToSubmit!.kids,
            lifeStyleToSubmit!.religion,
            lifeStyleToSubmit!.physicalExercise,
            lifeStyleToSubmit!.relationshipStatus);
        // }

        // print('MATCH PREF: $userLifeStyle');
        yield LifeStyleSuccessState();
      } catch (e) {
        yield LifeStyleFailState(e.toString());
      }
    }
  }
}
