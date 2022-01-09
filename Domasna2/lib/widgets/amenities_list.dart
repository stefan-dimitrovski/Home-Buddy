import 'package:flutter/material.dart';
import 'package:home_buddy_app/widgets/amenity.dart';

class AmenitiesList extends StatefulWidget {
  const AmenitiesList({Key? key}) : super(key: key);

  @override
  _AmenitiesListState createState() => _AmenitiesListState();
}

class _AmenitiesListState extends State<AmenitiesList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const <Widget>[
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.wifi,
            title: 'Wifi',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.local_parking,
            title: 'Parking',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.local_laundry_service,
            title: 'Laundry',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.ac_unit,
            title: 'AC',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.tv,
            title: 'TV',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.bathroom,
            title: 'Bathroom',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.local_hotel,
            title: 'Bedroom',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.kitchen,
            title: 'Fridge',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.fitness_center,
            title: 'Gym',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.pool,
            title: 'Pool',
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.elevator,
            title: 'Elevator',
          ),
        ),
      ],
    );
  }
}
