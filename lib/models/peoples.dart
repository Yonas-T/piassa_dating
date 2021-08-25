import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Peoples {
  String name;
  String id;
  String profilePictureURL;
  String time;
  String gender;
  GeoPoint location;
  String lastMessage;

  Peoples(
      {required this.name,
      required this.id,
      required this.gender,
      required this.location,
      required this.time,
      required this.profilePictureURL,
      required this.lastMessage});

  factory Peoples.fromJson(Map<String, dynamic> parsedJson) {
    return new Peoples(
        name: parsedJson['name'],
        gender: parsedJson['gender'],
        location: parsedJson['location'],
        time: parsedJson['time'],
        lastMessage: parsedJson['lastMessage'],
        id: parsedJson['id'] ?? parsedJson['userID'],
        profilePictureURL: parsedJson['profilePictureURL']);
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': this.name,
  //     'id': this.id,
  //     'time': this.time,
  //     'lastMessage': this.lastMessage,
  //     'profilePictureURL': this.profilePictureURL,
  //   };
  // }
}
