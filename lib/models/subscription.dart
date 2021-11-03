class Subscription {
  String id;
  String name;
  String description;
  int noDailyProfileSwipes;
  int period;
  double price;
  int point;
  String subscriptionPackageType;
  bool likedUsersListing;
  bool genderVisible;
  bool ageVisible;
  bool religionVisible;
  bool educationLevelVisible;
  bool searchRadiusVisible;

  Subscription(
      {required this.id,
      required this.name,
      required this.description,
      required this.noDailyProfileSwipes,
      required this.likedUsersListing,
      required this.genderVisible,
      required this.ageVisible,
      required this.religionVisible,
      required this.educationLevelVisible,
      required this.searchRadiusVisible,
      required this.period,
      required this.price,
      required this.point,
      required this.subscriptionPackageType});

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        noDailyProfileSwipes: json['noDailyProfileSwipes'],
        period: json['period'],
        price: json['price'],
        point: json['point'],
        subscriptionPackageType: json['subscriptionPackageType'],
        likedUsersListing: json['likedUsersListing'],
        genderVisible: json['genderVisible'],
        ageVisible: json['ageVisible'],
        religionVisible: json['religionVisible'],
        educationLevelVisible: json['educationLevelVisible'],
        searchRadiusVisible: json['searchRadiusVisible']);
  }
}
