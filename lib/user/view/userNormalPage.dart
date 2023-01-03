import 'package:Car_service/ChatIn/api/apis.dart';
import 'package:Car_service/List_User/ListUserByRate.dart';
import 'package:Car_service/authenticate/service/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../googlemap/service/location_service.dart';
import '../../model/roleType.dart';
import '../../model/user.dart';
import '../../smarthome/Model/homeinfodata.dart';
import '../../tools/constants.dart';
import 'drawer.dart';
import '../../googlemap/view/roleTypeGoogleMapPage.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserNormalPage extends StatefulWidget {
  const UserNormalPage({Key? key}) : super(key: key);

  @override
  State<UserNormalPage> createState() => _UserNormalPageState();
}

class _UserNormalPageState extends State<UserNormalPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<HomeInfoModel> homeInfoData = HomeInfoData().infoData;
  static auth.User? get user => auth.FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _tabController =
        new TabController(length: homeInfoData.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Stack(
      children: [
        Scaffold(
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
          body: SingleChildScrollView(
            child: Container(
              color: Color(0xffb2d8d8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          child: Align(
                        child: Image.asset(
                          'assets/images/StartServiceIMG-transformed.jpeg',
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "What are you looking for ?",
                    style: TextStyle(
                        color: Color(0xff008080),
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      buildContainer("Mechanics", RoleType.mechanic,
                          "assets/images/car-repair-illustration-concept-vector-fococlipping-standard.png"),
                      buildContainer("Trucks", RoleType.truck,
                          "assets/images/towing-fococlipping-standard.png"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Color(0xffb2d8d8),
        )
      ],
    );
  }

  Future<User?> readUser() async {
    final docUser =
        FirebaseFirestore.instance.collection(usersCollection).doc(user!.uid);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
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
                          // if (RoleType.mechanic == User())
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => ListMechanicByRate(
                                        roletype: type,
                                      )));
                        },
                        child: buildChoice(
                            "Popular${type}",
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
