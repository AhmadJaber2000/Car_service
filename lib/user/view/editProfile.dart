import 'package:Car_service/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as u;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import '../../authenticate/service/authenticate.dart';
import '../../authenticate/signupService/sign_up_bloc.dart';
import '../../authenticate/signupService/sign_up_event.dart';
import '../../googlemap/service/location_service.dart';
import '../../tools/constants.dart';
import '../../viewmodel/viewModel.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  User user = User();
  bool enabled = false; //Not clickable and not editable
  bool readOnly = true;
  String title = 'Edit';
  late LocationData location;
  double? lat, long;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fun();
  }

  fun() async {
    user = (await readUser()!)!;
    setControllers(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: const Text("Profile"),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfffffcfc),
      body: user == null
          ? const Center(
              child: Text('No user'),
            )
          : buildUser(user),
    );
  }

  setControllers(User user) {
    setState(() {
      firstnameController.text = user.firstName;
      lastnameController.text = user.lastName;
      emailController.text = user.email;
      phoneController.text = user.phoneNumber;
    });
  }

  u.User? currentUser = u.FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  Widget buildUser(User user) {
    return Form(
      key: _key,
      autovalidateMode: _validate,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/placeholder.jpg'),
                // child: Positioned(
                //   right: 60,
                //   bottom: 900,
                //   child: FloatingActionButton(
                //     backgroundColor: const Color(0xffae0001),
                //     mini: true,
                //     onPressed: () => _onCameraClick(context),
                //     child: Icon(
                //       Icons.camera_alt,
                //       color: ViewModel.isDarkMode(context)
                //           ? Colors.black
                //           : Colors.white,
                //     ),
                //   ),
                // ),
              ),
              // const CircleAvatar(
              //   radius: 50,
              //   backgroundImage: AssetImage('assets/images/placeholder.jpg'),
              // ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                  enabled: enabled, //Not clickable and not editable
                  readOnly: readOnly,
                  textCapitalization: TextCapitalization.words,
                  controller: firstnameController,
                  validator: ViewModel.validateName,
                  textInputAction: TextInputAction.next,
                  decoration: ViewModel.getInputDecoration(
                      hint: 'First Name',
                      darkMode: ViewModel.isDarkMode(context),
                      errorColor: Theme.of(context).errorColor),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                  enabled: enabled, //Not clickable and not editable
                  readOnly: readOnly,
                  textCapitalization: TextCapitalization.words,
                  validator: ViewModel.validateName,
                  controller: lastnameController,
                  textInputAction: TextInputAction.next,
                  decoration: ViewModel.getInputDecoration(
                      hint: 'Last Name',
                      darkMode: ViewModel.isDarkMode(context),
                      errorColor: Theme.of(context).errorColor),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                  enabled: enabled, //Not clickable and not editable
                  readOnly: readOnly,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  validator: ViewModel.validateEmail,

                  decoration: ViewModel.getInputDecoration(
                      hint: 'Email',
                      darkMode: ViewModel.isDarkMode(context),
                      errorColor: Theme.of(context).errorColor),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                  enabled: enabled, //Not clickable and not editable
                  readOnly: readOnly,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: phoneController,
                  decoration: ViewModel.getInputDecoration(
                      hint: 'Phone',
                      darkMode: ViewModel.isDarkMode(context),
                      errorColor: Theme.of(context).errorColor),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(
                          MediaQuery.of(context).size.width / 1.5),
                      backgroundColor: black,
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(
                          color: black,
                        ),
                      ),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        enabled = !enabled;
                        readOnly = !readOnly;
                        title = enabled ? "Save" : "Edit";
                        if (!enabled) updateUser();
                      });
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(
                          MediaQuery.of(context).size.width / 1.5),
                      backgroundColor: black,
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(
                          color: black,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Update Your Location',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      location = await LocationService().getLocation();
                      setState(() {
                        // lat = location.latitude;
                        // long = location.longitude;
                        updatelocation();
                      });
                    }),
              ),
            ],
          ),
        ),
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

  Future<User?> updateUser() async {
    print("update");
    setState(() {
      user.firstName = firstnameController.text!;
      user.lastName = lastnameController.text!;
      user.email = emailController.text!;
      user.phoneNumber = phoneController.text!;
    });
    print(user.firstName);
    await FireStoreUtils.updateCurrentUser(user);
  }

  Future<User?> updatelocation() async {
    print("update");
    setState(() {
      user.lat = location.latitude!;
      user.long = location.longitude!;
    });
    print(user.firstName);
    await FireStoreUtils.updateCurrentUser(user);
  }
}

Stream<List<User>> readUsers() => FirebaseFirestore.instance
    .collection(usersCollection)
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
