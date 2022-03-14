import 'package:flutter/material.dart';
import 'package:home_buddy_app/models/listing_type.dart';
import 'package:home_buddy_app/providers/provider.dart';
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
  const Listings({Key? key}) : super(key: key);

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  Widget build(BuildContext context) {
    final listingsResult = ParentProvider.of(context)?.listings;

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: listingsResult != null
          ? ListView.builder(
              itemCount: listingsResult.length,
              itemBuilder: (context, index) => ListTile(
                title: Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Details(
                              listing: listingsResult[index].data(),
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
                                  Text(listingsResult[index].data().title),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.apartment_outlined,
                                    color: Colors.black45,
                                  ),
                                  Text(listingsResult[index]
                                      .data()
                                      .category
                                      .toShortString()),
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
                                  imgList[0],
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 100,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                      "\$${listingsResult[index].data().price}"),
                                  const Text('/ night'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${listingsResult[index].data().bedrooms} bed • ${listingsResult[index].data().bathrooms} bath',
                                    style:
                                        const TextStyle(color: Colors.black26),
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
            )
          : const Text("No listings found"),
    );
  }
}
