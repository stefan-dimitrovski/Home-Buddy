import 'package:flutter/material.dart';
import 'package:home_buddy_app/screens/filtered_listings_screen.dart';

class Filter extends StatefulWidget {
  final ValueChanged<String> parentAction;

  const Filter({Key? key, required this.parentAction}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  int _categorySelected = -1;
  double _priceSelected = 0.0;
  int _bedrooms = 0;
  int _bathrooms = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        actions: [
          IconButton(
            constraints: const BoxConstraints(minWidth: 60),
            icon: const Text('RESET'),
            onPressed: () {
              setState(() {
                _categorySelected = -1;
                _priceSelected = 0.0;
                _bedrooms = 0;
                _bathrooms = 0;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                ChoiceChip(
                  clipBehavior: Clip.hardEdge,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  label: const Text("House"),
                  selected: _categorySelected == 0,
                  onSelected: (value) {
                    setState(() {
                      _categorySelected = value ? 0 : -1;
                    });
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  label: const Text('Villa'),
                  selected: _categorySelected == 1,
                  onSelected: (value) {
                    setState(() {
                      _categorySelected = value ? 1 : -1;
                    });
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  label: const Text('Apartment'),
                  selected: _categorySelected == 2,
                  onSelected: (value) {
                    setState(() {
                      _categorySelected = value ? 2 : -1;
                    });
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Price Range",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Slider(
              value: _priceSelected,
              min: 0.0,
              max: 1000.0,
              divisions: 100,
              label: '\$${_priceSelected.round()}',
              onChanged: (value) {
                setState(() {
                  _priceSelected = value;
                });
              },
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Completeness",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Bedrooms"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (_bedrooms > 0) {
                                _bedrooms--;
                              }
                            });
                          },
                        ),
                        Text(_bedrooms.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _bedrooms++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Bathrooms"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (_bathrooms > 0) {
                                _bathrooms--;
                              }
                            });
                          },
                        ),
                        Text(_bathrooms.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _bathrooms++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(40, 0, 40, 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // widget.parentAction(
                    //   '$_categorySelected ${_priceSelected.round()} $_bedrooms $_bathrooms',
                    // );

                    // Navigator.pop(
                    //   context,
                    // {
                    //   'categorySelected': _categorySelected,
                    //   'priceSelected': _priceSelected,
                    //   'bedrooms': _bedrooms,
                    //   'bathrooms': _bathrooms,
                    // }
                    // );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilteredListingScreen(items: {
                                  'categorySelected': _categorySelected,
                                  'priceSelected': _priceSelected.round(),
                                  'bedrooms': _bedrooms,
                                  'bathrooms': _bathrooms,
                                })));
                  },
                  child: const Text(
                    'Submit',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
