import 'dart:convert';
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
    // final user = await FirebaseAuth.instance.currentUser!;
    // final idToken = user.getIdToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var refreshData;
    TokenRefresh().refreshSession().then((value) {
      refreshData = prefs.getString('userData');
      print('============== $refreshData');
    });
    var tokRef;
    final user = FirebaseAuth.instance.currentUser!;

    // var refreshData = prefs.getString('userData');

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
    // print('ID TOKEN: $idToken');
    // var refreshedToken = TokenRefresh().token;
    // print('ID TOKEN: $idToken');
    // final refreshIdToken = user.getIdTokenResult(true).then((value) {
    //   print('REFRESH: $value');

    //   tokRef = value.token;
    // }).then((value) async {
      print('IN THEN:  $refreshData');
      final response = await http.post(
        Uri.parse('$_baseUrl/api/match-preferences'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Content-type' : 'application/json',
          'Accept': 'application/json',
          'X-Authorization-Firebase': 'Bearer $refreshData'
        },
        body: json.encode(postJson),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return Peoples.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    // });
    // return refreshIdToken;
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

  // Future<String> passRecommendedUsers() async {
  //   final response = await client.post(Uri.parse('$_baseUrl/'));

  // }
}
