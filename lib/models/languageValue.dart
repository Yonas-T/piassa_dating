class LanguageValue {
  String id;
  String englishValue;
  String amharicValue;
  String oromifaValue;
  String tigrinyaValue;

  LanguageValue(
      {required this.id,
      required this.englishValue,
      required this.amharicValue,
      required this.oromifaValue,
      required this.tigrinyaValue});

  factory LanguageValue.fromJson(Map<String, dynamic> json) => LanguageValue(
        id: json["id"],
        englishValue: json["englishValue"],
        tigrinyaValue: json["tigrinyaValue"],
        oromifaValue: json["oromifaValue"],
        amharicValue: json["amharicValue"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["englishValue"] = this.englishValue;
    data["tigrinyaValue"] = this.tigrinyaValue;
    data["oromifaValue"] = this.oromifaValue;
    data["amharicValue"] = this.amharicValue;
    return data;
  }
}
