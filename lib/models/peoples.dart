
class Peoples {
  String userName;
  String fullName;
  String gender;
  String email;
  double height;
  String birthDay;
  String nationality;
  String headline;
  double longitude;
  double latitude;

  Peoples(
      {required this.userName,
      required this.fullName,
      required this.gender,
      required this.email,
      required this.height,
      required this.birthDay,
      required this.nationality,
      required this.headline,
      required this.longitude,
      required this.latitude});

  factory Peoples.fromJson(Map<String, dynamic> parsedJson) {
    return new Peoples(
        userName: parsedJson['userName'],
        fullName: parsedJson['fullName'],
        gender: parsedJson['gender'],
        email: parsedJson['email'],
        height: parsedJson['height'],
        birthDay: parsedJson['birthDay'],
        nationality: parsedJson['nationality'],
        headline: parsedJson['headline'],
        longitude: parsedJson['longtiude'],
        latitude: parsedJson['latitude']);
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
