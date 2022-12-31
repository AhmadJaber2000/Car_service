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
          backgroundColor: Color(0xffb2d8d8),
          body: SingleChildScrollView(
            child: Column(children: [
              if (userd.roletype == "Mechanic")
                Container(
                  color: Colors.black,
                  width: mq.width,
                  child: Image.network(
                    'https://www.floridacareercollege.edu/wp-content/uploads/sites/4/2020/06/3-Reasons-Why-Being-a-Mechanic-Could-Be-An-Amazing-Career-Florida-Career-College.jpeg',
                    width: mq.width,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              if (userd.roletype == "Truck")
                Container(
                  color: Colors.black,
                  width: mq.width,
                  child: Image.network(
                    'https://knoxvillewreckerservice.com/wp-content/uploads/2018/11/Knoxville-Wrecker-Service-Tow-Truck-Service-2.jpg',
                    width: mq.width,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                        child: TextFormField(
                          //Not clickable and not editable
                          readOnly: readOnly,
                          controller: fullNameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.cyan),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                        child: TextFormField(
                          readOnly: true,
                          //Not clickable and not editable
                          controller: phoneController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: 'Your Phone..',
                            hintStyle: TextStyle(color: Colors.blue),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: TextFormField(
                          readOnly: readOnly,
                          controller: aboutController,
                          obscureText: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Description',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 17),
                            hintStyle: TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                          ),
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      if (userd.activestate == false)
                        const Card(
                          color: Colors.red,
                          child: ListTile(
                            title: Text(
                              "Not Available Right Now!",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            leading: Icon(Icons.highlight_off_rounded),
                          ),
                        ),
                      if (userd.activestate == true)
                        const Card(
                          color: Colors.green,
                          child: ListTile(
                            title: Text(
                              "Available Right Now!",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            leading: Icon(Icons.offline_pin_outlined),
                          ),
                        ),
                      SizedBox(
                        height: 16,
                      ),
                      const Text("Description",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 16)),
                      Container(
                        width: mq.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder(
                            stream: FireStoreUtils.getInfoCheckBox(
                                widget.user.userID),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox(
                                  height: 200,
                                  width: mq.width,
                                  child: Center(
                                    child: Text("No Comments"),
                                  ),
                                );
                              }

                              return SizedBox(
                                  height: 200,
                                  width: mq.width,
                                  child: Container(
                                    width: mq.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot items =
                                            snapshot.data!.docs[index];
                                        return Card(
                                          child: ListTile(
                                            leading: Icon(Icons.info_outline),
                                            title:
                                                Text(items['items'].toString()),
                                          ),
                                        );
                                      },
                                    ),
                                  ));
                            },
                          ),
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
                                  return Card(
                                    shadowColor: Color(0xff004c4c),
                                    child: ListTile(
                                      leading: Icon(Icons.comment),
                                      title: Text(comment['text']),
                                    ),
                                  );
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
            ]),
          )),
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
