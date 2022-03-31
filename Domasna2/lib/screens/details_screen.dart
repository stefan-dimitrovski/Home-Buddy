import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy_app/models/listing_model.dart';
import 'package:home_buddy_app/widgets/amenities_list.dart';
import 'package:home_buddy_app/widgets/image_carousel.dart';
import 'package:home_buddy_app/widgets/map.dart';

class Details extends StatefulWidget {
  Listing listing;
  String listingId;
  Details({Key? key, required this.listing, required this.listingId})
      : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var isFavorite = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    var documentRef =
        FirebaseFirestore.instance.collection('userData').doc(userId);
    documentRef.get().then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        final favorite = await documentSnapshot.get('favorite') as List;
        isFavorite = favorite.contains(widget.listingId);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: !isFavorite
                ? const Icon(Icons.favorite_outline)
                : const Icon(Icons.favorite),
            onPressed: () {
              var documentRef =
                  FirebaseFirestore.instance.collection('userData').doc(userId);
              documentRef.get().then((DocumentSnapshot documentSnapshot) async {
                if (documentSnapshot.exists) {
                  var favorite = await documentSnapshot.get('favorite') as List;

                  if (!isFavorite) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Added to favorites'),
                      ),
                    );
                    favorite.add(widget.listingId);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Removed from favorites'),
                      ),
                    );
                    favorite.remove(widget.listingId);
                  }

                  documentRef.update({'favorite': favorite});
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Carousel(listing: widget.listing),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.97,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Text(widget.listing.title),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Text("\$${widget.listing.price} / night"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.97,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: const [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 16),
                                  Text('Address'),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(widget.listing.address.street),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(widget.listing.address.city),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(widget.listing.address.country),
                            ),
                            const Divider(),
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Map(
                                listing: widget.listing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.97,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: const [
                                  Icon(Icons.phone),
                                  SizedBox(width: 16),
                                  Text('Phone'),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(widget.listing.phone),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: const [
                                Icon(Icons.info),
                                SizedBox(width: 16),
                                Text('Details'),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.97,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              widget.listing.description,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: const [
                          Icon(Icons.sell),
                          SizedBox(width: 16),
                          Text('Amenities'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: AmenitiesList(
                passAmenityToParentCallback: (type, add) {
                  // noop
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
