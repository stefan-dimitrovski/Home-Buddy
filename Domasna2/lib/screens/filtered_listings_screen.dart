import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy_app/models/listing_model.dart';
import 'package:home_buddy_app/models/listing_type.dart';

import 'details_screen.dart';

class FilteredListingScreen extends StatelessWidget {
  Map<String, int> items;
  FilteredListingScreen({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(items);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search result:'),
      ),
      body: Center(
          child: ShowSearchResult(
        items: items,
      )),
    );
  }
}

class ShowSearchResult extends StatefulWidget {
  Map<String, int> items;
  ShowSearchResult({Key? key, required this.items}) : super(key: key);

  @override
  State<ShowSearchResult> createState() => _ShowSearchResultState();
}

class _ShowSearchResultState extends State<ShowSearchResult> {
  final ValueNotifier<List<QueryDocumentSnapshot<Listing>>> listingsResult =
      ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    filterItems(widget.items);
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          filterItems(widget.items);
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

  void filterItems(Map<String, int> items) {
    print(items);
    print(items['bedrooms']);
    FirebaseFirestore.instance
        .collection("listings")
        .where("category",
            isEqualTo:
                items['categorySelected'] != -1 ? items['categorySelected'] : 0)
        .withConverter<Listing>(
          fromFirestore: (snapshot, _) => Listing.fromJson(snapshot.data()!),
          toFirestore: (listing, _) => listing.toJson(),
        )
        .get()
        .then((value) {
      List<QueryDocumentSnapshot<Listing>> temp = [];
      value.docs.forEach((element) {
        final data = element.data();
        if (data.bathrooms >= items["bathrooms"]! &&
            data.bedrooms >= items["bedrooms"]! &&
            data.price >= items["priceSelected"]!) {
          temp.add(element);
        }
      });

      listingsResult.value = temp;
    });
  }
}
