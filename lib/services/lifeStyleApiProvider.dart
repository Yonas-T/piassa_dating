import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/lifeStyle.dart';

class LifeStyleApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<LifeStyle> fetchLifeStyle() async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/life-styles'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      print(response.body.toString());

      if (response.statusCode == 200) {
        return LifeStyle.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<LifeStyle> postLifeStyle(id, smooking, drinking, kids, religion,
      physicalExercise, relationshipStatus) async {
    print('=============================');
    Map<dynamic, dynamic> postJson = {
      "smooking": smooking,
      "drinking": drinking,
      "kids": kids,
      "religion": religion,
      "physicalExercise": physicalExercise,
      "relationshipStatus": relationshipStatus
    };
    print('POSTJSON: $postJson');
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      // log(value);
      final response = await http.post(
        Uri.parse('$_baseUrl/api/life-styles'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: json.encode(postJson),
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return LifeStyle.fromJson({
          "smooking": smooking,
          "drinking": drinking,
          "kids": kids,
          "religion": religion,
          "physicalExercise": physicalExercise,
          "relationshipStatus": relationshipStatus
        });
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<LifeStyle> patchLifeStyle(id, smooking, drinking, kids, religion,
      physicalExercise, relationshipStatus) async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      print('in api request');

      final response = await http.put(
        Uri.parse('$_baseUrl/api/life-styles'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: jsonEncode(
          {
            "smooking": smooking,
            "drinking": drinking,
            "kids": kids,
            "religion": religion,
            "physicalExercise": physicalExercise,
            "relationshipStatus": relationshipStatus
          },
        ),
      );
      print('RESPONSE: ${response.body}');
      if (response.statusCode == 200) {
        return LifeStyle.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }
}
