import 'package:home_buddy_app/models/address_model.dart';
// import 'package:home_buddy_app/models/amenity_model.dart';
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
  // List<Amenity> amenities = Amenity.amenities;
  List<dynamic> images;
  String owner;
  List<dynamic> amenities;

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
    required this.amenities,
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
  List<dynamic> get getAmenities => amenities;

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
        owner = json['owner'],
        amenities = json['amenities'];

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
        'amenities': amenities,
      };

  @override
  String toString() {
    return 'Listing{title: $title, phone: $phone, address: $address, description: $description, price: $price, images: $images, category: $category, bedrooms: $bedrooms, bathrooms: $bathrooms, owner: $owner}';
  }

  Listing._builder(ListingBuilder builder)
      : title = builder.title,
        phone = builder.phone,
        address = builder.address,
        description = builder.description,
        price = builder.price,
        images = builder.images,
        category = builder.category,
        bedrooms = builder.bedrooms,
        bathrooms = builder.bathrooms,
        owner = builder.owner,
        amenities = builder.amenities;
}

class ListingBuilder {
  late String title;
  late String phone;
  late Address address;
  late String description;
  late double price;
  late List<dynamic> images;
  late ListingType category;
  late int bedrooms;
  late int bathrooms;
  late String owner;
  late List<dynamic> amenities;

  void setTitle(String title) {
    this.title = title;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }

  void setAddress(Address address) {
    this.address = address;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setPrice(double price) {
    this.price = price;
  }

  void setImages(List<dynamic> images) {
    this.images = images;
  }

  void setCategory(ListingType category) {
    this.category = category;
  }

  void setBedrooms(int bedrooms) {
    this.bedrooms = bedrooms;
  }

  void setBathrooms(int bathrooms) {
    this.bathrooms = bathrooms;
  }

  void setOwner(String owner) {
    this.owner = owner;
  }

  void setAmenities(List<dynamic> amenities) {
    this.amenities = amenities;
  }

  Listing build() {
    return Listing._builder(this);
  }
}
