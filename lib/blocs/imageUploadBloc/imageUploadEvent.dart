import 'package:equatable/equatable.dart';

abstract class ImageUploadEvent extends Equatable {}

class UploadImageButtonPressed extends ImageUploadEvent {
  String filePath;
  String fileType;

  UploadImageButtonPressed({required this.filePath, required this.fileType});
  @override
  List<Object> get props => [];
}

class PhotoCaptureButtonPressed extends ImageUploadEvent {
  @override
  List<Object> get props => [];
}
