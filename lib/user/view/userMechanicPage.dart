import 'package:flutter/material.dart';

import '../../List_User/ListUserByRate.dart';
import '../../PartShops/screen/HomeScreen.dart';
import '../../googlemap/view/roleTypeGoogleMapPage.dart';
import '../../model/roleType.dart';
import '../../smarthome/Model/homeinfodata.dart';
import '../../tools/constants.dart';
import 'drawer.dart';

class UserMechanicPage extends StatefulWidget {
  const UserMechanicPage({Key? key}) : super(key: key);

  @override
  State<UserMechanicPage> createState() => _UserMechanicPageState();
}

class _UserMechanicPageState extends State<UserMechanicPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<HomeInfoModel> homeInfoData = HomeInfoData().infoData;

  @override
  void initState() {
    _tabController =
        new TabController(length: homeInfoData.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      drawer: const DrawerView(),
      appBar: (AppBar(
        brightness: Brightness.light,
        backgroundColor: Color(0xff004c4c),
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      )),
      body: Container(
        color: Color(0xffb2d8d8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              const Text("What are you looking for ?",
                  style: TextStyle(
                      color: Color(0xff008080),
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 30,
              ),
              buildContainer("Mechanics", RoleType.mechanic,
                  "assets/images/car-repair-illustration-concept-vector-fococlipping-standard.png"),
              buildContainer("Trucks", RoleType.truck,
                  "assets/images/towing-fococlipping-standard.png"),
              buildContainerShop()
            ],
          ),
        ),
      ),
    );
  }

  buildContainer(String title, String type, String image) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xff006666), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff006666),
              Color(0xff004c4c),
            ],
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Image.asset(
                image,
                height: 100,
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RoleTypeGoogleMapPage(
                                      userType: title,
                                      service: "location",
                                      roleType: type,
                                    )));
                      },
                      child: buildChoice(
                          "location",
                          const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ))),
                ),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListMechanicByRate(
                                        roletype: type,
                                      )));
                        },
                        child: buildChoice(
                            "Popular ${type}",
                            const Icon(
                              Icons.people,
                              color: Color(0xff317873),
                            )))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildContainerShop() {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff006666),
              Color(0xff004c4c),
            ],
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Part Shops',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Image.asset(
                "assets/images/logo-for-auto-parts-store-vector-23900646-fococlipping-standard.png",
                height: 100,
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(
                //   child: GestureDetector(
                //       onTap: () {
                //         // Navigator.push(
                //         //     context,
                //         //     MaterialPageRoute(
                //         //         builder: (context) => RoleTypeGoogleMapPage(
                //         //               userType: title,
                //         //               service: "location",
                //         //               roleType: type,
                //         //             )));
                //       },
                //       child: buildChoice(
                //           "location",
                //           const Icon(
                //             Icons.location_pin,
                //             color: Colors.red,
                //           ))),
                // ),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PartScreen()));
                        },
                        child: buildChoice(
                            "Popular Shop",
                            const Icon(
                              Icons.car_repair,
                              color: Color(0xff317873),
                            )))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildChoice(String title, Icon icons) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.black38)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                  color: Color(0xff008080),
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          icons
        ],
      ),
    );
  }
}
