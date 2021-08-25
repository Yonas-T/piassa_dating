
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piassa_application/blocs/searchBloc/searchEvent.dart';
import 'package:piassa_application/blocs/searchBloc/searchState.dart';
import 'package:piassa_application/models/peoples.dart';
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
      yield* _mapSelectToState(
          currentPeoplesId: '', name: '', photoUrl: '', selectedPeoplesId: '');
    }
    if (event is PassUserEvent) {
      yield* _mapPassToState(
        currentPeoplesId: event.currentPeopleId,
        selectedPeoplesId: event.selectedPeopleId,
      );
    }
    if (event is LoadUserEvent) {
      yield* _mapLoadUserToState(currentPeoplesId: event.peopleId);
    }
  }

  Stream<SearchState> _mapSelectToState(
      {required String currentPeoplesId,
      required String selectedPeoplesId,
      required String name,
      required String photoUrl}) async* {
    yield LoadingState();

    // Peoples user = await _searchRepository.chooseUser(
    //     currentPeoplesId, selectedPeoplesId, name, photoUrl);

    // Peoples currentUser =
    //     await _searchRepository.getUserInterests(currentUserId);
    Peoples user = Peoples(
        name: 'name',
        id: 'id',
        gender: 'male',
        time: 'time',
        location: GeoPoint(10, 10),
        profilePictureURL: 'profilePictureURL',
        lastMessage: 'lastMessage');
    Peoples currentUser = Peoples(name: 'name', gender: 'male', location: GeoPoint(10, 10), id: 'id', time: 'time', profilePictureURL: 'profilePictureURL', lastMessage: 'lastMessage');
    yield LoadUserState(user, currentUser);
  }

  Stream<SearchState> _mapPassToState(
      {required String currentPeoplesId,
      required String selectedPeoplesId}) async* {
    yield LoadingState();
    // Peoples user =
    //     await _searchRepository.passUser(currentPeoplesId, selectedPeoplesId);
    // Peoples currentUser =
    //     await _searchRepository.getUserInterests(currentPeoplesId);
    Peoples user = Peoples(
        name: 'name',
        id: 'id',
        time: 'time',
        gender: 'male',
        location: GeoPoint(10, 10),
        profilePictureURL: 'profilePictureURL',
        lastMessage: 'lastMessage');
    Peoples currentUser = Peoples(name: 'name', location: GeoPoint(10, 10), gender: 'male', id: 'id', time: 'time', profilePictureURL: 'profilePictureURL', lastMessage: 'lastMessage');

    yield LoadUserState(user, currentUser);
  }

  Stream<SearchState> _mapLoadUserToState(
      {required String currentPeoplesId}) async* {
    yield LoadingState();
    // Peoples user = await _searchRepository.getUser(currentPeoplesId);
    // Peoples currentUser =
    //     await _searchRepository.getUserInterests(currentPeoplesId);
    Peoples user = Peoples(
        name: 'name',
        id: 'id',
        time: 'time',
        gender: 'male',
        location: GeoPoint(10, 10),
        profilePictureURL: 'profilePictureURL',
        lastMessage: 'lastMessage');
    Peoples currentUser = Peoples(name: 'name', gender: 'male', id: 'id', location: GeoPoint(10, 10),time: 'time', profilePictureURL: 'profilePictureURL', lastMessage: 'lastMessage');

    yield LoadUserState(user, currentUser);
  }
}
