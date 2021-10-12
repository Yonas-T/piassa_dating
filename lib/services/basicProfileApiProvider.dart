import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/utils/tokenRefresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class BasicProfileApiProvider {
  // Client client = Client();
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;
  var idGenerate = Uuid();

  Future<Peoples> fetchBasicProfile() async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/account'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      print(response.body.toString());

      if (response.statusCode == 200) {
        return Peoples.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<Peoples> postBasicProfile(userName, fullName, gender, email, height,
      birthDay, nationality, headline, longitude, latitude) async {
    var userid = idGenerate.v4();

    print('UID: $userid');
    Map<String, dynamic> postJson = {
      "id": userid,
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
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      log(value);
      final response = await http.post(
        Uri.parse('$_baseUrl/api/register'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: json.encode(postJson),
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Peoples.fromJson({
          "id": userid,
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
    });
    return cc;

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

class DataJson {
  String? token;
  String? refreshToken;

  DataJson({required this.token, required this.refreshToken});

  DataJson.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refresh_token'];
  }
}

class DataToken {
  late String token;
  late String refreshToken;
  late String userId;
  late String expiryDate;

  DataToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refresh_token'];
    userId = json['userId'];
    expiryDate = json['expiryDate'];
  }
}
