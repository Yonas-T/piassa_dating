import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/utils/tokenRefresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MyProfileApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserMatch> fetchMyProfile() async {
    print(auth.currentUser);
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      var myId = auth.currentUser!.uid;
      final response = await http.get(
        Uri.parse('$_baseUrl/api/users/username/$myId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      // print('Profile Fetched: ${response.body.toString()}');

      if (response.statusCode == 200) {
        return UserMatch.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }
}
