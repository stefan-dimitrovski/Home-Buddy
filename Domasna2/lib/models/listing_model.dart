import 'dart:ffi';

import 'package:home_buddy_app/models/address_model.dart';
import 'package:home_buddy_app/models/amenity_model.dart';

class Listing {
  final String id;
  final String title;
  final String phone;
  final Address address;
  final String description;
  final List<Amenity> amenities;
  final Double price;
  final List<String> image;

  Listing(this.id, this.title, this.phone, this.address, this.description,
      this.amenities, this.price, this.image);
}
