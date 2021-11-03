import 'dart:async';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/repositories/subscriptionRepository.dart';
import './subscriptionEvent.dart';
import './subscriptionState.dart';
import 'package:bloc/bloc.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionRepository? subscriptionRepository;
  Peoples? subscriptionToProceed;
  Preference? preferencetoSubmit;

  SubscriptionBloc({required SubscriptionRepository subscriptionRepository})
      : super(SubscriptionInitialState()) {
    this.subscriptionRepository = subscriptionRepository;
  }

  @override
  SubscriptionState? get initialState => SubscriptionInitialState();

  @override
  Stream<SubscriptionState> mapEventToState(SubscriptionEvent event) async* {
    if (event is SubscribeButtonPressed) {
      yield SubscriptionLoadingState();
      try {
        print('BEFORE');

        var userSubscription =
            await subscriptionRepository!.postSubscriptionSelected(event.subscription);

        print(userSubscription.name);
        print('AFTER');
        yield SubscriptionSuccessState(userSubscription);
      } catch (e) {
        yield SubscriptionFailState(e.toString());
      }
    }
    if (event is LoadSubscriptionEvent) {
      yield SubscriptionLoadingState();
      try {
        var subscriptionFetched =
            await subscriptionRepository!.fetchSubscription();

        yield SubscriptionLoadedState(subscriptionFetched);
      } catch (e) {
        yield SubscriptionFailState(e.toString());
      }
    }
  }
}
