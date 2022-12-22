import 'package:flutter/material.dart';

import '../../tools/constants.dart';
import 'Constants.dart';

class cardbtn extends StatelessWidget {
  final txt;
  final icon;

  const cardbtn({Key? key, required this.txt, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 120,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.5),

          blurRadius: 2,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ], color: black, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            backgroundColor: black,
            radius: 30,
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            txt,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
