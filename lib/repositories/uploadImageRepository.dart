import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/services/uploadImageApiProvider.dart';

class UploadImageRepository {
  UploadImageApiProvider uploadImageProvider = UploadImageApiProvider();

  Future<Peoples> uploadImageLink(uploadedFileURL, fileType) =>
      uploadImageProvider.uploadImageLink(uploadedFileURL, fileType);

  // Future<Peoples> choosePeople() async {
  //   searchApiProvider.choosePeople();
  // }
}
