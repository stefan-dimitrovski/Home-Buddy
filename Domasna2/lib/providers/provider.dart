import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy_app/models/listing_model.dart';

class ParentProvider extends InheritedWidget {
  final Widget child;
  final List<QueryDocumentSnapshot<Listing>> listings;

  ParentProvider({required this.child, required this.listings})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static ParentProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ParentProvider>();
}
