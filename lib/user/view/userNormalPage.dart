import 'package:Car_service/List_User/ListUserByRate.dart';
import 'package:flutter/material.dart';
import '../../googlemap/service/location_service.dart';
import '../../model/roleType.dart';
import '../../tools/constants.dart';
import 'drawer.dart';
import '../../googlemap/view/roleTypeGoogleMapPage.dart';

class UserNormalPage extends StatefulWidget {
  const UserNormalPage({Key? key}) : super(key: key);

  @override
  State<UserNormalPage> createState() => _UserNormalPageState();
}

class _UserNormalPageState extends State<UserNormalPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("What are you looking for ?",
              style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 30,
          ),
          buildContainer("Mechanics", RoleType.mechanic,
              "assets/images/v-fococlipping-standard.png"),
          buildContainer("Trucks", RoleType.truck,
              "assets/images/mechanic-1464584-1239754-fococlipping-standard.png"),
        ],
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
              Colors.white,
              Colors.cyan,
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
              ),
              const Icon(
                Icons.add_call,
                color: Colors.cyan,
                size: 20,
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
                            Icons.location_on_sharp,
                            color: Colors.blue,
                          ))),
                ),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListMechanicByRate()));
                        },
                        child: buildChoice(
                            "Rate",
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
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
                  color: Colors.cyan,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          icons
        ],
      ),
    );
  }
}
