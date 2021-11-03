import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:geocoding/geocoding.dart';

class SearchApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;
  var _currentAddress;
  Position? _currentPosition;

  // _getCurrentLocation() {
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     _currentPosition = position;
  //     _getAddressFromLatLng(
  //         _currentPosition!.latitude, _currentPosition!.longitude);
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  _getAddressFromLatLng(lat, lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      print('placemark: $placemarks');

      Placemark place = placemarks[0];

      _currentAddress = "${place.locality}";
      print('City address: $_currentAddress');
    } catch (e) {
      print(e);
    }
  }

  Future<List<UserMatch>> fetchPeoplesToSearchFor() async {
    var pos;
    // Future getPosition() async {
    //   await Geolocator.getCurrentPosition().then((value) {
    //     pos = value;
    //   });
    // }

    // Future<void> getAddressFromLatLong() async {
    //   List<Placemark> placemarks =
    //       await placemarkFromCoordinates(pos.latitude, pos.longitude, localeIdentifier: 'en_US');
    //   print('PLACEMARK: ${placemarks[0]}');
    //   Placemark place = placemarks[0];
    //   // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    //   print('CITY: ${place.administrativeArea}');
    // }

    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      // log('tokennnnnn: $value');
      final response = await http.get(
        Uri.parse('$_baseUrl/api/user-daily-recommendations'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
      );
      print(response.body.toString());
      log(response.statusCode.toString());
      // getPosition().then((value) async{
      List<Placemark> placemarks = await placemarkFromCoordinates(
          40.730610, -73.935242,
          localeIdentifier: 'en_US');
      print('PLACEMARK: ${placemarks[0]}');
      Placemark place = placemarks[0];
      // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      print('CITY: ${place.administrativeArea}');
      // });

      if (response.statusCode == 200) {
        List<UserMatch> matchRecommendations = [];
        if (response.body.isNotEmpty) {
          Iterable l = json.decode(response.body);
          matchRecommendations =
              List<UserMatch>.from(l.map((model) => UserMatch.fromJson(model)));
          print(l);
          // log(json.decode(response.body).toString());
          print(matchRecommendations[0].longitude);
          print('Match Recomm: ${json.encode(matchRecommendations)}');
        }

        // _getAddressFromLatLng(40.712776, -74.005974);
        // _getCurrentLocation();

        return matchRecommendations;
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<String> choosePeople(recommendedId) async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.post(
        Uri.parse(
            '$_baseUrl/api/user-daily-recommendations/$recommendedId/like'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: json.encode(
          {},
        ),
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return 'response.body';
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<String> passRecommendedUsers(recommendedId) async {
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.post(
        Uri.parse(
            '$_baseUrl/api/user-daily-recommendations/$recommendedId/pass'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: json.encode(
          {},
        ),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return 'response.body';
        // json.decode(response.body)
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }
}
