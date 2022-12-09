

import 'package:Car_service/model/roleType.dart';
import 'package:Car_service/user/view/userMechanicPage.dart';
import 'package:flutter/material.dart';

import '../../user/view/userNormalPage.dart';
import '../../user/view/drawer.dart';
import '../../user/view/userTrackPage.dart';

class Home extends StatelessWidget {
  final String type;
  const Home({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer:const DrawerView(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColorLight,
        title: const Text("Home",style: TextStyle(
            color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: type==RoleType.user?
      const UserNormalPage():
      type==RoleType.mechanic?
      const UserMechanicPage():
      type==RoleType.track?
      const UserTrackPage():
      Container()
    );
  }
}
