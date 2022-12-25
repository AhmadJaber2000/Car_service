import 'dart:developer';
import 'dart:io';
import 'package:Car_service/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as u;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../../authenticate/service/authenticate.dart';
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
  TextEditingController aboutController = TextEditingController();
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
    FireStoreUtils.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      enabled = !enabled;
                      readOnly = !readOnly;
                      title = enabled ? "Save" : "Edit";
                      if (!enabled) updateUser();
                    });
                  },
                  icon: Icon(Icons.edit)),
            ],
          ),
        ],
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
      aboutController.text = user.about;
    });
  }

  u.User? currentUser = u.FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;

  Widget buildUser(User user) {
    Size mq = MediaQuery.of(context).size;

    return Form(
      key: _key,
      autovalidateMode: _validate,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  //profile picture
                  _image != null
                      ?

                      //local image
                      ClipRRect(
                          borderRadius: BorderRadius.circular(mq.height * .1),
                          child: Image.file(File(_image!),
                              width: mq.height * .2,
                              height: mq.height * .2,
                              fit: BoxFit.cover))
                      :

                      //image from server
                      ClipRRect(
                          borderRadius: BorderRadius.circular(mq.height * .1),
                          child: CachedNetworkImage(
                            width: mq.height * .2,
                            height: mq.height * .2,
                            fit: BoxFit.cover,
                            imageUrl: user.profilePictureURL,
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                                    child: Icon(CupertinoIcons.person)),
                          ),
                        ),

                  //edit image button
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      elevation: 1,
                      onPressed: () {
                        _showBottomSheet();
                      },
                      shape: const CircleBorder(),
                      color: Colors.white,
                      child: const Icon(Icons.edit, color: Colors.blue),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                  enabled: enabled,
                  //Not clickable and not editable
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
                  enabled: enabled,
                  //Not clickable and not editable
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
                  enabled: enabled,
                  //Not clickable and not editable
                  readOnly: !readOnly,
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
                  enabled: enabled,
                  //Not clickable and not editable
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
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                  enabled: enabled,
                  //Not clickable and not editable
                  readOnly: readOnly,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: aboutController,
                  decoration: ViewModel.getInputDecoration(
                      hint: 'About',
                      darkMode: ViewModel.isDarkMode(context),
                      errorColor: Theme.of(context).errorColor),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         fixedSize: Size.fromWidth(
              //             MediaQuery.of(context).size.width / 1.5),
              //         backgroundColor: black,
              //         padding: const EdgeInsets.only(top: 16, bottom: 16),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(25.0),
              //           side: const BorderSide(
              //             color: black,
              //           ),
              //         ),
              //       ),
              //       child: Text(
              //         title,
              //         style: const TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //         ),
              //       ),
              //       onPressed: () async {
              //         setState(() {
              //           enabled = !enabled;
              //           readOnly = !readOnly;
              //           title = enabled ? "Save" : "Edit";
              //           if (!enabled) updateUser();
              //         });
              //       }),
              // ),
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
                      'Delete Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            backgroundColor: Colors.white,
                            titleTextStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primecolor),
                            title: const Text('Delete Account'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text(
                                    'Sure Want To Delete This Account ?',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: primecolor),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  final docUser = FirebaseFirestore.instance
                                      .collection(usersCollection)
                                      .doc(user.userID);
                                  print(user.userID);
                                  docUser.delete();
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    backgroundColor: primecolor),
                              ),
                              TextButton(
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    backgroundColor: black),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _image;

  void _showBottomSheet() {
    Size mq = MediaQuery.of(context).size;

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              SizedBox(height: mq.height * .02),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
                          FireStoreUtils.updateProfilePicture(File(_image!));

                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/google.png')),

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          FireStoreUtils.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/add_image.png')),
                ],
              )
            ],
          );
        });
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
      user.about = aboutController.text!;
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
