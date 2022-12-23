import 'package:Car_service/ChatIn/api/apis.dart';
import 'package:Car_service/ChatIn/screens/home_screen.dart';
import 'package:Car_service/ChatNew/screens/chat_screen.dart';
import 'package:Car_service/model/roleType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:firebase_auth/firebase_auth.dart' as path;

import '../../googlemap/view/roleTypeGoogleMapPage.dart';
import '../../model/user.dart';
import '../../tools/constants.dart';
import '../components/cardbtn.dart';

class ListAllUser extends StatefulWidget {
  const ListAllUser({Key? key}) : super(key: key);

  @override
  State<ListAllUser> createState() => _ListAllUserState();
}

class _ListAllUserState extends State<ListAllUser> {
  // List<User> user = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'All User',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primecolor,
      ),
      body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something has erorr");
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget buildUser(User user) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
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
            colors: [Color(0xff004c4c), Color(0xff006666)],
          )),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.fullName(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 60,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(" Rate : ${user.rate}",
                style: TextStyle(
                    color: Color(0xffb2d8d8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold))
            // Image.asset(
            //   user.email,
            //   height: 100,
            // ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //   onTap: () => {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => ListAllUser()))
              //   },
              //   child: const cardbtn(
              //     txt: "Manage",
              //     icon: Icons.manage_accounts,
              //   ),
              // ),
              // Expanded(
              //   child: GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => RoleTypeGoogleMapPage(
              //                       userType: user.roletype,
              //                       service: "location",
              //                       roleType: user.roletype,
              //                     )));
              //       },
              //       child: buildChoice(
              //           "location",
              //           const Icon(
              //             Icons.location_on_sharp,
              //             color: Colors.red,
              //           ))),
              // ),
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(user: user)));
                      },
                      child: buildChoice(
                          "Chat",
                          const Icon(
                            Icons.chat,
                            color: Color(0xff326ada),
                          )))),
            ],
          ),
        ),
      ]),
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

  Future<User?> readUser() async {
    // for (var i = 0;
    //     i < FirebaseFirestore.instance.collection(usersCollection).id.length;
    //     i++) {
    //   var items = <dynamic>[];
    //
    //   print(FirebaseFirestore.instance
    //       .collectionGroup(usersCollection)
    //       .where('roletype', isEqualTo: "Truck")
    //       .get()
    //       .toString());
    // }
    final uid = path.FirebaseAuth.instance.currentUser!.uid;
    final docUser =
        FirebaseFirestore.instance.collection(usersCollection).doc(uid);

    final snapshot = await docUser.get();
    return User.fromJson(snapshot.data()!);
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection(usersCollection)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
