class Address {
  String street;
  String country;
  String city;
  String zipcode;
  String lat;
  String long;

  Address({
    required this.street,
    required this.country,
    required this.city,
    required this.zipcode,
    required this.lat,
    required this.long,
  });

  String getStreet() {
    return street;
  }

  String getCountry() {
    return country;
  }

  String getCity() {
    return city;
  }

  String getZipcode() {
    return zipcode;
  }

  String getLat() {
    return lat;
  }

  String getLong() {
    return long;
  }

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        country: json["country"],
        city: json["city"],
        zipcode: json["zipcode"],
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['country'] = country;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
