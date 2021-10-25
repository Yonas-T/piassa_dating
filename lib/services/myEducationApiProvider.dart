import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/myEducation.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:uuid/uuid.dart';

class MyEducationApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;
  var idGenerate = Uuid();

  Future<MyEducation> fetchMyEducation() async {
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

      if (response.statusCode == 200) {
        return MyEducation.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<MyEducation> postMyEducation(
      educationLevel, universityId, professionId, jobTitle, company) async {
    print('=============================');
    Map<dynamic, dynamic> postJson = {
      "ageStart": educationLevel,
      "ageEnd": universityId,
      "religion": professionId,
      "educationLevel": jobTitle,
      "searchRadius": company
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MyEducation.fromJson({
          "ageStart": educationLevel,
          "ageEnd": universityId,
          "religion": professionId,
          "educationLevel": jobTitle,
          "searchRadius": company
        }
            // json.decode(response.body)
            );
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<MyEducation> patchMyEducation(
      educationLevel, universityId, professionId, jobTitle, company) async {
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
        return MyEducation.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }
}
