import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piassa_application/models/subscription.dart';

abstract class SubscriptionEvent extends Equatable {}

class SubscribeButtonPressed extends SubscriptionEvent {
  Subscription subscription;
  SubscribeButtonPressed(
      {required this.subscription});

  @override
  List<Object> get props => [subscription];
}

class LoadSubscriptionEvent extends SubscriptionEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
