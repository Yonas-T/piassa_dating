import 'dart:async';
import 'package:piassa_application/models/myEducation.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/repositories/MyEducationRepository.dart';
import './myEducationEvent.dart';
import './myEducationState.dart';
import 'package:bloc/bloc.dart';

class MyEducationBloc
    extends Bloc<MyEducationEvent, MyEducationState> {
  MyEducationRepository? myEducationRepository;
  // Peoples? MyEducationToProceed;
  MyEducation? educationtoSubmit;

  MyEducationBloc(
      {required MyEducationRepository MyEducationRepository})
      : super(MyEducationInitialState()) {
    this.myEducationRepository = myEducationRepository;
  }

  @override
  MyEducationState? get initialState => MyEducationInitialState();

  @override
  Stream<MyEducationState> mapEventToState(
      MyEducationEvent event) async* {
    if (event is SaveButtonPressed) {
      yield MyEducationLoadingState();
      try {
        educationtoSubmit = MyEducation(
          company: educationtoSubmit!.company, 
          educationLevel: educationtoSubmit!.educationLevel, 
          jobTitle: educationtoSubmit!.jobTitle, 
          professionId: educationtoSubmit!.professionId, 
          universityId: educationtoSubmit!.universityId);
        print('Inside the bloc: ${educationtoSubmit!.educationLevel}');
        bool x = event.isEdit!;
        print('bool $x');
        if (x) {
          await myEducationRepository!
              .patchMyEducation(
                  educationtoSubmit!.educationLevel,
                  educationtoSubmit!.universityId,
                  educationtoSubmit!.professionId,
                  educationtoSubmit!.jobTitle,
                  educationtoSubmit!.company);
        } else {
          await myEducationRepository!
              .postMyEducation(
                  educationtoSubmit!.educationLevel,
                  educationtoSubmit!.universityId,
                  educationtoSubmit!.professionId,
                  educationtoSubmit!.jobTitle,
                  educationtoSubmit!.company);
        }

        // print('MATCH PREF: $userMyEducation');
        yield MyEducationSuccessState();
      } catch (e) {
        yield MyEducationFailState(e.toString());
      }
    }
  }
}
