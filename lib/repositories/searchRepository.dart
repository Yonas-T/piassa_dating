import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/services/searchApiProvider.dart';

class SearchRepository {
  SearchApiProvider searchApiProvider = SearchApiProvider();

  Future<Peoples> fetchPeoplesToSearchFor() =>
      searchApiProvider.fetchPeoplesToSearchFor();

  // Future<Peoples> choosePeople() async {
  //   searchApiProvider.choosePeople();
  // }
}
