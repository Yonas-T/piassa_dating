import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/services/searchApiProvider.dart';

class SearchRepository {
  SearchApiProvider searchApiProvider = SearchApiProvider();

  Future<List<UserMatch>> fetchPeoplesToSearchFor() =>
      searchApiProvider.fetchPeoplesToSearchFor();

  Future<String> choosePeople(recommendedId) => searchApiProvider.choosePeople(recommendedId);

  Future<String> passRecommendedUsers(recommendedId) =>
      searchApiProvider.passRecommendedUsers(recommendedId);
}
