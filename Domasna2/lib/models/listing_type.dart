enum ListingType {
  house,
  villa,
  apartment,
}

extension ListingTypeExtension on ListingType {
  String toShortString() {
    switch (this) {
      case ListingType.house:
        return 'House';
      case ListingType.villa:
        return 'Villas';
      case ListingType.apartment:
        return 'Apartment';
    }
  }
}
