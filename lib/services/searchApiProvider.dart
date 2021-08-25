import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:piassa_application/models/peoples.dart';

class SearchApiProvider {
  Client client = Client();
  final _baseUrl = 'https://api.piassadating.com';

  Future<Peoples> fetchPeoplesToSearchFor() async {
    final response =
        await client.get(Uri.parse('$_baseUrl/api/user-daily-recommendations'));
    print(response.body.toString());

    if (response.statusCode == 200) {
      return Peoples.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Peoples> choosePeople() async {
    final response = await client.post(
      Uri.parse('$_baseUrl/api/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(
        {
          
        },
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
