import 'package:piassa_application/models/myEducation.dart';
import 'package:piassa_application/services/myEducationApiProvider.dart';

class MyEducationRepository {
  MyEducationApiProvider myEducationProvider =
      MyEducationApiProvider();

  Future<MyEducation> fetchMyEducation() =>
      myEducationProvider.fetchMyEducation();

  Future<MyEducation> patchMyEducation(educationLevel, universityId, professionId, jobTitle, company) =>
      myEducationProvider.patchMyEducation(educationLevel, universityId, professionId, jobTitle, company);

  Future<MyEducation> postMyEducation(
          educationLevel, universityId, professionId, jobTitle, company) =>
      myEducationProvider.postMyEducation(educationLevel, universityId, professionId, jobTitle, company);

}
