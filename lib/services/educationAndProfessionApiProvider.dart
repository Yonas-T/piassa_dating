import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/languageValue.dart';
import 'package:piassa_application/models/myEducation.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/utils/tokenRefresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class EducationAndProfessionApiProvider {
  // Client client = Client();
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<LanguageValue>> fetchEducation() async {
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

  Future<MyEducation> postEducationandProfession(
      educationLevel, universityId, professionId, jobTitle, company) async {
    Map<String, dynamic> postJson = {
      "educationLevel": educationLevel,
      "universityId": universityId,
      "professionId": professionId,
      "jobTitle": jobTitle,
      "company": company
    };

    // print(postJson);
    // var tk = '';
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      // log(value);
      final response = await http.post(
        Uri.parse('$_baseUrl/api/educations'),
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
        return MyEducation.fromJson({
          "educationLevel": educationLevel,
          "universityId": universityId,
          "professionId": professionId,
          "jobTitle": jobTitle,
          "company": company,
        });
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<MyEducation> editEducationandProfession(
      educationLevel, universityId, professionId, jobTitle, company) async {
    Map<String, dynamic> postJson = {
      "educationLevel": educationLevel,
      "universityId": universityId,
      "professionId": professionId,
      "jobTitle": jobTitle,
      "company": company
    };

    // print(postJson);
    // var tk = '';
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      // log(value);
      final response = await http.put(
        Uri.parse('$_baseUrl/api/educations'),
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
        return MyEducation.fromJson({
          "educationLevel": educationLevel,
          "universityId": universityId,
          "professionId": professionId,
          "jobTitle": jobTitle,
          "company": company,
        });
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }
}
