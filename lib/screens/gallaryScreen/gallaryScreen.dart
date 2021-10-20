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
import 'package:piassa_application/models/images.dart';
import 'package:piassa_application/models/peoples.dart';
import 'package:piassa_application/models/userImage.dart';
import 'package:piassa_application/models/userMatch.dart';
import 'package:piassa_application/repositories/authRepository.dart';
import 'package:piassa_application/repositories/basicProfileRepository.dart';
import 'package:piassa_application/repositories/uploadImageRepository.dart';
import 'package:piassa_application/screens/allDoneScreen/allDoneScreen.dart';
import 'package:piassa_application/services/myProfileApiProvider.dart';
import 'package:piassa_application/services/uploadImageApiProvider.dart';
import 'package:piassa_application/utils/sheredPref.dart';

class GallaryScreen extends StatelessWidget {
  UploadImageRepository imageUploadRepository = UploadImageRepository();
  final BasicProfileRepository basicProfileRepository;
  bool toEdit;

  GallaryScreen({required this.basicProfileRepository, required this.toEdit});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ImageUploadBloc(imageUploadRepository: imageUploadRepository),
      child: GallaryScreenChild(
          imageUploadRepository: imageUploadRepository, toEditChild: toEdit),
    );
  }
}

class GallaryScreenChild extends StatefulWidget {
  // final User user;
  final UploadImageRepository imageUploadRepository;
  bool toEditChild;

  GallaryScreenChild(
      {Key? key,
      // required this.user,
      required this.imageUploadRepository,
      required this.toEditChild})
      : super(key: key);

  @override
  _GallaryScreenChildState createState() => _GallaryScreenChildState();
}

class _GallaryScreenChildState extends State<GallaryScreenChild> {
  List<XFile>? _imageFileList = [];
  List<XFile>? listToUpload = [];
  UserMatch? myProfile;
  List<UserImage> profileImages = [];
  bool gotData = false;

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
    await _displayPickImageDialog(context!, () async {
      try {
        final pickedFile =
            await _picker.pickImage(source: source, imageQuality: 80);

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

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  void _showDialog(id, filePath, fileType, itemToRemove) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Do you want to delete your photo?",
            style: TextStyle(fontSize: kNormalFont, color: Color(kBlack)),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new MaterialButton(
              child: new Text(
                "No",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new MaterialButton(
              child: new Text(
                "Yes",
                style: TextStyle(color: Color(klightPink)),
              ),
              onPressed: () async {
                await UploadImageApiProvider()
                    .deleteMyImage(id, filePath, fileType);
                setState(() {
                  profileImages.remove(itemToRemove);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _previewImages(bool edit) {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (edit) {
      return ListView(
        children: [
          SizedBox(height: 4),
          Text(
            '    Uploaded Photos',
            style: TextStyle(fontSize: kNormalFont),
          ),
          SizedBox(height: 4),
          GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: profileImages.length,
              itemBuilder: (BuildContext context, int index) {
                // String key = _imageFileMap.keys.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onLongPress: () async {
                      _showDialog(
                          myProfile!.userImages[index].id,
                          myProfile!.userImages[index].filePath,
                          myProfile!.userImages[index].fileType,
                          myProfile!.userImages[index]);
                    },
                    child: Image.network(
                      profileImages[index].filePath,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Center(
                            child: Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.red),
                        ));
                      },
                    ),
                  ),
                );
              }),
          SizedBox(height: 16),
        ],
      );
    } else {
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
  }

  Widget _handlePreview() {
    // if (isVideo) {
    //   return _previewVideo();
    // } else {
    return _previewImages(false);
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

  Future getMyProfile() async {
    myProfile = await MyProfileApiProvider().fetchMyProfile();
    profileImages = myProfile!.userImages;
  }

  @override
  void initState() {
    gotData = false;
    print(gotData);
    getMyProfile().then((value) {
      print(myProfile);
      setState(() {
        gotData = true;
      });
      print(gotData);
    });
    super.initState();
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
      body: gotData
          ? BlocListener<ImageUploadBloc, ImageUploadState>(
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
                  return widget.toEditChild
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: _previewImages(true),
                        )
                      : Container(
                          child: defaultTargetPlatform == TargetPlatform.android
                              ? FutureBuilder<void>(
                                  future: retrieveLostData(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<void> snapshot) {
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
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(klightPink))));
                } else if (state is ImageUploadFailState) {
                  print(state.message);
                  return Text(state.message);
                }
                return Container();
              }),
            )
          : Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(klightPink))),
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
  }
}

typedef void OnPickImageCallback();
