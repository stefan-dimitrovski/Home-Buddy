import 'package:home_buddy_app/models/address_model.dart';
import 'package:home_buddy_app/models/amenity_model.dart';
import 'package:home_buddy_app/models/listing_type.dart';

class Listing {
  String title;
  String phone;
  Address address;
  String description;
  double price;
  ListingType category;
  int bedrooms;
  int bathrooms;
  List<Amenity> amenities = Amenity.amenities;
  List<dynamic> images;
  String owner;

  Listing({
    required this.title,
    required this.phone,
    required this.address,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    required this.bedrooms,
    required this.bathrooms,
    required this.owner,
  });

  String get getTitle => title;
  String get getPhone => phone;
  Address get getAddress => address;
  String get getDescription => description;
  double get getPrice => price;
  ListingType get getCategory => category;
  int get getBedrooms => bedrooms;
  int get getBathrooms => bathrooms;
  List<dynamic> get getImages => images;
  String get getOwner => owner;

  Listing.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        phone = json['phone'],
        address = Address.fromJson(json['address']),
        description = json['description'],
        price = json['price'],
        images = json['images'],
        category = ListingType.values[json['category']],
        bedrooms = json['bedrooms'],
        bathrooms = json['bathrooms'],
        owner = json['owner'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'phone': phone,
        'address': address.toJson(),
        'description': description,
        'price': price,
        'images': images,
        'category': category.index,
        'bedrooms': bedrooms,
        'bathrooms': bathrooms,
        'owner': owner,
      };

  @override
  String toString() {
    return 'Listing{title: $title, phone: $phone, address: $address, description: $description, price: $price, images: $images, category: $category, bedrooms: $bedrooms, bathrooms: $bathrooms, owner: $owner}';
  }
}
