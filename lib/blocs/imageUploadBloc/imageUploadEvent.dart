import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageUploadEvent extends Equatable {}

class UploadImageButtonPressed extends ImageUploadEvent {
  // Map<String, File> file;
  List<XFile> file;

  UploadImageButtonPressed({required this.file});
  @override
  List<Object> get props => [];
}

class PhotoCaptureButtonPressed extends ImageUploadEvent {
  // Map<String, File> images;
  List<XFile> images;
  String fileType;

  PhotoCaptureButtonPressed({required this.images, required this.fileType});

  @override
  List<Object> get props => [];
}
