import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  String imageFile;
  ImageViewer({Key? key, required this.imageFile}) : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  imageType() {
    if (widget.imageFile.startsWith("/")) {
      return Image.file(File(widget.imageFile)).image;
    } else {
      return NetworkImage(widget.imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage(widget.imageFile);
    Image.file(File(widget.imageFile)).image;
    return PhotoView(
      imageProvider: imageType(),
    );
  }
}
