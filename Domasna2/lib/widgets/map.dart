import 'package:flutter/material.dart';
import 'package:home_buddy_app/screens/map_screen.dart';

class Map extends StatefulWidget {
  Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 120,
          width: 170,
          child: Image.network(
            'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0.0,
          right: 0.0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MapView();
                }));
              },
              child: Text('Show Map'),
            ),
          ),
        ),
      ],
    );
  }
}
