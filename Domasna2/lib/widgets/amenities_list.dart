import 'package:flutter/material.dart';
import 'package:home_buddy_app/widgets/amenity.dart';

class AmenitiesList extends StatefulWidget {
  AmenitiesList({Key? key}) : super(key: key);

  @override
  _AmenitiesListState createState() => _AmenitiesListState();
}

class _AmenitiesListState extends State<AmenitiesList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        //TODO: Add amenities
        Container(
          width: 100.0,
          child: const Amenity(
            icon: Icons.wifi,
            title: 'Wi-Fi',
          ),
        ),
        Container(
          width: 100.0,
          child: const Amenity(
            icon: Icons.local_parking,
            title: 'Parking',
          ),
        ),
        Container(
          width: 100.0,
          child: const Amenity(
            icon: Icons.local_laundry_service,
            title: 'Laundry',
          ),
        ),
        Container(
          width: 100.0,
          child: const Amenity(
            icon: Icons.ac_unit,
            title: 'AC',
          ),
        ),
        Container(
          width: 100.0,
          child: const Amenity(
            icon: Icons.tv,
            title: 'TV',
          ),
        ),
      ],
    );
  }
}
