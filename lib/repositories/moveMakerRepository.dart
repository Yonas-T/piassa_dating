import 'package:piassa_application/models/userMoveMaker.dart';
import 'package:piassa_application/services/moveMakerApiProvider.dart';

class MoveMakerRepository {
  MoveMakerApiProvider moveMakerProvider =
      MoveMakerApiProvider();

  Future<List<MoveMaker>> fetchMoveMaker() =>
      moveMakerProvider.fetchMoveMaker();

  // Future<List<MoveMaker>> patchMoveMaker(moveMakerAnswers) =>
  //     moveMakerProvider.patchMoveMaker(moveMakerAnswers);

  Future<List<UserMoveMaker>> postMoveMaker(
          moveMakerAnswers) =>
      moveMakerProvider.postMoveMaker(moveMakerAnswers);

}
