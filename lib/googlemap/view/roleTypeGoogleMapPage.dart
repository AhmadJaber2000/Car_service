import 'package:flutter/material.dart';

import 'googleMapView.dart';

class RoleTypeGoogleMapPage extends StatefulWidget {
  final String userType;
  final String roleType;
  const RoleTypeGoogleMapPage({Key? key, required this.userType, required this.roleType}) : super(key: key);

  @override
  State<RoleTypeGoogleMapPage> createState() => _RoleTypeGoogleMapPageState();
}

class _RoleTypeGoogleMapPageState extends State<RoleTypeGoogleMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: GoogleMapView(widget.roleType),
    );
  }

  AppBar HomeAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(
        widget.userType,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}
