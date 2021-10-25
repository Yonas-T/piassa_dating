
class UserMoveMaker {
  String id;
  String moveMakerId;
  String answer;
  MoveMaker moveMaker;

  UserMoveMaker(
      {required this.id,
      required this.moveMakerId,
      required this.answer,
      required this.moveMaker});

  factory UserMoveMaker.fromJson(Map<String, dynamic> json) {
    return UserMoveMaker(
      id: json['id'],
      moveMakerId: json['moveMakerId'],
      answer: json['answer'],
      moveMaker: MoveMaker.fromJson(json['moveMaker']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['moveMakerId'] = this.moveMakerId;
    data['answer'] = this.answer;
    data['moveMaker'] = this.moveMaker.toJson();
    return data;
  }
}

class MoveMaker {
  String id;
  String question;

  MoveMaker({required this.id, required this.question});

  factory MoveMaker.fromJson(Map<String, dynamic> json) {
    return MoveMaker(id: json['id'], question: json['question']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    return data;
  }
}

class PostMoveMaker {
  String moveMakerId;
  String answer;

  PostMoveMaker({required this.moveMakerId, required this.answer});

  factory PostMoveMaker.fromJson(Map<String, dynamic> json) {
    return PostMoveMaker(moveMakerId: json['moveMakerId'], answer: json['answer']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moveMakerId'] = this.moveMakerId;
    data['answer'] = this.answer;
    return data;
  }
}