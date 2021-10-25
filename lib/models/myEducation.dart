class MyEducation {
  String educationLevel;
  String universityId;
  String professionId;
  String jobTitle;
  String company;

  MyEducation({
    required this.company,
    required this.educationLevel,
    required this.jobTitle,
    required this.professionId,
    required this.universityId,
  });

  factory MyEducation.fromJson(Map<String, dynamic> parsedJson) {
    return MyEducation(
        company: parsedJson['company'],
        educationLevel: parsedJson['educationLevel'],
        jobTitle: parsedJson['jobTitle'],
        professionId: parsedJson['professionId'],
        universityId: parsedJson['universityId']);
  }

  
}
