import 'dart:async';
import 'package:piassa_application/models/images.dart';
import 'package:piassa_application/repositories/matchPreferenceRepository.dart';
import 'package:piassa_application/repositories/uploadImageRepository.dart';
import './imageUploadEvent.dart';
import './imageUploadState.dart';
import 'package:bloc/bloc.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  UploadImageRepository? uploadImageRepository;
  Images? imagesToUpload;
  ImageUploadBloc({required UploadImageRepository ImageUploadRepository})
      : super(ImageUploadInitialState()) {
    this.uploadImageRepository = ImageUploadRepository;
  }

  @override
  ImageUploadState? get initialState => ImageUploadInitialState();

  @override
  Stream<ImageUploadState> mapEventToState(ImageUploadEvent event) async* {
    if (event is UploadImageButtonPressed) {
      yield ImageUploadLoadingState();
      try {
        imagesToUpload =
            Images(filePath: event.filePath, fileType: event.fileType);

        var userImageUpload = await uploadImageRepository!
            .uploadImageLink(imagesToUpload!.filePath, imagesToUpload!.fileType);

        // yield ImageUploadSuccessState(user);
        yield ImageUploadSuccessState();
      } catch (e) {
        yield ImageUploadFailState(e.toString());
      }
    }
  }
}
