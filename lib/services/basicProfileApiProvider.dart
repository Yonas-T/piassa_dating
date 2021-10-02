import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/utils/tokenRefresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicProfileApiProvider {
  // Client client = Client();
  final _baseUrl = 'https://api.piassadating.com';

  Future<Peoples> fetchBasicProfile() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/register'));
    print(response.body.toString());

    if (response.statusCode == 200) {
      return Peoples.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Peoples> postBasicProfile(userName, fullName, gender, email, height,
      birthDay, nationality, headline, longitude, latitude) async {
    final user = FirebaseAuth.instance.currentUser!;
    // bool gotToken = false;


    var tdata;

    print('*************************');

    Map<String, dynamic> postJson = {
      "userName": userName,
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
    print(postJson);

    print('IN THEN:  $tdata');

    final idToken = user.getIdToken(true).then((value) {
      log('000000000000000: $value');
      tdata = value;
    });

    final response = await http.post(
      Uri.parse('$_baseUrl/api/match-preferences'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'X-Authorization-Firebase': '$tdata'
      },
      body: json.encode(postJson),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Peoples.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Peoples> editBasicProfile() async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/api/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(
        {},
      ),
    );

    if (response.statusCode == 200) {
      return Peoples.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
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
