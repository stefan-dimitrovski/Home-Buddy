enum ListingType {
  apartment,
  house,
  villa,
}

extension ListingTypeExtension on ListingType {
  String toShortString() {
    switch (this) {
      case ListingType.apartment:
        return 'Apartment';
      case ListingType.house:
        return 'House';
      case ListingType.villa:
        return 'Villas';
    }
  }
}
