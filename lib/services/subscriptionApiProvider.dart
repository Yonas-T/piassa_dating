import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/subscription.dart';
import 'package:piassa_application/models/userMatch.dart';

class SubscriptionApiProvider {
  final _baseUrl = 'https://api.piassadating.com';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<Subscription>> fetchSubscriptions() async {
    // var vv;
    String tok = await auth.currentUser!.getIdToken(true);
    print('TOKEN: $tok');

    final response = await http.get(
      Uri.parse('$_baseUrl/api/subscription-packages'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'X-Authorization-Firebase': '$tok'
      },
    );
    print('Subscription Fetched: ${jsonDecode(response.body).runtimeType}');
    print(response.statusCode);

    if (response.statusCode == 200) {
      List<Subscription> subscriptions = [];
      List<Map<String, dynamic>> subJson = [];
      if (response.body.isNotEmpty) {
        // Iterable l = json.decode(response.body);

        subJson = (json.decode(response.body) as List)
            .map((i) => i as Map<String, dynamic>)
            .toList();
        print(subJson.runtimeType);
        subJson.forEach((element) {
          subscriptions.add(Subscription.fromJson(element));
        });

        // subscriptions = List<Subscription>.from(
        //     l.map((model) => Subscription.fromJson(model)));
        // print('SUBBBB: ' + subscriptions.toString());
        // log(json.decode(response.body).toString());
      }
      print(subscriptions);
      return subscriptions;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Subscription> postSubscriptionSelected(
      Subscription subscriptionData) async {
        
    Map<String, dynamic> postJson = {
      "id": subscriptionData.id,
      "name": subscriptionData.name,
      "description": subscriptionData.description,
      "noDailyProfileSwipes": subscriptionData.noDailyProfileSwipes,
      "period": subscriptionData.period,
      "price": subscriptionData.price,
      "point": subscriptionData.point,
      "subscriptionPackageType": subscriptionData.subscriptionPackageType,
      "likedUsersListing": subscriptionData.likedUsersListing,
      "genderVisible": subscriptionData.genderVisible,
      "ageVisible": subscriptionData.ageVisible,
      "religionVisible": subscriptionData.religionVisible,
      "educationLevelVisible": subscriptionData.educationLevelVisible,
      "searchRadiusVisible": subscriptionData.searchRadiusVisible
    };

    print(postJson);
    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/subscription-packages'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'X-Authorization-Firebase': '$value'
        },
        body: json.encode(postJson),
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Subscription.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }

  Future<Subscription> editSubscription(Subscription subscription) async {
    Map<String, dynamic> postJson = {
      "id": subscription.id,
      "name": subscription.name,
      "description": subscription.description,
      "noDailyProfileSwipes": subscription.noDailyProfileSwipes,
      "period": subscription.period,
      "price": subscription.price,
      "point": subscription.point,
      "subscriptionPackageType": subscription.subscriptionPackageType,
      "likedUsersListing": subscription.likedUsersListing,
      "genderVisible": subscription.genderVisible,
      "ageVisible": subscription.ageVisible,
      "religionVisible": subscription.religionVisible,
      "educationLevelVisible": subscription.educationLevelVisible,
      "searchRadiusVisible": subscription.searchRadiusVisible
    };

    var cc = auth.currentUser!.getIdToken(true).then((value) async {
      final response = await http.put(
        Uri.parse('$_baseUrl/api/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(
          {postJson},
        ),
      );

      if (response.statusCode == 200) {
        return Subscription.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    });
    return cc;
  }
}
