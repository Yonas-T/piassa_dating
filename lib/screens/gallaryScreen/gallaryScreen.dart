import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piassa_application/blocs/imageUploadBloc/imageUploadBloc.dart';
import 'package:piassa_application/blocs/imageUploadBloc/imageUploadEvent.dart';
import 'package:piassa_application/blocs/imageUploadBloc/imageUploadState.dart';
import 'package:piassa_application/constants/constants.dart';
import 'package:piassa_application/generalWidgets/appBar.dart';
import 'package:piassa_application/generalWidgets/tabs.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/uploadImageRepository.dart';
import 'package:piassa_application/screens/allDoneScreen/allDoneScreen.dart';
import 'package:piassa_application/services/uploadImageApiProvider.dart';
import 'package:piassa_application/utils/sheredPref.dart';

class GallaryScreen extends StatelessWidget {
  UploadImageRepository imageUploadRepository = UploadImageRepository();
  final BasicProfileRepository basicProfileRepository;

  GallaryScreen({required this.basicProfileRepository});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ImageUploadBloc(imageUploadRepository: imageUploadRepository),
      child: GallaryScreenChild(
        imageUploadRepository: imageUploadRepository,
      ),
    );
  }
}

class GallaryScreenChild extends StatefulWidget {
  // final User user;
  final UploadImageRepository imageUploadRepository;

  const GallaryScreenChild(
      {Key? key,
      // required this.user,
      required this.imageUploadRepository})
      : super(key: key);

  @override
  _GallaryScreenChildState createState() => _GallaryScreenChildState();
}

class _GallaryScreenChildState extends State<GallaryScreenChild> {
  List<XFile>? _imageFileList = [];
  List<XFile>? listToUpload = [];
  // var _imageFileMap = Map<String, XFile>();
  XFile? _cameraFile;
  AuthRepository? userRepository;
  User? user;
  bool keyValue = true;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    // if (_controller != null) {
    //   await _controller!.setVolume(0.0);
    // }
    // if (isVideo) {
    //   final XFile? file = await _picker.pickVideo(
    //       source: source, maxDuration: const Duration(seconds: 10));
    // await _playVideo(file);
    // } else
    // if (isMultiImage) {
    //   await _displayPickImageDialog(context!, () async {
    //     try {
    //       final pickedFileList = await _picker.pickMultiImage();
    //       setState(() {
    //         _imageFileList = pickedFileList;
    //       });
    //     } catch (e) {
    //       setState(() {
    //         _pickImageError = e;
    //       });
    //     }
    //   });
    // } else {
    await _displayPickImageDialog(context!, () async {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
          // preferredCameraDevice: source == ImageSource.camera? CameraDevice.front: CameraDevice.rear
        );

        if (source == ImageSource.camera) {
          if (pickedFile!.path.isNotEmpty) {
            setState(() {
              _imageFileList!.add(pickedFile);

              // _cameraFile = pickedFile;
            });
          }
        } else {
          if (pickedFile!.path.isNotEmpty && _imageFileList!.length < 4) {
            var i = 1;
            setState(() {
              print(pickedFile.path);
              // keyValue
              // ? _imageFileMap['PROFILE'] = pickedFile
              //  _imageFileMap['GALLERY$i'] = pickedFile;
              // keyValue = false;
              i++;
              print(keyValue);
              _imageFileList!.add(pickedFile);
            });
          }
        }

        // setState(() {
        //   _imageFile = pickedFile;
        // });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
    // }
  }

  // @override
  // void deactivate() {
  //   if (_controller != null) {
  //     _controller!.setVolume(0.0);
  //     _controller!.pause();
  //   }
  //   super.deactivate();
  // }

  @override
  void dispose() {
    // _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_cameraFile != null || _imageFileList != null) {
      return ListView(
        children: [
          SizedBox(height: 4),
          Text(
            '    Upload Photos',
            style: TextStyle(fontSize: kNormalFont),
          ),
          SizedBox(height: 4),
          _imageFileList!.length != 0
              ? GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: _imageFileList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    // String key = _imageFileMap.keys.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(_imageFileList![index].path),
                        fit: BoxFit.cover,
                      ),
                    );
                  })
              : GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.3,
                      color: Colors.grey[300],
                    );
                  }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '    Selfie for Verification',
                style: TextStyle(fontSize: kNormalFont),
              ),
              _cameraFile != null
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(_cameraFile!.path),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                        Container()
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 8, 8, 8),
                          width: MediaQuery.of(context).size.width * 0.49,
                          height: MediaQuery.of(context).size.height * 0.3,
                          color: Colors.grey[300],
                        ),
                        Container()
                      ],
                    ),
            ],
          ),
          SizedBox(height: 16),
        ],
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return ListView(
        children: [
          SizedBox(height: 4),
          Text(
            '    Upload Photos',
            style: TextStyle(fontSize: kNormalFont),
          ),
          SizedBox(height: 4),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.grey[300],
                );
              }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                '    Selfie for Verification',
                style: TextStyle(fontSize: kNormalFont),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 8, 8, 8),
                    width: MediaQuery.of(context).size.width * 0.49,
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Colors.grey[300],
                  ),
                  Container()
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      );
    }
  }

  Widget _handlePreview() {
    // if (isVideo) {
    //   return _previewVideo();
    // } else {
    return _previewImages();
    // }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        // await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_imageFileList);
    return Scaffold(
      backgroundColor: Color(kWhite),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 16.0),
          child: AppBarWidget(
            actionIcon: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(klightPink), shape: BoxShape.circle),
                child: IconButton(
                    onPressed: () {
                      BlocProvider.of<ImageUploadBloc>(context)
                          .add(UploadImageButtonPressed(file: _imageFileList!));
                    },
                    icon: Icon(
                      Icons.check,
                      color: Color(kWhite),
                      size: 14,
                    ))),
            colorVal: Color(kWhite),
            leadingIcon: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(klightPink), size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Gallery',
                style:
                    TextStyle(fontSize: kTitleBoldFont, color: Color(kBlack))),
          ),
        ),
      ),
      body: BlocListener<ImageUploadBloc, ImageUploadState>(
        listener: (context, state) {
          print(state);
          if (state is ImageUploadSuccessState) {
            navigateToAllDoneScreen(context
                // , state.user
                );
            SetSharedPrefValue().setSignupValue('HasImageValue');
            
          }
        },
        child: BlocBuilder<ImageUploadBloc, ImageUploadState>(
            builder: (context, state) {
          if (state is ImageUploadInitialState) {
            return Container(
              child: defaultTargetPlatform == TargetPlatform.android
                  ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return _handlePreview();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                      },
                    )
                  : _handlePreview(),
            );
          } else if (state is ImageUploadLoadingState) {
            return Center(child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Color(klightPink))));
          } else if (state is ImageUploadFailState) {
            print(state.message);
            return Text(state.message);
          }
          return Container();
        }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // SizedBox(width: 2),
          // Semantics(
          //   label: 'image_picker_._from_gallery',
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       UploadImageApiProvider().uploadFile(_imageFileList, 'PROFILE');
          //     },
          //     heroTag: 'image0',
          //     tooltip: 'Pick Image from gallery',
          //     child: const Icon(Icons.photo),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, left: 32),
            child: FloatingActionButton(
              backgroundColor: Color(klightPink),
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(
                  ImageSource.gallery,
                  context: context,
                  isMultiImage: true,
                );
              },
              heroTag: 'image1',
              tooltip: 'Pick Multiple Image from gallery',
              child: const Icon(
                Icons.camera,
                color: Color(kWhite),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: FloatingActionButton(
              backgroundColor: Color(klightPink),
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(
                Icons.camera_alt,
                color: Color(kWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToAllDoneScreen(BuildContext context
      // , Peoples user
      ) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AllDoneScreen(user: user, userRepository: userRepository);
      // Tabs(user: user, userRepository: userRepository);
    }));
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return onPick();
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text('Add optional parameters'),
    //         content: Column(
    //           children: <Widget>[
    //             // TextField(
    //             //   controller: maxWidthController,
    //             //   keyboardType: TextInputType.numberWithOptions(decimal: true),
    //             //   decoration:
    //             //       InputDecoration(hintText: "Enter maxWidth if desired"),
    //             // ),
    //             // TextField(
    //             //   controller: maxHeightController,
    //             //   keyboardType: TextInputType.numberWithOptions(decimal: true),
    //             //   decoration:
    //             //       InputDecoration(hintText: "Enter maxHeight if desired"),
    //             // ),
    //             // TextField(
    //             //   controller: qualityController,
    //             //   keyboardType: TextInputType.number,
    //             //   decoration:
    //             //       InputDecoration(hintText: "Enter quality if desired"),
    //             // ),
    //           ],
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('CANCEL'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //           TextButton(
    //               child: const Text('PICK'),
    //               onPressed: () {
    //                 double? width = maxWidthController.text.isNotEmpty
    //                     ? double.parse(maxWidthController.text)
    //                     : null;
    //                 double? height = maxHeightController.text.isNotEmpty
    //                     ? double.parse(maxHeightController.text)
    //                     : null;
    //                 int? quality = qualityController.text.isNotEmpty
    //                     ? int.parse(qualityController.text)
    //                     : null;
    //                 onPick(width, height, quality);
    //                 Navigator.of(context).pop();
    //               }),
    //         ],
    //       );
    //     });
  }
}

typedef void OnPickImageCallback(
    // double? maxWidth, double? maxHeight, int? quality
    );

// class AspectRatioVideo extends StatefulWidget {
//   AspectRatioVideo(this.controller);

//   final VideoPlayerController? controller;

//   @override
//   AspectRatioVideoState createState() => AspectRatioVideoState();
// }

// class AspectRatioVideoState extends State<AspectRatioVideo> {
//   VideoPlayerController? get controller => widget.controller;
//   bool initialized = false;

//   void _onVideoControllerUpdate() {
//     if (!mounted) {
//       return;
//     }
//     if (initialized != controller!.value.isInitialized) {
//       initialized = controller!.value.isInitialized;
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller!.addListener(_onVideoControllerUpdate);
//   }

//   @override
//   void dispose() {
//     controller!.removeListener(_onVideoControllerUpdate);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (initialized) {
//       return Center(
//         child: AspectRatio(
//           aspectRatio: controller!.value.aspectRatio,
//           child: VideoPlayer(controller!),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
// }

