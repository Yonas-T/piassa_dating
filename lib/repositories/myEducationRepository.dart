import 'package:piassa_application/models/education.dart';
import 'package:piassa_application/models/languageValue.dart';
import 'package:piassa_application/models/myEducation.dart';
import 'package:piassa_application/services/myEducationApiProvider.dart';

class MyEducationRepository {
  MyEducationApiProvider myEducationProvider =
      MyEducationApiProvider();

  Future<List<LanguageValue>> fetchUniversities() =>
      myEducationProvider.fetchUniversities();

  Future<List<LanguageValue>> fetchProfession() =>
      myEducationProvider.fetchProfession();

  Future<Education> fetchMyEducation() =>
      myEducationProvider.fetchMyEducation();

  Future<Education> patchMyEducation(educationLevel, universityId, professionId, jobTitle, company) =>
      myEducationProvider.patchMyEducation(educationLevel, universityId, professionId, jobTitle, company);

  Future<Education> postMyEducation(
          educationLevel, universityId, professionId, jobTitle, company) =>
      myEducationProvider.postMyEducation(educationLevel, universityId, professionId, jobTitle, company);

}
