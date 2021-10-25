class LifeStyle {
  String? id;
  int smooking;
  int drinking;
  int kids;
  int religion;
  int physicalExercise;
  int relationshipStatus;

  LifeStyle(
      {this.id,
      required this.smooking,
      required this.drinking,
      required this.kids,
      required this.religion,
      required this.physicalExercise,
      required this.relationshipStatus});

  factory LifeStyle.fromJson(Map<String, dynamic> json) {
    return LifeStyle(
        id: json['id'],
        smooking: json['smooking'],
        drinking: json['drinking'],
        kids: json['kids'],
        religion: json['religion'],
        physicalExercise: json['physicalExercise'],
        relationshipStatus: json['relationshipStatus']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['smooking'] = this.smooking;
    data['drinking'] = this.drinking;
    data['kids'] = this.kids;
    data['religion'] = this.religion;
    data['physicalExercise'] = this.physicalExercise;
    data['relationshipStatus'] = this.relationshipStatus;
    return data;
  }
}