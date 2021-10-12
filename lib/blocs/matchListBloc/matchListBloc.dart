import 'dart:async';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/repositories/matchListRepository.dart';
import './matchListEvent.dart';
import './matchListState.dart';
import 'package:bloc/bloc.dart';

class MatchListBloc extends Bloc<MatchListEvent, MatchListState> {
  MatchListRepository? matchListRepository;
  UserMatch? matchListToProceed;

  MatchListBloc({required MatchListRepository matchListRepository})
      : super(InitialMatchListState()) {
    this.matchListRepository = matchListRepository;
  }

  @override
  MatchListState? get initialState => InitialMatchListState();

  @override
  Stream<MatchListState> mapEventToState(MatchListEvent event) async* {
    if (event is LoadMatchedList) {
      yield MatchListLoadingState();
      try {
        print('Queue BEFORE BLOC');

        var userMatchList = await matchListRepository!.fetchMatchList();

        // yield MatchListSuccessState(user);
      
        print('Queue AFTER BLOC');
        yield LoadedMatchListState(userMatchList);
      } catch (e) {
        yield MatchListFailState(e.toString());
      }
    }
  }
}
