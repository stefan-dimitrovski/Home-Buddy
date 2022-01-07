import 'package:flutter/material.dart';
import 'package:home_buddy_app/widgets/amenities_list.dart';
import 'package:home_buddy_app/widgets/image_carousel.dart';
import 'package:home_buddy_app/widgets/map.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class Details extends StatefulWidget {
  Details({Key? key}) : super(key: key);

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
            Carousel(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text('Title'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text('Price'),
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
                      child: const Text('Street'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text('City'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text('Country'),
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
                      child: const Text('Phone'),
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
                      padding: const EdgeInsets.all(10),
                      child: const Text('Description'),
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
                Container(
                  margin: const EdgeInsets.only(left: 50, bottom: 120),
                  padding: const EdgeInsets.all(16),
                  child: Map(),
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
