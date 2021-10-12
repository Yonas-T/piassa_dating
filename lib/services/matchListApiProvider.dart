import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/userMatch.dart';

class MatchListApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<UserMatch>> fetchMatchList() async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/user-matches'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      print(response.body.toString());

      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        var matches = list.map((model) => UserMatch.fromJson(model)).toList();
        return matches;
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<List<UserMatch>> fetchMatchQueue() async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      print('ttttttttttttttttttt');
      final response = await http.get(
        Uri.parse('$_baseUrl/api/user-daily-recommendations/liked'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      print(response.body.toString());

      if (response.statusCode == 200) {
        Iterable queue = json.decode(response.body);
        var matcheQueue =
            queue.map((model) => UserMatch.fromJson(model)).toList();
        return matcheQueue;
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<String> postLikedMatch(likedId) async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/user-daily-recommendations/$likedId/liked'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: json.encode(
          {},
        ),
      );
      print(response.statusCode);
      print(response.headers);
      if (response.statusCode == 200) {
        return 'response.body';
        // json.decode(response.body)
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }
}
