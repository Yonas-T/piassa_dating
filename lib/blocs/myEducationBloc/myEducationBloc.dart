import 'dart:async';
import 'package:piassa_application/models/education.dart';
import 'package:piassa_application/models/languageValue.dart';
import 'package:piassa_application/models/myEducation.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/repositories/myEducationRepository.dart';
import './myEducationEvent.dart';
import './myEducationState.dart';
import 'package:bloc/bloc.dart';

class MyEducationBloc extends Bloc<MyEducationEvent, MyEducationState> {
  MyEducationRepository _myEducationRepository;
  // Peoples? MyEducationToProceed;
  MyEducation? educationtoSubmit;


   MyEducationBloc({required MyEducationRepository myEducationRepository})
      : _myEducationRepository = myEducationRepository,
        super(MyEducationInitialState());


  @override
  MyEducationState get initialState => MyEducationInitialState();

  @override
  Stream<MyEducationState> mapEventToState(MyEducationEvent event) async* {
    if (event is LoadUniversitiesAndProfessions) {
      yield MyEducationLoadingState();
      try {
        final Education myEducationData =
            await _myEducationRepository.fetchMyEducation();
        final List<LanguageValue> universities =
            await _myEducationRepository.fetchUniversities();
        final List<LanguageValue> professions =
            await _myEducationRepository.fetchProfession();
        yield MyEducationLoadedState(universities, professions, myEducationData);
      } catch (e) {
        yield MyEducationFailState(e.toString());
      } 
    }
    if (event is SaveEducationButtonPressed) {
      yield MyEducationLoadingState();
      try {
        educationtoSubmit = MyEducation(
          educationLevel: event.education.educationLevel,
          company: event.education.company,
          jobTitle: event.education.jobTitle,
          professionId: event.education.professionId,
          universityId: event.education.universityId,
        );
        print('Inside the bloc: ${educationtoSubmit!.educationLevel}');
     
          var posted = await _myEducationRepository.postMyEducation(
              educationtoSubmit!.educationLevel,
              educationtoSubmit!.universityId,
              educationtoSubmit!.professionId,
              educationtoSubmit!.jobTitle,
              educationtoSubmit!.company);
    
        yield MyEducationSuccessState(posted);
      } catch (e) {
        yield MyEducationFailState(e.toString());
      }
    }

    if (event is EditEducationButtonPressed) {
      yield MyEducationLoadingState();
      try {
        educationtoSubmit = MyEducation(
          educationLevel: event.education.educationLevel,
          company: event.education.company,
          jobTitle: event.education.jobTitle,
          professionId: event.education.professionId,
          universityId: event.education.universityId,
        );
        print('Inside the bloc: ${educationtoSubmit!.educationLevel}');
     
          var posted = await _myEducationRepository.patchMyEducation(
              educationtoSubmit!.educationLevel,
              educationtoSubmit!.universityId,
              educationtoSubmit!.professionId,
              educationtoSubmit!.jobTitle,
              educationtoSubmit!.company);
    
        yield MyEducationSuccessState(posted);
      } catch (e) {
        yield MyEducationFailState(e.toString());
      }
    }
  }
}
