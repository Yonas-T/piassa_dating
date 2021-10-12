import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:piassa_application/models/images.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:path/path.dart' as Path;

class UploadImageApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;

  List<String> _uploadedFileURL = [];
  Future<Images> uploadFile(images) async {
    // images.forEach((key, value) async {
    //   firebase_storage.Reference storageReference = firebase_storage
    //       .FirebaseStorage.instance
    //       .ref()
    //       .child('uploads/${Path.basename(value.path)}}');
    //   firebase_storage.UploadTask uploadTask =
    //       storageReference.putFile(File(value.path));
    //   await uploadTask.whenComplete(() async {
    //     await storageReference.getDownloadURL().then((val) {
    //       _uploadedFileURL.add(val);
    //       uploadImageLink({key: val});
    //       // imgRef.add({'url': value});
    //       // i++;
    //     });
    //     print(_uploadedFileURL);
    //   });
    // });
    for (XFile img in images) {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('uploads/${Path.basename(img.path)}}');
      firebase_storage.UploadTask uploadTask =
          storageReference.putFile(File(img.path));
      await uploadTask.whenComplete(() async {
        await storageReference.getDownloadURL().then((value) {
          _uploadedFileURL.add(value);
          // imgRef.add({'url': value});
          // i++;
        });
        // print(_uploadedFileURL);
      });
      print(_uploadedFileURL);
    }
    List ftype = ["PROFILE", "GALLERY", "GALLERY", "GALLERY", "GALLERY"];
    var cc;
    for (var i = 0; i < _uploadedFileURL.length; i++) {
      cc = auth.currentUser!.getIdToken(true).then((value) async {
        final response = await http.post(
          Uri.parse('$_baseUrl/api/upload-files'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'X-Authorization-Firebase': '$value'
          },
          body: json.encode(
            {"filePath": _uploadedFileURL[i], "fileType": ftype[i]},
          ),
        );
        print('RESPONSE BODY: ${response.body}');

        if (response.statusCode == 200) {
          return Images.fromJson(
            {
              "filePath": _uploadedFileURL[i], "fileType": ftype[i]
            }
            // json.decode(response.body)
            );
        } else {
          throw Exception('Failed to load');
        }
      });
    }
    return cc;
  }

  Future<Peoples> uploadImageLink(uploadedFile) async {
    // uploadedFile.forEach((key, value) async{
    //   response = await client.post(
    //     Uri.parse('$_baseUrl/api/upload-files'),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8'
    //     },
    //     body: json.encode(
    //       {"filePath": value, "fileType": key},
    //     ),
    //   );
    // });
    // if (response.statusCode == 200) {
    //     return Peoples.fromJson(json.decode(response.body));
    //   } else {
    //     throw Exception('Failed to load');
    //   }
    List ftype = ["GALLERY", "PROFILE", "GALLERY", "GALLERY", "GALLERY"];
    var cc;
    for (var i = 0; i < uploadedFile.length; i++) {
      cc = auth.currentUser!.getIdToken(true).then((value) async {
        final response = await http.post(
          Uri.parse('$_baseUrl/api/upload-files'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'X-Authorization-Firebase': '$value'
          },
          body: json.encode(
            {"filePath": uploadedFile[i], "fileType": ftype[i]},
          ),
        );

        if (response.statusCode == 200) {
          return Peoples.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load');
        }
      });
    }
    return cc;
  }
}
