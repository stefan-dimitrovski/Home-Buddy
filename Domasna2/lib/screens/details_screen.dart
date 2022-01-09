import 'package:flutter/material.dart';
import 'package:home_buddy_app/models/listing_model.dart';
import 'package:home_buddy_app/widgets/amenities_list.dart';
import 'package:home_buddy_app/widgets/image_carousel.dart';
import 'package:home_buddy_app/widgets/map.dart';

class Details extends StatefulWidget {
  Listing listing;
  Details({Key? key, required this.listing}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var isFavorite = false;
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
              !isFavorite
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Added to favorites'),
                      ),
                    )
                  : ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Removed from favorites'),
                      ),
                    );
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Carousel(listing: widget.listing),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
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
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Map(
                        listing: widget.listing,
                      ),
                    ),
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
                      width: MediaQuery.of(context).size.width * 1,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.listing.description,
                        textAlign: TextAlign.justify,
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
            const SizedBox(
              height: 100,
              width: double.infinity,
              child: AmenitiesList(),
            ),
          ],
        ),
      ),
    );
  }
}
