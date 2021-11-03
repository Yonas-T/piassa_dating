import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/subscription.dart';

abstract class SubscriptionState extends Equatable {}

class SubscriptionInitialState extends SubscriptionState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SubscriptionLoadingState extends SubscriptionState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SubscriptionSuccessState extends SubscriptionState {
  Subscription subscription;

  SubscriptionSuccessState(this.subscription);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SubscriptionLoadedState extends SubscriptionState {
  List<Subscription> subscription;

  SubscriptionLoadedState(this.subscription);

  @override
  // TODO: implement props
  List<Object> get props => [];
}



class SubscriptionFailState extends SubscriptionState {
  String message;

  SubscriptionFailState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
