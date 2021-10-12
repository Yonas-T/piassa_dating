class Profession {
  String id;
  String englishValue;
  String amharicValue;
  String oromifaValue;
  String tigrinyaValue;

  Profession(
      {required this.id,
      required this.englishValue,
      required this.amharicValue,
      required this.oromifaValue,
      required this.tigrinyaValue});

  factory Profession.fromJson(Map<String, dynamic> json) {
    return Profession(
        id: json['id'],
        englishValue: json['englishValue'],
        amharicValue: json['amharicValue'],
        oromifaValue: json['oromifaValue'],
        tigrinyaValue: json['tigrinyaValue']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['englishValue'] = this.englishValue;
    data['amharicValue'] = this.amharicValue;
    data['oromifaValue'] = this.oromifaValue;
    data['tigrinyaValue'] = this.tigrinyaValue;
    return data;
  }
}
