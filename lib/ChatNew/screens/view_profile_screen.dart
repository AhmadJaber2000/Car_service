import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../authenticate/service/authenticate.dart';
import '../../model/user.dart';
import '../../tools/constants.dart';
import '../../viewmodel/viewModel.dart';

//view profile screen -- to view profile of user
class ViewProfileScreen extends StatefulWidget {
  final User user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  bool readOnly = true;

  TextEditingController IsOnlineController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _commentController = TextEditingController();

  User userd = User();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fun();
  }

  fun() async {
    userd = (await readUser())!;
    setControllers(userd);
    FireStoreUtils.getUserInfo(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //app bar
          appBar: AppBar(
            title: Text(widget.user.fullName()),
            centerTitle: true,
            backgroundColor: Color(0xff004c4c),
          ),
          //body
          body: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, right: 8.0, left: 8.0),
                      child: TextFormField(
                        // enabled: enabled,
                        //Not clickable and not editable
                        readOnly: readOnly,
                        textCapitalization: TextCapitalization.words,
                        validator: ViewModel.validateName,
                        controller: fullNameController,
                        textInputAction: TextInputAction.next,
                        decoration: ViewModel.getInputDecoration(
                            hint: 'Last Name',
                            darkMode: ViewModel.isDarkMode(context),
                            errorColor: Theme.of(context).errorColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, right: 8.0, left: 8.0),
                      child: TextFormField(
                        // enabled: enabled,
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, right: 8.0, left: 8.0),
                      child: TextFormField(
                        // enabled: enabled,
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
                    Text("Comments",
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 16)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder(
                        stream:
                            FireStoreUtils.getAllComments(widget.user.userID),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Text("No Comments"),
                              ),
                            );
                          }

                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot comment =
                                    snapshot.data!.docs[index];
                                return Text(comment['text']);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*Expanded(child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SocialMe()));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ChatWindow()));
              },
            ))*/
          ])),
    );
  }
  // Future<User?> readUser() async {
  //   final docUser = FirebaseFirestore.instance
  //       .collection(usersCollection)
  //       .doc(currentUser?.uid);
  //   final snapshot = await docUser.get();
  //   if (snapshot.exists) {
  //     return User.fromJson(snapshot.data()!);
  //   }
  // }

  setControllers(User user) {
    setState(() {
      fullNameController.text = user.fullName();
      emailController.text = user.email;
      phoneController.text = user.phoneNumber;
      aboutController.text = user.about;
      print(user.about);
      print('HIIIIIIIIIIIIIIIIIIIIIIII');
    });
  }

  Future<User?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(widget.user.userID);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
  }
}
