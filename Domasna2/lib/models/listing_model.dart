import 'package:home_buddy_app/models/address_model.dart';
import 'package:home_buddy_app/models/amenity_model.dart';
import 'package:home_buddy_app/models/listing_type.dart';

class Listing {
  final String id;
  final String title;
  final String phone;
  final Address address;
  final String description;
  final double price;
  final ListingType type;
  final int bedrooms;
  final int bathrooms;
  final List<Amenity> amenities = Amenity.amenities;
  final List<String> images;

  Listing(
    this.id,
    this.title,
    this.phone,
    this.address,
    this.description,
    this.price,
    this.images,
    this.type,
    this.bedrooms,
    this.bathrooms,
  );

  String get getId => id;
  String get getTitle => title;
  String get getPhone => phone;
  Address get getAddress => address;
  String get getDescription => description;
  double get getPrice => price;
  ListingType get getType => type;
  int get getBedrooms => bedrooms;
  int get getBathrooms => bathrooms;
  List<String> get getImages => images;
}
