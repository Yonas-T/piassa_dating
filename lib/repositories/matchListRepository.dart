
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/services/matchListApiProvider.dart';

class MatchListRepository {
  MatchListApiProvider matchListApiProvider = MatchListApiProvider();

  Future<List<UserMatch>> fetchMatchList() =>
      matchListApiProvider.fetchMatchList();
  
  Future<List<UserMatch>> fetchMatchQueue() =>
      matchListApiProvider.fetchMatchQueue();

  Future<String> postLikedMatch(passLikedUsers) =>
      matchListApiProvider.postLikedMatch(passLikedUsers);
  
}
