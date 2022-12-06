import 'package:Car_service/constants.dart';
import 'package:Car_service/model/user.dart';
import 'package:Car_service/ui/User_cart/UserFunctionScreens/UsersFunctionScreensUI/EditProfiledetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as u;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
        ),
        backgroundColor: Color(0xfffffcfc),
        body: FutureBuilder<User?>(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data;
              return user == null
                  ? Center(
                      child: Text('No user'),
                    )
                  : buildUser(user);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  u.User? currentUser = u.FirebaseAuth.instance.currentUser;

  Widget buildUser(User user) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 100),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/placeholder.jpg'),
          ),
          Text(
            "${user.fullName()}",
            style: TextStyle(
                fontSize: 30,
                color: Color(0xff362415),
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
                fontFamily: "Source Sans Pro"),
          ),
          SizedBox(
            height: 20,
            width: 200,
            child: Divider(
              color: Colors.black,
            ),
          ),
          InfoCard(
              text: "${currentUser?.phoneNumber}",
              icon: Icons.phone,
              onPressed: () async {}),
          InfoCard(
              text: "${user.lat}" + "${user.long}",
              icon: Icons.location_on,
              onPressed: () async {}),
          InfoCard(
              text: "${user.email}",
              icon: Icons.email_outlined,
              onPressed: () async {}),
        ],
      ),
    );
  }

  Future<User?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(currentUser?.uid);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection(usersCollection)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
