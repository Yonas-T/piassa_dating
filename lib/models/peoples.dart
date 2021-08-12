import 'dart:io';

class Peoples {
  String name;
  String id;
  String profilePictureURL;
  String time;
  String lastMessage;

  Peoples(
      {
      required this.name,
      required this.id,
      required this.time,
      required this.profilePictureURL,
      required this.lastMessage});

  factory Peoples.fromJson(Map<String, dynamic> parsedJson) {
    return new Peoples(
        name: parsedJson['name'],
        time: parsedJson['time'],
        lastMessage: parsedJson['lastMessage'],
        id: parsedJson['id'] ?? parsedJson['userID'],
        profilePictureURL: parsedJson['profilePictureURL']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'id': this.id,
      'time': this.time,
      'lastMessage': this.lastMessage,
      'profilePictureURL': this.profilePictureURL,
    };
  }
}
