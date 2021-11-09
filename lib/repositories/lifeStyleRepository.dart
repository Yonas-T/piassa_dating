import 'package:piassa_application/models/lifeStyle.dart';
import 'package:piassa_application/services/lifeStyleApiProvider.dart';

class LifeStyleRepository {
  LifeStyleApiProvider lifeStyleProvider =
      LifeStyleApiProvider();

  Future<LifeStyle> fetchLifeStyle() =>
      lifeStyleProvider.fetchLifeStyle();

  Future<LifeStyle> patchLifeStyle(id, smooking, drinking, kids, religion, physicalExercise, relationshipStatus) =>
      lifeStyleProvider.patchLifeStyle(id, smooking, drinking, kids, religion, physicalExercise, relationshipStatus);

  Future<LifeStyle> postLifeStyle(
         id, smooking, drinking, kids, religion, physicalExercise, relationshipStatus) =>
      lifeStyleProvider.postLifeStyle(id, smooking, drinking, kids, religion, physicalExercise, relationshipStatus);

}
