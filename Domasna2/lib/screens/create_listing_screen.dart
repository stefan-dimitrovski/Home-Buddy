import 'package:flutter/material.dart';

class CreateListing extends StatefulWidget {
  CreateListing({Key? key}) : super(key: key);

  @override
  _CreateListingState createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Listing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Create Listing'),
      ),
    );
  }
}
