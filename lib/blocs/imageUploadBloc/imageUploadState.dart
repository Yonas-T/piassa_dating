import 'package:equatable/equatable.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/preference.dart';

abstract class ImageUploadState extends Equatable {}

class ImageUploadInitialState extends ImageUploadState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ImageUploadLoadingState extends ImageUploadState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ImagePickedState extends ImageUploadState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ImageUploadSuccessState extends ImageUploadState {
  // Peoples user;
  // Preference preference;

  // ImageUploadSuccessState(
  //   this.user, 
  //   this.preference);

  @override
  // TODO: implement props
  List<Object> get props => [];
}


class ImageUploadFailState extends ImageUploadState {
  String message;

  ImageUploadFailState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
