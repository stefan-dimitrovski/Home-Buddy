import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  static final List<Widget> _widgetOptions = <Widget>[
    const Listings(),
    const ExploreScreen(),
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
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Filter(),
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Startup())),
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
