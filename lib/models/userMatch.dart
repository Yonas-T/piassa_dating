import 'package:piassa_application/models/education.dart';
import 'package:piassa_application/models/lifeStyle.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/models/userImage.dart';
import 'package:piassa_application/models/userMoveMaker.dart';

class UserMatch {
  String id;
  String userName;
  String email;
  String fullName;
  String gender;
  double height;
  String birthDay;
  String nationality;
  String headline;
  double latitude;
  double longitude;
  LifeStyle? lifeStyle;
  Education? education;
  List<UserMoveMaker> userMoveMakers;
  Preference? matchPreference;
  List<UserImage> userImages;
  String currentSubscriptionPackage;
  String paymentHistories;
  bool haveLifeStyle;
  bool haveEducaion;
  bool haveMoveMakers;
  bool haveMatchPreference;
  String matchedDate;
  String likedDate;
  String userStatus;

  UserMatch(
      {required this.id,
      required this.userName,
      required this.email,
      required this.fullName,
      required this.gender,
      required this.height,
      required this.birthDay,
      required this.nationality,
      required this.headline,
      required this.latitude,
      required this.longitude,
      required this.lifeStyle,
      required this.education,
      required this.userMoveMakers,
      required this.matchPreference,
      required this.userImages,
      required this.currentSubscriptionPackage,
      required this.paymentHistories,
      required this.haveLifeStyle,
      required this.haveEducaion,
      required this.haveMoveMakers,
      required this.haveMatchPreference,
      required this.matchedDate,
      required this.likedDate,
      required this.userStatus});

  factory UserMatch.fromJson(Map<String, dynamic> json) {
    final movesList = (json['userMoveMakers'] != null ? json['userMoveMakers'] as List : null);
   List<UserMoveMaker> movemk =
       (movesList != null ? movesList.map((i) => UserMoveMaker.fromJson(i)).toList(): []);
    final imagesList = (json['userImages'] != null ? json['userImages'] as List: null);
   List<UserImage> imgmk =
       (imagesList != null ? imagesList.map((i) => UserImage.fromJson(i)).toList(): []);
    
    return UserMatch(
        id: json['id'],
        userName: json['userName'],
        email: json['email'],
        fullName: json['fullName'],
        gender: json['gender'],
        height: json['height'],
        birthDay: json['birthDay'],
        nationality: json['nationality'],
        headline: json['headline'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        lifeStyle: (json['lifeStyle'] != null
            ? new LifeStyle.fromJson(json['lifeStyle'])
            : null),
        education: (json['education'] != null
            ? new Education.fromJson(json['education'])
            : null),
        userMoveMakers: movemk,
        matchPreference: (json['matchPreference'] != null ? Preference.fromJson(json['matchPreference']) : null),
        userImages: imgmk,
        currentSubscriptionPackage: json['currentSubscriptionPackage'],
        paymentHistories: json['paymentHistories'],
        haveLifeStyle: json['haveLifeStyle'],
        haveEducaion: json['haveEducaion'],
        haveMoveMakers: json['haveMoveMakers'],
        haveMatchPreference: json['haveMatchPreference'],
        matchedDate: json['matchedDate'],
        likedDate: json['likedDate'],
        userStatus: json['userStatus']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['height'] = this.height;
    data['birthDay'] = this.birthDay;
    data['nationality'] = this.nationality;
    data['headline'] = this.headline;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['lifeStyle'] = this.lifeStyle!.toJson();
    data['education'] = this.education!.toJson();
    data['userMoveMakers'] =
        this.userMoveMakers.map((v) => v.toJson()).toList();
    data['matchPreference'] = this.matchPreference!.toJson();
    data['userImages'] = this.userImages.map((v) => v.toJson()).toList();
    data['currentSubscriptionPackage'] = this.currentSubscriptionPackage;
    data['paymentHistories'] = this.paymentHistories;
    data['haveLifeStyle'] = this.haveLifeStyle;
    data['haveEducaion'] = this.haveEducaion;
    data['haveMoveMakers'] = this.haveMoveMakers;
    data['haveMatchPreference'] = this.haveMatchPreference;
    data['matchedDate'] = this.matchedDate;
    data['likedDate'] = this.likedDate;
    data['userStatus'] = this.userStatus;
    return data;
  }
}