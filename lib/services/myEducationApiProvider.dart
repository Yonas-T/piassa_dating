import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/education.dart';
import 'package:piassa_application/models/languageValue.dart';
import 'package:piassa_application/models/myEducation.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/services/basicProfileApiProvider.dart';
import 'package:uuid/uuid.dart';

class MyEducationApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;
  
    Future<List<LanguageValue>> fetchUniversities() async {
    var tok = await auth.currentUser!.getIdToken(true);
    final response = await http.get(
      Uri.parse('$_baseUrl/api/universities'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'X-Authorization-Firebase': '$tok'
      },
    );
    print('UNiversity Fetched: ${response.body.toString()}');

    if (response.statusCode == 200) {
      List<LanguageValue> universities = [];

      Iterable l = json.decode(response.body);
      universities = List<LanguageValue>.from(
          l.map((model) => LanguageValue.fromJson(model)));

      return universities;
    } else {
      throw Exception('Failed to load');
    }
  }
  
  Future<List<LanguageValue>> fetchProfession() async {
    var tok = await auth.currentUser!.getIdToken(true);
    final response = await http.get(
      Uri.parse('$_baseUrl/api/professions'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'X-Authorization-Firebase': '$tok'
      },
    );
    print('UNiversity Fetched: ${response.body.toString()}');

    if (response.statusCode == 200) {
      List<LanguageValue> professions = [];

      Iterable l = json.decode(response.body);
      professions = List<LanguageValue>.from(
          l.map((model) => LanguageValue.fromJson(model)));

      return professions;
    } else {
      throw Exception('Failed to load');
    }
  }


  Future<Education> fetchMyEducation() async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/educations'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Education.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<Education> postMyEducation(
      educationLevel, universityId, professionId, jobTitle, company) async {
    print('=============================');
    Map<dynamic, dynamic> postJson = {
      "educationLevel": educationLevel,
      "universityId": universityId,
      "professionId": professionId,
      "jobTitle": jobTitle,
      "company": company
    };
    print('POSTJSON: $postJson');
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      // log(value);
      final response = await http.post(
        Uri.parse('$_baseUrl/api/educations'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: json.encode(postJson),
      );
      print(response.statusCode);
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Education.fromJson(
        //   {
        //   "educationLevel": educationLevel,
        //   "universityId": universityId,
        //   "professionId": professionId,
        //   "jobTitle": jobTitle,
        //   "company": company
        // }
            json.decode(response.body)
            );
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<Education> patchMyEducation(
      educationLevel, universityId, professionId, jobTitle, company) async {
    Peoples myProfile = await BasicProfileApiProvider().fetchBasicProfile();
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      print('in api request');

      final response = await http.put(
        Uri.parse('$_baseUrl/api/educations'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: jsonEncode(
          {
            "id": myProfile.id,
            "educationLevel": educationLevel,
            "universityId": universityId,
            "professionId": professionId,
            "jobTitle": jobTitle,
            "company": company
          },
        ),
      );
      print('RESPONSE: ${response.body}');
      if (response.statusCode == 200) {
        return Education.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }
}
