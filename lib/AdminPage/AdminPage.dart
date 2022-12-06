import 'dart:math';
import 'package:Car_service/constants.dart';
import 'package:Car_service/services/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../model/user.dart';
import '../ui/auth/authentication_bloc.dart';
import '../ui/auth/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as u;

class AdminRole extends StatefulWidget {
  const AdminRole({Key? key}) : super(key: key);

  @override
  State<AdminRole> createState() => _AdminRoleState();
}

class _AdminRoleState extends State<AdminRole> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.authState == AuthState.unauthenticated) {
            pushAndRemoveUntil(context, const WelcomeScreen(), false);
          }
        },
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff000000),
                  ),
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(color: Color(0xffd3a625)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Rate Us',
                    style: TextStyle(
                        color: isDarkMode(context)
                            ? Colors.grey.shade50
                            : Colors.grey.shade900),
                  ),
                  leading: Transform.rotate(
                    angle: pi / 150,
                    child: Icon(
                      Icons.star_rate,
                      color: Color(0xffd3a625),
                    ),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        color: isDarkMode(context)
                            ? Colors.grey.shade50
                            : Colors.grey.shade900),
                  ),
                  leading: Transform.rotate(
                    angle: pi / 1,
                    child: Icon(
                      Icons.exit_to_app,
                      color: Color(0xffd3a625),
                    ),
                  ),
                  onTap: () {
                    context.read<AuthenticationBloc>().add(LogoutEvent());
                  },
                ),
              ],
            ),
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
          appBar: AppBar(
            title: const Text("Admin Page"),
            centerTitle: true,
          ),
          backgroundColor: const Color(0xfffffcfc),
        ));
  }

  Widget buildUser(User user) => Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${user.roletype}'),
            radius: 30,
          ),
          title: Text(user.fullName()),
          subtitle: Text(user.email),
        ),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection(usersCollection)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
// ListTil e(
// leading: CircleAvatar(
// child: Text('${user.roletype}'),
// radius: 40,
// ),
// title: Text(user.fullName()),
// subtitle: Text(user.email),
// )
