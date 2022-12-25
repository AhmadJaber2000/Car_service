import 'package:Car_service/AdminPage/Screens/DeletUser.dart';
import 'package:Car_service/AdminPage/Screens/Home/urlogohere.dart';
import 'package:Car_service/AdminPage/Screens/ListAllUser.dart';
import 'package:Car_service/ChatIn/screens/chat_screen.dart';
import 'package:Car_service/List_User/ListUserByRate.dart';
import 'package:Car_service/model/roleType.dart';
import 'package:Car_service/tools/constants.dart';
import 'package:Car_service/user/view/drawer.dart';
import 'package:flutter/material.dart';

import '../../components/Constants.dart';
import '../../components/cardbtn.dart';
import '../Analytic.dart';

class AdminRole extends StatelessWidget {
  const AdminRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerView(),
      appBar: AppBar(
        title: Text("ADMIN"),
        centerTitle: true,
        backgroundColor: primecolor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListAllUser()))
                    },
                    child: const cardbtn(
                      txt: "Manage",
                      icon: Icons.manage_accounts,
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DeleteUser()))
                    },
                    child: const cardbtn(
                      txt: "Block User",
                      icon: Icons.block,
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => commentMange()))
                    },
                    child: const cardbtn(
                      txt: "Analytics",
                      icon: Icons.analytics_rounded,
                    ),
                  ),
                  // InkWell(
                  //   onTap: () async => {
                  //     await Auth().signout(),
                  //     Navigator.of(context)
                  //         .pushNamedAndRemoveUntil('/', (route) => false)
                  //     //do another db thing
                  //   },
                  //   child: const cardbtn(
                  //     txt: "Logout",
                  //     icon: Icons.data_usage_rounded,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const urlogohere()
            ],
          ),
        ),
      ),
    );
  }
}
