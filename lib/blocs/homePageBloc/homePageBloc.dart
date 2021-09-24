// import './homePageEvent.dart';
// import './homePageState.dart';
// import '../../repositories/authRepository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
//   late AuthRepository userRepository;

//   HomePageBloc({required AuthRepository userRepository}) : super(LogOutInitial()) {
//     this.userRepository = userRepository;
//   }

//   @override
//   // TODO: implement initialState
//   HomePageState get initialState => LogOutInitial();

//   @override
//   Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
//     if (event is LogOutEvent) {
//       print("LOG out Bloc");
//       userRepository.signOut();
//       yield LogOutSuccessState();
//     }
//   }
// }