import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy_app/models/listing_model.dart';
import 'package:home_buddy_app/models/listing_type.dart';
import 'package:home_buddy_app/widgets/listings.dart';

import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ValueNotifier<List<QueryDocumentSnapshot<Listing>>> listingsResult =
      ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    getFavoriteListings();
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          getFavoriteListings();
        });
      },
      child: ValueListenableBuilder<List<QueryDocumentSnapshot<Listing>>?>(
        valueListenable: listingsResult,
        builder: (context, value, child) {
          return listingsResult.value.isNotEmpty
              ? ListView.builder(
                  itemCount: listingsResult.value.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                final item = listingsResult.value[index];
                                return Details(
                                  listing: item.data(),
                                  listingId: item.id,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          margin: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.room_outlined,
                                        color: Colors.black45,
                                      ),
                                      Text(listingsResult.value[index]
                                          .data()
                                          .title),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.apartment_outlined,
                                        color: Colors.black45,
                                      ),
                                      Text(listingsResult.value[index]
                                          .data()
                                          .category
                                          .toShortString()),
                                    ],
                                  ),
                                ],
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      // imgList[0],
                                      // 'https://media.cntraveler.com/photos/5d112d50c4d7bd806dbc00a4/3:2/w_2250,h_1500,c_limit/airbnb%20luxe.jpg',
                                      listingsResult.value[index]
                                              .data()
                                              .images
                                              .isNotEmpty
                                          ? listingsResult.value[index]
                                              .data()
                                              .images[0]
                                              .toString()
                                          : 'https://media.cntraveler.com/photos/5d112d50c4d7bd806dbc00a4/3:2/w_2250,h_1500,c_limit/airbnb%20luxe.jpg',
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          "\$${listingsResult.value[index].data().price}"),
                                      const Text('/ night'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${listingsResult.value[index].data().bedrooms} bed • ${listingsResult.value[index].data().bathrooms} bath',
                                        style: const TextStyle(
                                            color: Colors.black26),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const Text("No listings found");
        },
      ),
    );
  }

  void getFavoriteListings() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    // List<QueryDocumentSnapshot<Listing>>? items;
    FirebaseFirestore.instance
        .collection("userData")
        .doc(uid)
        .get()
        .then((docSnapshot) async {
      final favoriteIds = List<String>.from(docSnapshot.data()!["favorite"]);

      await FirebaseFirestore.instance
          .collection("listings")
          .where(FieldPath.documentId, whereIn: favoriteIds)
          .withConverter<Listing>(
            fromFirestore: (snapshot, _) => Listing.fromJson(snapshot.data()!),
            toFirestore: (listing, _) => listing.toJson(),
          )
          .get()
          .then((value) {
        listingsResult.value = value.docs;
      });
    });
  }
}
