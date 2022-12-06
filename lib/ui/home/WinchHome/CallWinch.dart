import 'package:Car_service/constants.dart';
import 'package:Car_service/services/mapview.dart';
import 'package:flutter/material.dart';

class CallWinch extends StatefulWidget {
  const CallWinch({Key? key}) : super(key: key);

  @override
  State<CallWinch> createState() => _CallWinchState();
}

class _CallWinchState extends State<CallWinch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: GoogleMapView(RoleType.winch),
    );
  }

  AppBar HomeAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      title: Text(
        "Call Winch",
        style: TextStyle(color: Color(0xffeeb61a)),
      ),
      centerTitle: true,
    );
  }
}
