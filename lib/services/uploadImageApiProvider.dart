import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' show Client;
import 'package:piassa_application/models/peoples.dart';
import 'package:path/path.dart' as Path;

class UploadImageApiProvider {
  Client client = Client();
  final _baseUrl = 'https://api.piassadating.com';
  late File _image;

  List<String> _uploadedFileURL = [];
  Future uploadFile(images) async {
    for (var img in images) {
      firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('uploads/${Path.basename(img.path)}}');
    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() async {
      await storageReference.getDownloadURL().then((value) {
        _uploadedFileURL.add(value);
        // imgRef.add({'url': value});
        // i++;
      });
    });
    }
    
    print('File Uploaded');
  }

  Future<Peoples> uploadImageLink(uploadedFileURL, fileType) async {
    var response;
    for (var i = 0; i < _uploadedFileURL.length; i++) {
      response = await client.post(
        Uri.parse('$_baseUrl/api/upload-files'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(
          {"filePath": _uploadedFileURL[i], "fileType": fileType},
        ),
      );

      if (response.statusCode == 200) {
        return Peoples.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    }
    return response;
  }

  // Future<String> passRecommendedUsers() async {
  //   final response = await client.post(Uri.parse('$_baseUrl/'));

  // }
}
