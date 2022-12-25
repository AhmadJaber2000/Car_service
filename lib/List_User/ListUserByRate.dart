import 'package:Car_service/ChatIn/api/apis.dart';
import 'package:Car_service/ChatIn/screens/home_screen.dart';
import 'package:Car_service/ChatNew/screens/chat_screen.dart';
import 'package:Car_service/ChatNew/screens/view_profile_screen.dart';
import 'package:Car_service/authenticate/service/authenticate.dart';
import 'package:Car_service/model/roleType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../ChatNew/screens/home_screen.dart';
import '../googlemap/view/roleTypeGoogleMapPage.dart';
import '../model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as path;
import '../tools/constants.dart';

class ListMechanicByRate extends StatefulWidget {
  const ListMechanicByRate({Key? key, required this.roletype})
      : super(key: key);
  final String roletype;

  @override
  State<ListMechanicByRate> createState() => _ListMechanicByRateState();
}

class _ListMechanicByRateState extends State<ListMechanicByRate> {
  TextEditingController commentController = TextEditingController();
  String comment = '';
  TextEditingController commentitemcontroller = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _commentController = TextEditingController();

  List<User> user = [];
  @override
  void initState() {
    super.initState();
  }

  setControllers(User user) {
    setState(() {
      commentController.text = user.comment;
    });
  }

  function() async {
    FireStoreUtils.getAllUsers();
    print(FireStoreUtils.getAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb2d8d8),
      appBar: AppBar(
        title: Text(
          'List By Rate',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff004c4c),
      ),
      body: FutureBuilder(
          future: FireStoreUtils.getAllUserRole(widget.roletype),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("No Users"),
              );
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              if (widget.roletype == "Truck") {
                return ListView(
                  children: users.map(buildUser).toList(),
                );
              } else if (widget.roletype == "Mechanic") {
                return ListView(
                  children: users.map(buildUser).toList(),
                );
                // return ListView(
                //   children: users.map(buildUser).toList(),
                // );
              }
              return Container();
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
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text(user.fullName(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProfileScreen(
                              user: user,
                            )));
                print("Hi");
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(" Rate : ${user.rate}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
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
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoleTypeGoogleMapPage(
                                    userType: user.roletype,
                                    service: "location",
                                    roleType: user.roletype,
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
                                builder: (context) => ChatScreen(user: user)));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ChatWindow()));
                      },
                      child: buildChoice(
                          "Chat",
                          const Icon(
                            Icons.chat,
                            color: Color(0xff317873),
                          )))),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      RateMyApp _rateMyApp = RateMyApp(
                        preferencesPrefix: 'Rate This User',
                        minDays: 3,
                        minLaunches: 7,
                        remindDays: 2,
                        remindLaunches: 5,
                      );
                      _rateMyApp.init().then((_) {
                        // if (_rateMyApp.shouldOpenDialog) {
                        _rateMyApp.showStarRateDialog(
                          context,
                          title: 'Enjoying Flutter Rating Prompt?',
                          message: 'Please leave a rating!',
                          actionsBuilder: (context, stars) {
                            return [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _commentController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter a comment',
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    child: Text('Send'),
                                    onPressed: () async {
                                      double? star = stars;
                                      FireStoreUtils.sendCommentForuser(
                                          _commentController.text, user.userID);
                                      _commentController.clear();

                                      User userd = User();
                                      Future<User?> updateUser() async {
                                        print("update");
                                        setState(() {
                                          user.rate = stars!;
                                        });
                                        print(user.rate);
                                        print(user.commentitem);
                                        await FireStoreUtils.updateCurrentUser(
                                            user);
                                      }

                                      setState(() {
                                        updateUser();
                                      });

                                      Navigator.pop(context);
                                      commentController.clear();
                                    },
                                  ),
                                ],
                              )
                            ];
                          },
                          dialogStyle: DialogStyle(
                            titleAlign: TextAlign.center,
                            messageAlign: TextAlign.center,
                            messagePadding: EdgeInsets.only(bottom: 20.0),
                          ),
                          starRatingOptions: StarRatingOptions(),
                        );
                        // }
                      });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => RoleTypeGoogleMapPage(
                      //               userType: user.roletype,
                      //               service: "location",
                      //               roleType: user.roletype,
                      //             )));
                    },
                    child: buildChoice(
                        "Rate",
                        const Icon(
                          Icons.star_rate,
                          color: Color(0xff317873),
                        ))),
              ),
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
                  color: Color(0xff008080),
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
