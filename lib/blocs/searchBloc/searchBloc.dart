import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piassa_application/blocs/searchBloc/searchEvent.dart';
import 'package:piassa_application/blocs/searchBloc/searchState.dart';
import 'package:piassa_application/models/education.dart';
import 'package:piassa_application/models/lifeStyle.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/repositories/searchRepository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository _searchRepository;

  SearchBloc({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(InitialSearchState());

  @override
  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SelectUserEvent) {
      yield* _mapSelectToState(recommendedId: event.recommendedId);
    }
    if (event is PassUserEvent) {
      yield* _mapPassToState(recommendedId: event.recommendedId);
    }
    if (event is LoadUserEvent) {
      yield* _mapLoadUserToState();
    }
  }

  Stream<SearchState> _mapSelectToState(
      {required String recommendedId}) async* {
    try {
      List<UserMatch> _matchRecommendations =
          await _searchRepository.fetchPeoplesToSearchFor();
      print('MATCHRECOM:${_matchRecommendations.length}');
      _matchRecommendations.removeWhere((item) => item.id == recommendedId);
      print('MATCHRECOM-1:${_matchRecommendations.length}');

      String selectRecommended =
          await _searchRepository.choosePeople(recommendedId);
      yield LoadedUserState(_matchRecommendations);
    } catch (e) {
      yield LoadUserFailState(e.toString());
    }
    yield SearchLoadingState();
  }

  Stream<SearchState> _mapPassToState({required String recommendedId}) async* {
    try {
      yield SearchLoadingState();
      List<UserMatch> _matchRecommendations =
          await _searchRepository.fetchPeoplesToSearchFor();
      print('MATCHRECOM:${_matchRecommendations.length}');
      _matchRecommendations.removeWhere((item) => item.id == recommendedId);
      print('MATCHRECOM-1:${_matchRecommendations.length}');

      String passRecommended =
          await _searchRepository.choosePeople(recommendedId);

      yield LoadedUserState(_matchRecommendations);
    } catch (e) {
      yield LoadUserFailState(e.toString());
    }
  }

  Stream<SearchState> _mapLoadUserToState() async* {
    yield InitialSearchState();
    try {
      List<UserMatch> _matchRecommendations =
          await _searchRepository.fetchPeoplesToSearchFor();
      print('IN BLOC RECOMM: $_matchRecommendations');
      yield LoadedUserState(_matchRecommendations);
    } catch (e) {
      yield LoadUserFailState(e.toString());
    }
  }
}
