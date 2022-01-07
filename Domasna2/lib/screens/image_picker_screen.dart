import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelect extends StatefulWidget {
  const ImageSelect({Key? key}) : super(key: key);

  @override
  _ImageSelectState createState() => _ImageSelectState();
}

class _ImageSelectState extends State<ImageSelect> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final pickedFileList = await _picker.pickMultiImage(imageQuality: 75);
        setState(() {
          _imageFileList = pickedFileList;
        });
      } catch (e) {
        setState(() {});
      }
    } else {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
          imageQuality: 75,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {});
      }
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 60,
              child: ElevatedButton(
                onPressed: () => _onImageButtonPressed(ImageSource.gallery,
                    context: context, isMultiImage: true),
                child: const Icon(Icons.photo_library),
              ),
            ),
            SizedBox(
              width: 60,
              child: ElevatedButton(
                onPressed: () => _onImageButtonPressed(
                  ImageSource.camera,
                  context: context,
                ),
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
        _imageFileList != null
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imageFileList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageView(
                              imageFile: _imageFileList![index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        margin: const EdgeInsets.only(right: 10),
                        child: Image.file(
                          File(_imageFileList![index].path),
                          fit: BoxFit.fill,
                          width: 250,
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(
                margin: const EdgeInsets.only(top: 25),
                child: const Text(
                  'You have not yet picked an image.',
                  textAlign: TextAlign.center,
                ),
              ),
      ],
    );
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _imageFileList = response.files;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
          ? FutureBuilder<void>(
              future: retrieveLostData(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
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
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}

class ImageView extends StatefulWidget {
  var imageFile;

  ImageView({Key? key, required this.imageFile}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image View'),
      ),
      body: Center(
        child: Image.file(
          File(
            widget.imageFile.path,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
