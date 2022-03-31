import 'package:flutter/material.dart';

class Amenity extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function(String type, bool add) callback;

  const Amenity(
      {Key? key,
      required this.icon,
      required this.title,
      required this.callback})
      : super(key: key);

  @override
  _AmenityState createState() => _AmenityState();
}

class _AmenityState extends State<Amenity> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.callback(widget.title, isSelected);
        });
        // print('Tapped ${widget.title}');
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 20,
              color: isSelected ? Colors.black : Colors.grey,
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
