import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy_app/models/listing_model.dart';
import 'package:home_buddy_app/providers/provider.dart';
import 'package:home_buddy_app/screens/create_listing_screen.dart';
import 'package:home_buddy_app/screens/explore_screen.dart';
import 'package:home_buddy_app/screens/favorites_screen.dart';
import 'package:home_buddy_app/screens/filter_screen.dart';
import 'package:home_buddy_app/screens/startup_screen.dart';
import 'package:home_buddy_app/widgets/drawer.dart';
import 'package:home_buddy_app/widgets/listings.dart';

class HomePage extends StatefulWidget {
  String title;
  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final listingsRef =
      firestore.collection('listings').withConverter<Listing>(
            fromFirestore: (snapshot, _) => Listing.fromJson(snapshot.data()!),
            toFirestore: (listing, _) => listing.toJson(),
          );
  List<QueryDocumentSnapshot<Listing>> listings = [];

  final List<Widget> _widgetOptions = <Widget>[
    const Listings(),
    const FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        widget.title = "Explore";
      } else if (_selectedIndex == 2) {
        widget.title = "Favorite";
      } else {
        widget.title = "Home";
      }
    });
  }

  _filterListings(String query) {
    var queryList = query.split(' ');

    // TODO - needs fixes, not good enough
    if (int.parse(query[0]) != -1) {
      listingsRef
          .where('category', isEqualTo: int.parse(queryList[0].trim()))
          .get()
          .then((value) => value.docs)
          .then((value) {
        setState(() {
          listings = value;
        });
      });
    } else if (int.parse(query[1]) != -1) {
      listingsRef
          .where('price', isLessThanOrEqualTo: int.parse(queryList[1].trim()))
          .get()
          .then((value) => value.docs)
          .then((value) {
        setState(() {
          listings = value;
        });
      });
    } else if (int.parse(query[2]) != -1) {
      listingsRef
          .where('beds', isEqualTo: int.parse(queryList[2].trim()))
          .get()
          .then((value) => value.docs)
          .then((value) {
        setState(() {
          listings = value;
        });
      });
    } else if (int.parse(query[3]) != -1) {
      listingsRef
          .where('baths', isEqualTo: int.parse(queryList[3].trim()))
          .get()
          .then((value) => value.docs)
          .then((value) {
        setState(() {
          listings = value;
        });
      });
    } else {
      listingsRef.get().then((value) => value.docs).then((value) {
        setState(() {
          listings = value;
        });
      });
    }
  }

  _fetchListings() {
    final listingsRef = firestore.collection('listings').withConverter<Listing>(
          fromFirestore: (snapshot, _) => Listing.fromJson(snapshot.data()!),
          toFirestore: (listing, _) => listing.toJson(),
        );

    listingsRef.get().then((value) => value.docs).then((value) {
      setState(() {
        listings = value;
      });
    });
  }

  @override
  void initState() {
    _fetchListings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: DrawerApp(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            label: 'Favorites',
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            tooltip: "Filter",
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Filter(parentAction: _filterListings),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            tooltip: "Create Listing",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateListing(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: "Logout",
            onPressed: () async => {
              await FirebaseAuth.instance.signOut(),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Startup(),
                ),
              ),
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ParentProvider(
        listings: listings,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
