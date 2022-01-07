import 'dart:ffi';

import 'package:home_buddy_app/models/address_model.dart';
import 'package:home_buddy_app/models/amenity_model.dart';

class Listing {
  final String id;
  final String title;
  final String phone;
  final Address address;
  final String description;
  final Double price;
  final Type type;
  final int bedrooms;
  final int bathrooms;
  final List<Amenity> amenities;
  final List<String> image;

  Listing(
      this.id,
      this.title,
      this.phone,
      this.address,
      this.description,
      this.amenities,
      this.price,
      this.image,
      this.type,
      this.bedrooms,
      this.bathrooms);
}
