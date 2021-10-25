import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/userMoveMaker.dart';
import 'package:uuid/uuid.dart';

class MoveMakerApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;
  var idGenerate = Uuid();

  Future<List<MoveMaker>> fetchMoveMaker() async {
    print('inside request');
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/random-move-makers?size=3'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      print(response.body.toString());

      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<MoveMaker> movemakers =
            List<MoveMaker>.from(l.map((model) => MoveMaker.fromJson(model)));
        return movemakers;
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<List<UserMoveMaker>> postMoveMaker(
      List<PostMoveMaker> moveMakerAnswers) async {
    print('=============================');
    // Map<dynamic, dynamic> postJson = {
    //   "ageStart": ageStart,
    //   "ageEnd": ageEnd,
    //   "religion": religion,
    //   "educationLevel": educationLevel,
    //   "searchRadius": searchRadius
    // };
    // print('POSTJSON: $postJson');
    print(moveMakerAnswers);
    List moveMakerJson = [];
    moveMakerJson.clear();
    moveMakerAnswers.forEach((element) {
      moveMakerJson.add(element.toJson());
    });
    print(moveMakerJson);
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      // log(value);
      final response = await http.post(
        Uri.parse('$_baseUrl/api/user-move-makers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: json.encode(moveMakerJson),
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Iterable l = json.decode(response.body);
        List<UserMoveMaker> movemakersAnswer = List<UserMoveMaker>.from(
            l.map((model) => UserMoveMaker.fromJson(model)));
        return movemakersAnswer;
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  // Future<List<MoveMaker>> patchMoveMaker(
  //     moveMakerAnswers) async {
  //   var cc = auth.currentUser!.getIdToken(true).then((value) async {
  //     print('in api request');

  //     final response = await http.put(
  //       Uri.parse('$_baseUrl/api/random-move-makers?size=3'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Accept': 'application/json',
  //         'X-Authorization-Firebase': '$value'
  //       },
  //       body: jsonEncode(
  //         {
  //           // 'id': id,
  //           // 'question': question,

  //         },
  //       ),
  //     );
  //     print('RESPONSE: ${response.body}');
  //     if (response.statusCode == 200) {

  //       return MoveMaker.fromJson(json.decode(response.body));
  //     } else {
  //       throw Exception('Failed to load');
  //     }
  //   });
  //   return cc;
  // }
}
