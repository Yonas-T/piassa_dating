
class Preference {
  int ageStart;
  int ageEnd;
  String religion;
  String educationLevel;
  double searchRadius;


  Preference(
      {required this.ageStart,
      required this.ageEnd,
      required this.religion,
      required this.educationLevel,
      required this.searchRadius});

  factory Preference.fromJson(Map<String, dynamic> parsedJson) {
    return new Preference(
        ageStart: parsedJson['ageStart'],
        ageEnd: parsedJson['ageEnd'],
        religion: parsedJson['religion'],
        educationLevel: parsedJson['educationLevel'],
        searchRadius: parsedJson['searchRadius']);
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
