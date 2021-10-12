import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/services/matchPreferenceApiProvider.dart';

class MatchPreferenceRepository {
  MatchPreferenceApiProvider matchPreferenceProvider =
      MatchPreferenceApiProvider();

  Future<Preference> fetchMyPreference() =>
      matchPreferenceProvider.fetchMyPreference();

  Future<Preference> patchMyPreference(ageStart, ageEnd, religion, educationLevel, searchRadius) =>
      matchPreferenceProvider.patchMyPreference(ageStart, ageEnd, religion, educationLevel, searchRadius);

  Future<Preference> postMyPreference(
          ageStart, ageEnd, religion, educationLevel, searchRadius) =>
      matchPreferenceProvider.postMyPreference(ageStart, ageEnd, religion, educationLevel, searchRadius);

}
