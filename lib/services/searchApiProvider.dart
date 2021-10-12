import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';

class SearchApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<UserMatch>> fetchPeoplesToSearchFor() async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/user-daily-recommendations'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      log(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<UserMatch> matchRecommendations =
            List<UserMatch>.from(l.map((model) => UserMatch.fromJson(model)));
        print('Match Recomm: ${json.encode(matchRecommendations)}');
        return matchRecommendations;
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<String> choosePeople(recommendedId) async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.post(
        Uri.parse(
            '$_baseUrl/api/user-daily-recommendations/$recommendedId/like'),
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
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<String> passRecommendedUsers(recommendedId) async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.post(
        Uri.parse(
            '$_baseUrl/api/user-daily-recommendations/$recommendedId/pass'),
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
