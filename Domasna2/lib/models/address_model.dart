class Address {
  String street;
  String country;
  String city;
  String zipcode;
  double lat;
  double lng;

  Address({
    required this.street,
    required this.country,
    required this.city,
    required this.zipcode,
    required this.lat,
    required this.lng,
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

  double getLat() {
    return lat;
  }

  double getLng() {
    return lng;
  }

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        country: json["country"],
        city: json["city"],
        zipcode: json["zipcode"],
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['country'] = country;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
