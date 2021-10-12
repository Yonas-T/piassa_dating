import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:piassa_application/models/images.dart';
import 'package:piassa_application/repositories/uploadImageRepository.dart';
import './imageUploadEvent.dart';
import './imageUploadState.dart';
import 'package:bloc/bloc.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  UploadImageRepository? uploadImageRepository;
  List<XFile>? images;
  List<XFile>? photosToCapture;
  String? photoTag;
  ImageUploadBloc({required UploadImageRepository imageUploadRepository})
      : super(ImageUploadInitialState()) {
    this.uploadImageRepository = imageUploadRepository;
  }

  @override
  ImageUploadState? get initialState => ImageUploadInitialState();

  @override
  Stream<ImageUploadState> mapEventToState(ImageUploadEvent event) async* {
    if (event is UploadImageButtonPressed) {
      yield ImageUploadLoadingState();
      try {
        images = event.file;

        var userImageUpload = await uploadImageRepository!.uploadFile(images);

        // yield ImageUploadSuccessState(user);
        yield ImageUploadSuccessState();
      } catch (e) {
        yield ImageUploadFailState(e.toString());
      }
    }
    // if (event is PhotoCaptureButtonPressed) {
    //   yield ImageUploadLoadingState();
    //   try {
    //     photosToCapture = event.images;
    //     photoTag = event.fileType;

    //     var userPhotosCapture =
    //         await uploadImageRepository!.uploadFile(photosToCapture, photoTag);

    //     yield ImagePickedState();
    //   } catch (e) {}
    // }
  }
}
