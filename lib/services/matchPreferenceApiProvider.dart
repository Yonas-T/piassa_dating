import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:uuid/uuid.dart';

class MatchPreferenceApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;
  var idGenerate = Uuid();

  Future<Preference> fetchMyPreference() async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/match-preferences'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      print(response.body.toString());

      if (response.statusCode == 200) {
        return Preference.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<Preference> postMyPreference(
      ageStart, ageEnd, religion, educationLevel, searchRadius) async {
    print('=============================');
    Map<dynamic, dynamic> postJson = {
      "ageStart": ageStart,
      "ageEnd": ageEnd,
      "religion": religion,
      "educationLevel": educationLevel,
      "searchRadius": searchRadius
    };
    print('POSTJSON: $postJson');
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      log(value);
      final response = await http.post(
        Uri.parse('$_baseUrl/api/match-preferences'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: json.encode(postJson),
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Preference.fromJson({
          "ageStart": ageStart,
          "ageEnd": ageEnd,
          "religion": religion,
          "educationLevel": educationLevel,
          "searchRadius": searchRadius
        }
            // json.decode(response.body)
            );
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<Preference> patchMyPreference(
      ageStart, ageEnd, religion, educationLevel, searchRadius) async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.put(
        Uri.parse('$_baseUrl/api/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
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
    });
    return cc;
  }
}
