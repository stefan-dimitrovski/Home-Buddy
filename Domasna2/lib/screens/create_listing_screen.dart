import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:home_buddy_app/models/address_model.dart';
import 'package:home_buddy_app/models/listing_model.dart';
import 'package:home_buddy_app/models/listing_type.dart';
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

  final Location _location = Location();
  late List<Placemark> _placemark;
  late LocationData _locationData;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  _createListing() async {
    //Refactor firebase with singleton
    //TODO: Finish image storage and fix amenities

    final listingsRef = firestore.collection('listings').withConverter<Listing>(
          fromFirestore: (snapshot, _) => Listing.fromJson(snapshot.data()!),
          toFirestore: (listing, _) => listing.toJson(),
        );

    await listingsRef.add(Listing(
      title: myTitleController.text,
      phone: myPhoneController.text,
      description: myDescriptionController.text,
      price: double.parse(myPriceController.text),
      category: ListingType.values[_categorySelected],
      bedrooms: _bedrooms,
      bathrooms: _bathrooms,
      images: [],
      address: Address(
        street: _placemark[0].street!,
        city: _placemark[0].locality!,
        lat: _locationData.latitude!,
        lng: _locationData.longitude!,
        country: _placemark[0].country!,
        zipcode: _placemark[0].postalCode!,
      ),
      owner: auth.currentUser!.uid,
    ));

    // .then((doc) => {
    //       //upload images
    //       storage.ref().child('listings/${doc.id}').listAll().then((list) {
    //         for (var i = 0; i < list.items.length; i++) {
    //           list.items[i].getDownloadURL().then((url) {
    //             firestore.collection('listings').doc(doc.id).update({
    //               'images': FieldValue.arrayUnion([url]),
    //             });
    //           });
    //         }
    //       }),
    //     });

    Navigator.pop(context);
  }

  _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();

    _placemark = await placemarkFromCoordinates(
        _locationData.latitude!, _locationData.longitude!);

    myLocationController.text =
        "${_placemark[0].street}, ${_placemark[0].country}, ${_placemark[0].locality} , ${_placemark[0].postalCode}";
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
                    color: Colors.black54,
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
                    color: Colors.black54,
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
