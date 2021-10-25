import 'dart:async';
import 'package:piassa_application/models/userMoveMaker.dart';
import 'package:piassa_application/repositories/moveMakerRepository.dart';
import './moveMakerEvent.dart';
import './moveMakerState.dart';
import 'package:bloc/bloc.dart';

class MoveMakerBloc extends Bloc<MoveMakerEvent, MoveMakerState> {
  MoveMakerRepository? moveMakerRepository;
  // Peoples? MoveMakerToProceed;
  MoveMaker? moveMakerToSubmit;

  MoveMakerBloc({required MoveMakerRepository moveMakerRepository})
      : super(MoveMakerInitialState()) {
    this.moveMakerRepository = moveMakerRepository;
  }

  @override
  MoveMakerState? get initialState => MoveMakerInitialState();

  @override
  Stream<MoveMakerState> mapEventToState(MoveMakerEvent event) async* {
    if (event is LoadMoveMaker) {
      yield MoveMakerLoadingState();
      try {
        List<MoveMaker> mvMaker = await moveMakerRepository!.fetchMoveMaker();
        yield GotMoveMakersState(mvMaker: mvMaker);
      } catch (e) {}
    }
    if (event is SaveMoveMakerButtonPressed) {
      yield MoveMakerLoadingState();
      try {
        // print('Inside the bloc: ${moveMakerToSubmit!.question}');
        // bool x = event.isEdit!;
        // print('bool $x');
        // if (x) {
        //   await MoveMakerRepository!.patchMoveMaker(event.moveMakerAnswers);
        // } else {
        await moveMakerRepository!.postMoveMaker(event.moveMakerAnswers);
        // }

        // print('MATCH PREF: $userMoveMaker');
        yield MoveMakerSuccessState();
      } catch (e) {
        yield MoveMakerFailState(e.toString());
      }
    }
  }
}
