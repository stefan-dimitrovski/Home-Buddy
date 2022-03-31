import 'package:flutter/material.dart';
import 'package:home_buddy_app/widgets/amenity.dart';

class AmenitiesList extends StatefulWidget {
  final Function(String type, bool add) passAmenityToParentCallback;
  const AmenitiesList({Key? key, required this.passAmenityToParentCallback})
      : super(key: key);

  @override
  _AmenitiesListState createState() => _AmenitiesListState();
}

class _AmenitiesListState extends State<AmenitiesList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.wifi,
            title: 'Wifi',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.local_parking,
            title: 'Parking',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.local_laundry_service,
            title: 'Laundry',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.ac_unit,
            title: 'AC',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.tv,
            title: 'TV',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.bathroom,
            title: 'Bathroom',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.local_hotel,
            title: 'Bedroom',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.kitchen,
            title: 'Fridge',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.fitness_center,
            title: 'Gym',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.pool,
            title: 'Pool',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Amenity(
            icon: Icons.elevator,
            title: 'Elevator',
            callback: widget.passAmenityToParentCallback,
          ),
        ),
      ],
    );
  }
}
