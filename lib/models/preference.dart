class Preference {
  String id;
  String gender;
  int ageStart;
  int ageEnd;
  String religion;
  String educationLevel;
  double searchRadius;

  Preference(
      {required this.id,
      required this.gender,
      required this.ageStart,
      required this.ageEnd,
      required this.religion,
      required this.educationLevel,
      required this.searchRadius});

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
        id: json['id'],
        gender: json['gender'],
        ageStart: json['ageStart'],
        ageEnd: json['ageEnd'],
        religion: json['religion'],
        educationLevel: json['educationLevel'],
        searchRadius: json['searchRadius']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['ageStart'] = this.ageStart;
    data['ageEnd'] = this.ageEnd;
    data['religion'] = this.religion;
    data['educationLevel'] = this.educationLevel;
    data['searchRadius'] = this.searchRadius;
    return data;
  }
}