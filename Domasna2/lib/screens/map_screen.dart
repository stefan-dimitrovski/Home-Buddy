import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MapView'),
      ),
      body: Center(
        child: Text('MapView'),
      ),
    );
  }
}
