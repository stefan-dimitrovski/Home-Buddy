import 'package:flutter/material.dart';
import 'package:home_buddy_app/widgets/picture.dart';

class PictureUploads extends StatefulWidget {
  const PictureUploads({Key? key}) : super(key: key);

  @override
  _PictureUploadsState createState() => _PictureUploadsState();
}

class _PictureUploadsState extends State<PictureUploads> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const <Widget>[
        SizedBox(
          width: 150.0,
          child: Picture(
              // image: 'assets/images/image1.jpg',
              ),
        ),
        SizedBox(
          width: 150.0,
          child: Picture(),
        ),
        SizedBox(
          width: 150.0,
          child: Picture(),
        ),
        SizedBox(
          width: 150.0,
          child: Picture(),
        ),
        SizedBox(
          width: 150.0,
          child: Picture(),
        ),
      ],
    );
  }
}
