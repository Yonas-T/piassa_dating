// class UserMatch {
//   String id;
//   String userName;
//   String email;
//   String fullName;
//   String gender;
//   int height;
//   String birthDay;
//   String nationality;
//   String headline;
//   Null latitude;
//   Null longitude;
//   LifeStyle lifeStyle;
//   Education education;
//   List<UserMoveMakers> userMoveMakers;
//   MatchPreference matchPreference;
//   List<UserImages> userImages;
//   Null currentSubscriptionPackage;
//   Null paymentHistories;
//   bool haveLifeStyle;
//   bool haveEducaion;
//   bool haveMoveMakers;
//   bool haveMatchPreference;
//   Null matchedDate;
//   Null likedDate;
//   String userStatus;

//   UserMatch(
//       {required this.id,
//       required this.userName,
//       required this.email,
//       required this.fullName,
//       required this.gender,
//       required this.height,
//       required this.birthDay,
//       required this.nationality,
//       required this.headline,
//       required this.latitude,
//       required this.longitude,
//       required this.lifeStyle,
//       required this.education,
//       required this.userMoveMakers,
//       required this.matchPreference,
//       required this.userImages,
//       required this.currentSubscriptionPackage,
//       required this.paymentHistories,
//       required this.haveLifeStyle,
//       required this.haveEducaion,
//       required this.haveMoveMakers,
//       required this.haveMatchPreference,
//       required this.matchedDate,
//       required this.likedDate,
//       required this.userStatus});

//   factory UserMatch.fromJson(Map<String, dynamic> json) {
//     return UserMatch(
//         id: json['id'],
//         userName: json['userName'],
//         email: json['email'],
//         fullName: json['fullName'],
//         gender: json['gender'],
//         height: json['height'],
//         birthDay: json['birthDay'],
//         nationality: json['nationality'],
//         headline: json['headline'],
//         latitude: json['latitude'],
//         longitude: json['longitude'],
//         lifeStyle: (json['lifeStyle'] != null
//             ? new LifeStyle.fromJson(json['lifeStyle'])
//             : null)!,
//         education: (json['education'] != null
//             ? new Education.fromJson(json['education'])
//             : null)!,
//         userMoveMakers: json['userMoveMakers'],
//         //  != null
//         //     ? UserMoveMakers.fromJson(json['userMoveMakers']): null

//         // if (json['userMoveMakers'] != null) {
//         //   List<UserMoveMakers> userMoveMakers = [];
//         //   json['userMoveMakers'].forEach((v) {
//         //     userMoveMakers.add(new UserMoveMakers.fromJson(v));
//         //   });
//         // },
//         matchPreference: json['matchPreference'],
//         // != null
//         //     ? new MatchPreference.fromJson(json['matchPreference'])
//         //     : null;
//         userImages: json['userImages'],
//         // if (json['userImages'] != null) {
//         //   List<UserImages> userImages = [];
//         //   json['userImages'].forEach((v) {
//         //     userImages.add(new UserImages.fromJson(v));
//         //   });
//         // }
//         currentSubscriptionPackage: json['currentSubscriptionPackage'],
//         paymentHistories: json['paymentHistories'],
//         haveLifeStyle: json['haveLifeStyle'],
//         haveEducaion: json['haveEducaion'],
//         haveMoveMakers: json['haveMoveMakers'],
//         haveMatchPreference: json['haveMatchPreference'],
//         matchedDate: json['matchedDate'],
//         likedDate: json['likedDate'],
//         userStatus: json['userStatus']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['userName'] = this.userName;
//     data['email'] = this.email;
//     data['fullName'] = this.fullName;
//     data['gender'] = this.gender;
//     data['height'] = this.height;
//     data['birthDay'] = this.birthDay;
//     data['nationality'] = this.nationality;
//     data['headline'] = this.headline;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['lifeStyle'] = this.lifeStyle.toJson();
//     data['education'] = this.education.toJson();
//     data['userMoveMakers'] =
//         this.userMoveMakers.map((v) => v.toJson()).toList();
//     data['matchPreference'] = this.matchPreference.toJson();
//     data['userImages'] = this.userImages.map((v) => v.toJson()).toList();
//     data['currentSubscriptionPackage'] = this.currentSubscriptionPackage;
//     data['paymentHistories'] = this.paymentHistories;
//     data['haveLifeStyle'] = this.haveLifeStyle;
//     data['haveEducaion'] = this.haveEducaion;
//     data['haveMoveMakers'] = this.haveMoveMakers;
//     data['haveMatchPreference'] = this.haveMatchPreference;
//     data['matchedDate'] = this.matchedDate;
//     data['likedDate'] = this.likedDate;
//     data['userStatus'] = this.userStatus;
//     return data;
//   }
// }

// class LifeStyle {
//   String id;
//   int smooking;
//   int drinking;
//   int kids;
//   int religion;
//   int physicalExercise;
//   int relationshipStatus;

//   LifeStyle(
//       {required this.id,
//       required this.smooking,
//       required this.drinking,
//       required this.kids,
//       required this.religion,
//       required this.physicalExercise,
//       required this.relationshipStatus});

//   factory LifeStyle.fromJson(Map<String, dynamic> json) {
//     return LifeStyle(
//         id: json['id'],
//         smooking: json['smooking'],
//         drinking: json['drinking'],
//         kids: json['kids'],
//         religion: json['religion'],
//         physicalExercise: json['physicalExercise'],
//         relationshipStatus: json['relationshipStatus']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['smooking'] = this.smooking;
//     data['drinking'] = this.drinking;
//     data['kids'] = this.kids;
//     data['religion'] = this.religion;
//     data['physicalExercise'] = this.physicalExercise;
//     data['relationshipStatus'] = this.relationshipStatus;
//     return data;
//   }
// }

// class Education {
//   String id;
//   String educationLevel;
//   String jobTitle;
//   String company;
//   String professionId;
//   String universityId;
//   String userId;
//   Profession profession;
//   Profession university;

//   Education(
//       {required this.id,
//       required this.educationLevel,
//       required this.jobTitle,
//       required this.company,
//       required this.professionId,
//       required this.universityId,
//       required this.userId,
//       required this.profession,
//       required this.university});

//   factory Education.fromJson(Map<String, dynamic> json) {
//     return Education(
//       id: json['id'],
//       educationLevel: json['educationLevel'],
//       jobTitle: json['jobTitle'],
//       company: json['company'],
//       professionId: json['professionId'],
//       universityId: json['universityId'],
//       userId: json['userId'],
//       profession: json['profession'],
//       //  != null
//       //     ? new Profession.fromJson(json['profession'])
//       //     : null,
//       university: json['university'],
//       // != null
//       //     ? new Profession.fromJson(json['university'])
//       //     : null
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['educationLevel'] = this.educationLevel;
//     data['jobTitle'] = this.jobTitle;
//     data['company'] = this.company;
//     data['professionId'] = this.professionId;
//     data['universityId'] = this.universityId;
//     data['userId'] = this.userId;
//     if (this.profession != null) {
//       data['profession'] = this.profession.toJson();
//     }
//     if (this.university != null) {
//       data['university'] = this.university.toJson();
//     }
//     return data;
//   }
// }

// class Profession {
//   String id;
//   String englishValue;
//   String amharicValue;
//   String oromifaValue;
//   String tigrinyaValue;

//   Profession(
//       {required this.id,
//       required this.englishValue,
//       required this.amharicValue,
//       required this.oromifaValue,
//       required this.tigrinyaValue});

//   factory Profession.fromJson(Map<String, dynamic> json) {
//     return Profession(
//         id: json['id'],
//         englishValue: json['englishValue'],
//         amharicValue: json['amharicValue'],
//         oromifaValue: json['oromifaValue'],
//         tigrinyaValue: json['tigrinyaValue']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['englishValue'] = this.englishValue;
//     data['amharicValue'] = this.amharicValue;
//     data['oromifaValue'] = this.oromifaValue;
//     data['tigrinyaValue'] = this.tigrinyaValue;
//     return data;
//   }
// }

// class UserMoveMakers {
//   String id;
//   String moveMakerId;
//   String answer;
//   MoveMaker moveMaker;

//   UserMoveMakers(
//       {required this.id,
//       required this.moveMakerId,
//       required this.answer,
//       required this.moveMaker});

//   factory UserMoveMakers.fromJson(Map<String, dynamic> json) {
//     return UserMoveMakers(
//       id: json['id'],
//       moveMakerId: json['moveMakerId'],
//       answer: json['answer'],
//       moveMaker: json['moveMaker'],
//       //  != null
//       //     ? new MoveMaker.fromJson(json['moveMaker'])
//       //     : null
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['moveMakerId'] = this.moveMakerId;
//     data['answer'] = this.answer;
//     data['moveMaker'] = this.moveMaker.toJson();
//     return data;
//   }
// }

// class MoveMaker {
//   String id;
//   String question;

//   MoveMaker({required this.id, required this.question});

//   factory MoveMaker.fromJson(Map<String, dynamic> json) {
//     return MoveMaker(id: json['id'], question: json['question']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['question'] = this.question;
//     return data;
//   }
// }

// class MatchPreference {
//   String id;
//   String gender;
//   int ageStart;
//   int ageEnd;
//   String religion;
//   String educationLevel;
//   int searchRadius;

//   MatchPreference(
//       {required this.id,
//       required this.gender,
//       required this.ageStart,
//       required this.ageEnd,
//       required this.religion,
//       required this.educationLevel,
//       required this.searchRadius});

//   factory MatchPreference.fromJson(Map<String, dynamic> json) {
//     return MatchPreference(
//         id: json['id'],
//         gender: json['gender'],
//         ageStart: json['ageStart'],
//         ageEnd: json['ageEnd'],
//         religion: json['religion'],
//         educationLevel: json['educationLevel'],
//         searchRadius: json['searchRadius']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['gender'] = this.gender;
//     data['ageStart'] = this.ageStart;
//     data['ageEnd'] = this.ageEnd;
//     data['religion'] = this.religion;
//     data['educationLevel'] = this.educationLevel;
//     data['searchRadius'] = this.searchRadius;
//     return data;
//   }
// }

// class UserImages {
//   String id;
//   String filePath;
//   String fileType;
//   String verificationStatus;

//   UserImages(
//       {required this.id,
//       required this.filePath,
//       required this.fileType,
//       required this.verificationStatus});

//   factory UserImages.fromJson(Map<String, dynamic> json) {
//     return UserImages(
//         id: json['id'],
//         filePath: json['filePath'],
//         fileType: json['fileType'],
//         verificationStatus: json['verificationStatus']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['filePath'] = this.filePath;
//     data['fileType'] = this.fileType;
//     data['verificationStatus'] = this.verificationStatus;
//     return data;
//   }
// }
