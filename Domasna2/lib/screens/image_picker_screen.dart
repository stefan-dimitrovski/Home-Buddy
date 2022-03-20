import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy_app/screens/image_view_screen.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelect extends StatefulWidget {
  final Function(List<XFile>) passData;
  const ImageSelect({Key? key, required this.passData}) : super(key: key);

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
      } finally {
        widget.passData(_imageFileList!);
      }
    } else {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
          imageQuality: 75,
        );
        setState(() {
          // _imageFile = pickedFile;
          if (pickedFile != null) {
            _imageFileList!.add(pickedFile);
          }
        });
      } catch (e) {
        setState(() {});
      } finally {
        widget.passData(_imageFileList!);
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
              margin: const EdgeInsets.only(right: 15),
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
            ? Container(
                margin: const EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height / 5,
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
                            builder: (context) => ImageViewer(
                              imageFile: _imageFileList![index].path,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.file(
                            File(_imageFileList![index].path),
                            fit: BoxFit.cover,
                            width: 150,
                          ),
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
