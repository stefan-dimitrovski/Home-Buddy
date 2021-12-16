import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
        title: const Text('Explore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () async => {await FirebaseAuth.instance.signOut()},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      //TODO: Create a seperate widget for this
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          title: Card(
            elevation: 5,
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
                        children: const [
                          Icon(
                            Icons.room_outlined,
                            color: Colors.black45,
                          ),
                          Text('London'),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.apartment_outlined,
                            color: Colors.black45,
                          ),
                          Text('Apartment'),
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
                            'https://picsum.photos/500?image=$index',
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
                        children: const [
                          Text("\$205"),
                          Text('/ night'),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            '1 bed • 1 bath',
                            style: TextStyle(color: Colors.black26),
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
