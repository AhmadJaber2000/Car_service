import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../services/mapview.dart';

class CallMechanic extends StatefulWidget {
  const CallMechanic({Key? key}) : super(key: key);

  @override
  State<CallMechanic> createState() => _CallMechanicState();
}

class _CallMechanicState extends State<CallMechanic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: GoogleMapView(RolType.mechanic),
    );
  }

  AppBar HomeAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      title: Text("Call Mechanic", style: TextStyle(color: Color(0xffeeb61a))),
      centerTitle: true,
    );
  }
}
