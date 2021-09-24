

class Images {
  String filePath;
  String fileType;


  Images(
      {
      required this.filePath,
      required this.fileType});

  factory Images.fromJson(Map<String, dynamic> parsedJson) {
    return new Images(
        filePath: parsedJson['filePath'],
        fileType: parsedJson['fileType']);
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
