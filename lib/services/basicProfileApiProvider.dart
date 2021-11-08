import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/utils/tokenRefresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicProfileApiProvider {
  // Client client = Client();
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Peoples> fetchBasicProfile() async {
    var cc = await auth.currentUser!.getIdToken(true);
    // .then((value) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/account'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'X-Authorization-Firebase': '$cc'
      },
    );
    print('Profile Fetched: ${response.body}');
    print('Profile Fetched: ${response.statusCode}');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return Peoples.fromJson(json.decode(response.body));
      }
      return Peoples.fromJson({});
    } else {
      throw Exception('Failed to load');
    }
    // });
    // return cc;
  }

  Future<UserMatch?> fetchEntireProfile() async {
    // var vv;
    String tok = await auth.currentUser!.getIdToken(true);
    print('TOKEN: $tok');
    // auth.currentUser!.getIdToken(true).then((value) async {
    // var response;
    var vv = await fetchBasicProfile();

    // var vv = fetchBasicProfile().then((prof) async {
    if (vv.id != null) {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/users/${vv.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$tok'
        },
      );
      print('Profile Entire Fetched: ${response.body.toString()}');

      if (response.statusCode == 200) {
        return UserMatch.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    } else {
      return null;
    }

    // });
    // });
    // return vv;
  }

  Future<Peoples> postBasicProfile(userName, fullName, gender, email, height,
      birthDay, nationality, headline, longitude, latitude) async {
    Map<String, dynamic> postJson = {
      "userName": auth.currentUser!.uid,
      "email": email,
      "fullName": fullName,
      "gender": gender,
      "height": height,
      "birthDay": birthDay,
      "nationality": nationality,
      "headline": headline,
      "latitude": latitude,
      "longitude": longitude
    };

    print(postJson);
    // var tk = '';
    var tok = await auth.currentUser!.getIdToken(true);

    final response = await http.post(
      Uri.parse('$_baseUrl/api/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'X-Authorization-Firebase': '$tok'
      },
      body: json.encode(postJson),
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Peoples.fromJson({
        "userName": auth.currentUser!.uid,
        "email": email,
        "fullName": fullName,
        "gender": gender,
        "height": height,
        "birthDay": birthDay,
        "nationality": nationality,
        "headline": headline,
        "latitude": latitude,
        "longitude": longitude
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Peoples> editBasicProfile(userName, fullName, gender, email, height,
      birthDay, nationality, headline, longitude, latitude) async {
    Map<String, dynamic> postJson = {
      "userName": auth.currentUser!.uid,
      "fullName": fullName,
      "gender": gender,
      "email": email,
      "height": height,
      "birthDay": birthDay,
      "nationality": nationality,
      "headline": headline,
      "longitude": longitude,
      "latitude": latitude
    };

    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.put(
        Uri.parse('$_baseUrl/api/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(
          {postJson},
        ),
      );

      if (response.statusCode == 200) {
        return Peoples.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }
}

// class DataJson {
//   String? token;
//   String? refreshToken;

//   DataJson({required this.token, required this.refreshToken});

//   DataJson.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     refreshToken = json['refresh_token'];
//   }
// }

// class DataToken {
//   late String token;
//   late String refreshToken;
//   late String userId;
//   late String expiryDate;

//   DataToken.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     refreshToken = json['refresh_token'];
//     userId = json['userId'];
//     expiryDate = json['expiryDate'];
//   }
// }
