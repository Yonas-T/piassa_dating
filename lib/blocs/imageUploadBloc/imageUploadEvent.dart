import 'dart:io';

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
  List<File> images;

  PhotoCaptureButtonPressed({required this.images});
  
  @override
  List<Object> get props => [];
}
