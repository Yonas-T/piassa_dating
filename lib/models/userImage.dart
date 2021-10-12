class UserImage {
  String id;
  String filePath;
  String fileType;
  String verificationStatus;

  UserImage(
      {required this.id,
      required this.filePath,
      required this.fileType,
      required this.verificationStatus});

  factory UserImage.fromJson(Map<String, dynamic> json) {
    return UserImage(
        id: json['id'],
        filePath: json['filePath'],
        fileType: json['fileType'],
        verificationStatus: json['verificationStatus']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filePath'] = this.filePath;
    data['fileType'] = this.fileType;
    data['verificationStatus'] = this.verificationStatus;
    return data;
  }
}