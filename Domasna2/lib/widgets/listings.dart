import 'package:flutter/material.dart';
import 'package:home_buddy_app/models/address_model.dart';
import 'package:home_buddy_app/models/listing_model.dart';
import 'package:home_buddy_app/models/listing_type.dart';
import 'package:home_buddy_app/screens/details_screen.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
];

class Listings extends StatefulWidget {
  var listing = Listing(
      "1",
      "Awesome place to rest",
      "0771234567",
      Address(
          street: "123 Fake Street",
          country: "United Kingdom",
          city: "London",
          zipcode: "SW1A 1AA",
          lat: 45.72021,
          lng: 99.66472),
      "Intresting place",
      50,
      imgList,
      ListingType.apartment,
      2,
      3);

  Listings({Key? key}) : super(key: key);

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) => ListTile(
        title: Card(
          elevation: 5,
          child: InkWell(
            onTap: () {
              // print("tapped $index");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Details(
                      listing: widget.listing,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.room_outlined,
                            color: Colors.black45,
                          ),
                          Text(widget.listing.address.city),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.apartment_outlined,
                            color: Colors.black45,
                          ),
                          Text(widget.listing.type.toShortString()),
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
                            widget.listing.getImages[0],
                            fit: BoxFit.cover,
                            width: 200,
                            height: 100,
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("\$${widget.listing.price}"),
                          const Text('/ night'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.listing.bedrooms} bed • ${widget.listing.bathrooms} bath',
                            style: const TextStyle(color: Colors.black26),
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
    );
  }
}
