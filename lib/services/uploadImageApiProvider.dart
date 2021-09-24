import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' show Client;
import 'package:piassa_application/models/peoples.dart';
import 'package:path/path.dart' as Path; 

class UploadImageApiProvider {
  Client client = Client();
  final _baseUrl = 'https://api.piassadating.com';
  late File _image;    
  late String uploadedFileURL; 
  // Future uploadFile() async {    
  //  StorageReference storageReference = FirebaseStorage.instance    
  //      .ref()    
  //      .child('uploads/${Path.basename(_image.path)}}');    
  //  StorageUploadTask uploadTask = storageReference.putFile(_image);    
  //  await uploadTask.onComplete;    
  //  print('File Uploaded');    
  //  storageReference.getDownloadURL().then((fileURL) {    
   
  //      _uploadedFileURL = fileURL;    
    
  //  });    
  // } 

  Future<Peoples> uploadImageLink(uploadedFileURL ,fileType) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/api/upload-files'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(
        {
          "filePath": uploadedFileURL,
	        "fileType": fileType
        },
      ),
    );

    if (response.statusCode == 200) {
      return Peoples.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  // Future<String> passRecommendedUsers() async {
  //   final response = await client.post(Uri.parse('$_baseUrl/'));

  // }
}
