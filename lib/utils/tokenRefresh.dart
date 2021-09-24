import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRefresh {
  String? _token;
  String? _refreshToken;
  DateTime? _expiryDate;
  String? _userId;

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null &&
        _refreshToken != null) {
      print(token);
      return _token;
    }
    refreshSession();
    return null;
  }

  Future<void> refreshSession() async {
    const WEB_API_KEY = 'AIzaSyChnA7WouVZp5XsEwB5y3aRcBY86oJpyPU';
    final url = 'https://securetoken.googleapis.com/v1/token?key=$WEB_API_KEY';
    //$WEB_API_KEY=> You should write your web api key on your firebase project.
    var tokRef;
    final user = FirebaseAuth.instance.currentUser!;

    final refreshIdToken = user.getIdTokenResult().then((value) {
      print('REFRESH: $value');
   
      tokRef = value.token;
    }).then((value) async {
      try {
        print('AAAAAAAAAAAAAAAAAAAAAAAAAA: $tokRef');
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
        print('BBBBBBBBBBBBBBBBBBBBBBBBB: $tokRef');
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData['error'] != null) {
          print('EEEEEEEEEEEEEEEEEEEEEEEEEE');
          throw Exception(responseData['error']['message']);
        }
        _token = responseData['id_token'];
        _refreshToken =
            responseData['refresh_token']; // Also save your refresh token
        print('RRRRRRRRRRRRRRRRRRRRRRRR$_refreshToken');
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
      } catch (error) {
        throw error;
      }
    });
  }
}
