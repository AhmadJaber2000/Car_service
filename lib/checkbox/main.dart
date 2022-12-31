import 'package:Car_service/model/user.dart';
import 'package:Car_service/tools/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<String> items = [
  '8:00AM-10:00AM',
  '10:00AM-12:00PM',
  '12:00PM-2:00PM',
  '2:00PM-4:00PM',
  '4:00PM-6:00PM',
  '6:00PM-8:00PM',
  'Japanese Cars',
  'Korean Cars',
  'American Cars',
  'Germany Cars',
  'Diesel',
  'petrol',
  'hybrid',
];
List<IconData> itemsCheck = [
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline,
  Icons.check_circle_outline
];

class RoundCheckBox extends StatefulWidget {
  const RoundCheckBox({super.key, required this.user});

  final User user;

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter CheckBoxes"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(items[index]),
                  leading: IconButton(
                      icon: Icon(itemsCheck[index]),
                      onPressed: () {
                        setState(() {
                          if (itemsCheck[index] == Icons.check_circle_outline) {
                            itemsCheck[index] = Icons.check_circle;
                            checkbox(widget.user.userID, items[index]);
                          } else
                            itemsCheck[index] = Icons.check_circle_outline;
                        });
                      }));
            }));
  }

  void checkbox(String userId, String items) {
    FirebaseFirestore.instance
        .collection("checkbox")
        .add({'userId': userId, "items": items});
  }
}
