import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:home_buddy_app/screens/image_picker_screen.dart';
import 'package:home_buddy_app/widgets/amenities_list.dart';
import 'package:location/location.dart';

class CreateListing extends StatefulWidget {
  CreateListing({Key? key}) : super(key: key);

  @override
  _CreateListingState createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListing> {
  final _formKey = GlobalKey<FormState>();
  final myTitleController = TextEditingController();
  final myPhoneController = TextEditingController();
  final myLocationController = TextEditingController();
  final myDescriptionController = TextEditingController();
  final myPriceController = TextEditingController();
  int _categorySelected = -1;
  int _bedrooms = 0;
  int _bathrooms = 0;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  _createListing() {
    //TODO: FINISH THIS
    firestore.collection('listings').add({
      'title': myTitleController.text,
      'phone': myPhoneController.text,
      'location': myLocationController.text,
      'description': myDescriptionController.text,
      'price': myPriceController.text,
      'category': _categorySelected,
      'bedrooms': _bedrooms,
      'bathrooms': _bathrooms,
      'amenities': [],
      'images': [],
      'owner': auth.currentUser?.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
  }

  _getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    // print(_locationData);

    List<Placemark> placemark = await placemarkFromCoordinates(
        _locationData.latitude!, _locationData.longitude!);

    // print(placemark);
    myLocationController.text =
        "${placemark[0].street}, ${placemark[0].country}, ${placemark[0].locality} , ${placemark[0].postalCode}";
  }

  @override
  void dispose() {
    myTitleController.dispose();
    myPhoneController.dispose();
    myLocationController.dispose();
    myDescriptionController.dispose();
    myPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Listing'),
        actions: [
          IconButton(
            tooltip: "Create Listing",
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (myLocationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text('Please enter a location'),
                    ),
                  );
                } else {
                  _createListing();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text('Processing...'),
                    ),
                  );
                }
              } else {
                return;
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TITLE
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: TextFormField(
                  controller: myTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    } else if (value.contains(RegExp(r'[^a-zA-Z0-9\s]'))) {
                      return 'Title must be alphanumeric';
                    } else if (value.contains(RegExp(r'\s\s+'))) {
                      return 'Title must not contain consecutive spaces';
                    } else if (value.length < 3 || value.length > 50) {
                      return 'Title must be between 3 and 50 characters';
                    }
                    return null;
                  },
                ),
              ),
              //PHONE
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: TextFormField(
                  controller: myPhoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Can\'t be empty';
                    } else if (value.contains(RegExp(r'[^0-9\s]'))) {
                      return 'Phone number must be numeric';
                    } else if (value.length < 5 || value.length > 15) {
                      return 'Phone number must be between 5 and 15 digits';
                    }
                    return null;
                  },
                ),
              ),
              //LOCATION
              Container(
                padding: const EdgeInsets.fromLTRB(15, 5, 25, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 270,
                      child: TextFormField(
                        maxLines: null,
                        controller: myLocationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          enabled: false,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.my_location),
                      tooltip: "Get current location",
                      onPressed: () {
                        _getLocation();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Getting Location ...'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              //DESCRIPTION
              Container(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                child: TextFormField(
                  controller: myDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                ),
              ),
              //BATHROOMS AND BEDROOMS COUNT
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
              //TYPE OF PROPERTY
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
              //AMENITIES
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: const Text(
                  "Amenities:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                height: 100,
                child: const AmenitiesList(),
              ),
              //PRICE
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 150, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        controller: myPriceController,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Can\'t be empty';
                          } else if (value.contains(RegExp(r'[^0-9\.]'))) {
                            return 'Not numeric';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: const Text(
                        "/night",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              //IMAGES
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                child: const Text(
                  "Pictures:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: const ImageSelect(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
