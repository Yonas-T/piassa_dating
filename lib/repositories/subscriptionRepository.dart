import 'package:piassa_application/models/subscription.dart';
import 'package:piassa_application/services/SubscriptionApiProvider.dart';

class SubscriptionRepository {
  SubscriptionApiProvider subscriptionApiProvider = SubscriptionApiProvider();

  Future<List<Subscription>> fetchSubscription() =>
      subscriptionApiProvider.fetchSubscriptions();

  Future<Subscription> editSubscription(subscription) =>
      subscriptionApiProvider.editSubscription(subscription);

  Future<Subscription> postSubscriptionSelected(subscription) =>
      subscriptionApiProvider.postSubscriptionSelected(subscription);
}
