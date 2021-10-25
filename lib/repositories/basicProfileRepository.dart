import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/services/basicProfileApiProvider.dart';

class BasicProfileRepository {
  BasicProfileApiProvider basicProfileApiProvider = BasicProfileApiProvider();

  Future<Peoples> fetchBasicProfile() =>
      basicProfileApiProvider.fetchBasicProfile();

  Future<UserMatch> fetchEntireProfile() =>
      basicProfileApiProvider.fetchEntireProfile();

  Future<Peoples> editBasicProfile(userName, fullName, gender, email, height,
          birthDay, nationality, headline, longitude, latitude) =>
      basicProfileApiProvider.editBasicProfile(userName, fullName, gender, email, height,
          birthDay, nationality, headline, longitude, latitude);

  Future<Peoples> postBasicProfile(userName, fullName, gender, email, height,
          birthDay, nationality, headline, longitude, latitude) =>
      basicProfileApiProvider.postBasicProfile(userName, fullName, gender,
          email, height, birthDay, nationality, headline, longitude, latitude);
}
