import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/services/basicProfileApiProvider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRefresh {
  String? _token;
  String? _refreshToken;
  DateTime? _expiryDate;
  String? _userId;

  // String? get token {
  //   if (_expiryDate != null &&
  //       _expiryDate!.isAfter(DateTime.now()) &&
  //       _token != null &&
  //       _refreshToken != null) {
  //     // print(token);
  //     return _token;
  //   }
  //   refreshSession(token);
  //   return null;
  // }

  Future<String> refreshSession() async {
    const WEB_API_KEY = 'AIzaSyDNczMIfz0WbjMO-NKaBlfOvffonwLJSJc';
    final url = 'https://securetoken.googleapis.com/v1/token?key=$WEB_API_KEY';

    var tokRef;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    tokRef = prefs.getString('token');
    // DataJson dtjson = DataJson.fromJson(jsonDecode(tokRef));
    // var refTkn = dtjson.refreshToken;

    try {
      // print('AAAAAAAAAAAAAAAAAAAAAAAAAA');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': '$tokRef',
        },
      );
      // print('BBBBBBBBBBBBBBBBBBBBBBBBB');
      final responseData = json.decode(response.body);
      // print(responseData);
      if (responseData['error'] != null) {
        // print('EEEEEEEEEEEEEEEEEEEEEEEEEE');
        throw Exception(responseData['error']['message']);
      }
      _token = responseData['id_token'];
      _refreshToken =
          responseData['refresh_token']; // Also save your refresh token
      // print('RRRRRRRRRRRRRRRRRRRRRRRR');
      _userId = responseData['user_id'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expires_in'])));

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'refresh_token': _refreshToken,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
      return userData;
    } catch (error) {
      throw error;
    }
  }
}
