import 'package:flutter/material.dart';

class Amenity {
  final IconData icon;
  final String title;

  static final List<Amenity> amenities = [
    Amenity(
      icon: Icons.wifi,
      title: 'Wifi',
    ),
    Amenity(
      icon: Icons.local_parking,
      title: 'Parking',
    ),
    Amenity(
      icon: Icons.bathroom,
      title: 'Bathroom',
    ),
    Amenity(
      icon: Icons.kitchen,
      title: 'Fridge',
    ),
    Amenity(
      icon: Icons.local_hotel,
      title: 'Bedroom',
    ),
    Amenity(
      icon: Icons.local_laundry_service,
      title: 'Laundry',
    ),
    Amenity(
      icon: Icons.ac_unit,
      title: 'AC',
    ),
    Amenity(
      icon: Icons.tv,
      title: 'TV',
    ),
    Amenity(
      icon: Icons.fitness_center,
      title: 'Gym',
    ),
    Amenity(
      icon: Icons.pool,
      title: 'Pool',
    ),
    Amenity(
      icon: Icons.elevator,
      title: 'Elevator',
    ),
  ];

  Amenity({required this.icon, required this.title});
}
