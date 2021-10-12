import 'package:piassa_application/models/profession.dart';

class Education {
  String id;
  String educationLevel;
  String jobTitle;
  String company;
  String professionId;
  String universityId;
  String userId;
  Profession profession;
  Profession university;

  Education(
      {required this.id,
      required this.educationLevel,
      required this.jobTitle,
      required this.company,
      required this.professionId,
      required this.universityId,
      required this.userId,
      required this.profession,
      required this.university});

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'],
      educationLevel: json['educationLevel'],
      jobTitle: json['jobTitle'],
      company: json['company'],
      professionId: json['professionId'],
      universityId: json['universityId'],
      userId: json['userId'],
      profession: Profession.fromJson(json['profession']),
      //  != null
      //     ? new Profession.fromJson(json['profession'])
      //     : null,
      university: Profession.fromJson(json['university']),
      // != null
      //     ? new Profession.fromJson(json['university'])
      //     : null
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['educationLevel'] = this.educationLevel;
    data['jobTitle'] = this.jobTitle;
    data['company'] = this.company;
    data['professionId'] = this.professionId;
    data['universityId'] = this.universityId;
    data['userId'] = this.userId;
    data['profession'] = this.profession.toJson();
    data['university'] = this.university.toJson();
    return data;
  }
}
