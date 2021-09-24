import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';

class MatchPreferenceApiProvider {
  Client client = Client();
  final _baseUrl = 'https://api.piassadating.com';

  Future<Preference> fetchMyPreference() async {
    final response =
        await client.get(Uri.parse('$_baseUrl/api/match-preferences'));
    print(response.body.toString());

    if (response.statusCode == 200) {
      return Preference.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Preference> postMyPreference(ageStart, ageEnd, religion, educationLevel, searchRadius) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/api/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(
        {
          ageStart: ageStart,
          ageEnd: ageEnd,
          religion: religion,
          educationLevel: educationLevel,
          searchRadius: searchRadius
        },
      ),
    );

    if (response.statusCode == 200) {
      return Preference.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Preference> patchMyPreference() async {
    final response = await client.patch(
      Uri.parse('$_baseUrl/api/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(
        {},
      ),
    );

    if (response.statusCode == 200) {
      return Preference.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  // Future<String> passRecommendedUsers() async {
  //   final response = await client.post(Uri.parse('$_baseUrl/'));

  // }
}
