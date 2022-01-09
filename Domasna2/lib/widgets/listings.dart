import 'package:flutter/material.dart';
import 'package:home_buddy_app/models/address_model.dart';
import 'package:home_buddy_app/models/listing_model.dart';
import 'package:home_buddy_app/models/listing_type.dart';
import 'package:home_buddy_app/screens/details_screen.dart';

final List<String> imgList = [
  'https://news.airbnb.com/wp-content/uploads/sites/4/2019/06/PJM020719Q202_Luxe_WanakaNZ_LivingRoom_0264-LightOn_R1.jpg?fit=2500%2C1666',
  'https://media.cntraveler.com/photos/5d112d50c4d7bd806dbc00a4/3:2/w_2250,h_1500,c_limit/airbnb%20luxe.jpg',
  'https://thejetset.com/wp-content/uploads/2021/12/airbnb-new-years-eve-party.jpg',
  'https://media.cntraveler.com/photos/5ea354e75e5dc70008d054b9/16:9/w_2560%2Cc_limit/24912891-australia-3.jpg',
  'https://www.fodors.com/wp-content/uploads/2019/08/airbnb-hero-.jpg',
  'https://www.gannett-cdn.com/presto/2021/06/09/USAT/036e5af9-e33d-412a-ad2e-709666d5cd4f-Live_Anywhere_Airbnb_11.jpg',
];

class Listings extends StatefulWidget {
  var listing = Listing(
      "1",
      "Cozy cottages near Skadar Lake 1",
      "0771234567",
      Address(
          street: "123 Fake Street",
          country: "Serbia",
          city: "Zlatibor",
          zipcode: "SW1A 1AA",
          lat: 43.722597,
          lng: 19.703932),
      "Bungalows are located on the old road of King Nikola, from Virpazar to Crnojevica River. The cottages are located 15km from the airport (15 min drive), 15km from the sea (15 min drive) and 5km from Lake Skadar. Around the bungalows there is a place to relax, a place to barbecue and a small summer house exclusively for guests, a garden, a vineyard and a beehive. The bungalows are located on the Dabovic family estate, which has been producing domestic wine, honey and brandy for years. Guests will be able to enjoy our products.",
      45,
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
