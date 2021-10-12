import 'dart:async';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/repositories/matchListRepository.dart';
import './matchQueueEvent.dart';
import './matchQueueState.dart';
import 'package:bloc/bloc.dart';

class MatchQueueBloc extends Bloc<MatchQueueEvent, MatchQueueState> {
  MatchListRepository matchQueueRepository = MatchListRepository();
  UserMatch? matchListToProceed;

  MatchQueueBloc({required MatchListRepository matchListRepository})
      : super(InitialMatchQueueState()) {
    this.matchQueueRepository = matchQueueRepository;
  }

  @override
  MatchQueueState? get initialState => InitialMatchQueueState();

  @override
  Stream<MatchQueueState> mapEventToState(MatchQueueEvent event) async* {
    if (event is LoadMatchQueue) {
      yield MatchQueueLoadingState();
      try {
        print('BEFORE BLOC');

        var userMatchQueue = await matchQueueRepository.fetchMatchQueue();

        // yield MatchListSuccessState(user);

        print('AFTER BLOC');
        yield LoadedMatchQueueState(userMatchQueue);
      } catch (e) {
        yield MatchQueueFailState(e.toString());
      }
    }
    if (event is LikeMatchQueue) {
      yield MatchQueueLoadingState();
      try {
        print('BEFORE BLOC');

        var userMatchLike =
            await matchQueueRepository.postLikedMatch(event.likedId);
        var userMatchQueue = await matchQueueRepository.fetchMatchQueue();
        print('MATCHRECOM:${userMatchQueue.length}');
        userMatchQueue.removeWhere((item) => item.id == event.likedId);
        print('MATCHRECOM-1:${userMatchQueue.length}');

        // yield MatchListSuccessState(user);

        print('AFTER BLOC');
        yield LoadedMatchQueueState(userMatchQueue);
      } catch (e) {
        yield MatchQueueFailState(e.toString());
      }
    }
    // if (event is LoadMatchedList) {
    //   yield MatchQueueLoadingState();
    //   try {
    //     print('Queue BEFORE BLOC');

    //     var userMatchList = await matchQueueRepository.fetchMatchList();

    //     // yield MatchListSuccessState(user);

    //     print('Queue AFTER BLOC');
    //     yield LoadedMatchListState(userMatchList);
    //   } catch (e) {
    //     print(e);
    //     yield MatchQueueFailState(e.toString());
    //   }
    // }
  }
}
