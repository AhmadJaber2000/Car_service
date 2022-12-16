import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../tools/constants.dart';

class ListMechanicByRate extends StatefulWidget {
  const ListMechanicByRate({Key? key}) : super(key: key);

  @override
  State<ListMechanicByRate> createState() => _ListMechanicByRateState();
}

class _ListMechanicByRateState extends State<ListMechanicByRate> {
  List<User> user = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'List By Rate',
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
            colors: [
              Colors.white,
              Colors.cyan,
            ],
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
              height: 20,
            ),
            const Icon(
              Icons.add_call,
              color: Colors.cyan,
              size: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(" Rate : ${user.rate}",
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 30,
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => RoleTypeGoogleMapPage(
                      //           userType: title,
                      //           service: "location",
                      //           roleType: type,
                      //         )));
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ListMechanicByRate()));
                      },
                      child: buildChoice(
                          "Chat",
                          const Icon(
                            Icons.chat,
                            color: Colors.amber,
                          )))),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => RoleTypeGoogleMapPage(
                      //           userType: title,
                      //           service: "location",
                      //           roleType: type,
                      //         )));
                    },
                    child: buildChoice(
                        "Rate",
                        const Icon(
                          Icons.star_rate,
                          color: Colors.blue,
                        ))),
              ),
            ],
          ),
        ),
        // Card(
        //   child: CupertinoButton(
        //     onPressed: () {},
        //     child: ListTile(
        //       leading: CircleAvatar(
        //         child: Text('${user.rate}'),
        //         radius: 30,
        //       ),
        //       title: Text(user.fullName()),
        //       subtitle: Text(user.email),
        //     ),
        //   ),
        // ),
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

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection(usersCollection)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

// buildContainer(String title, String type, String image) {
//   return Container(
//     height: MediaQuery.of(context).size.height / 4,
//     margin: const EdgeInsets.all(15),
//     width: double.infinity,
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.white, width: 2),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Colors.white,
//             Colors.cyan,
//           ],
//         )),
//     child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold)),
//             const SizedBox(
//               height: 20,
//             ),
//             const Icon(
//               Icons.add_call,
//               color: Colors.cyan,
//               size: 20,
//             ),
//             Image.asset(
//               image,
//               height: 100,
//             ),
//           ],
//         ),
//         Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => RoleTypeGoogleMapPage(
//                                 userType: title,
//                                 service: "location",
//                                 roleType: type,
//                               )));
//                     },
//                     child: buildChoice(
//                         "location",
//                         const Icon(
//                           Icons.location_on_sharp,
//                           color: Colors.blue,
//                         ))),
//               ),
//               Expanded(
//                   child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ListMechanicByRate()));
//                       },
//                       child: buildChoice(
//                           "Rate",
//                           const Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                           )))),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
