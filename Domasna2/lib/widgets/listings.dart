import 'package:flutter/material.dart';

class Listings extends StatefulWidget {
  const Listings({Key? key}) : super(key: key);

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(
        title: Card(
          elevation: 5,
          child: InkWell(
            onTap: () {
              // print("tapped $index");
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
