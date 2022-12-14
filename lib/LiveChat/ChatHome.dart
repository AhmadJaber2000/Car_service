// import 'package:Car_service/LiveChat/Logics/Functions.dart';
// import 'package:Car_service/tools/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'ChatPage.dart';
// import 'Comps/style.dart';
// import 'Comps/widget.dart';
// import 'comps/widgets.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   bool open = false;
//
//   @override
//   void initState() {
//     Functions.updateAvailablity();
//     super.initState();
//   }
//
//   final firestore = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo.shade400,
//       // appBar: AppBar(
//       //   backgroundColor: Colors.indigo.shade400,
//       //   title: const Text('Flash Chat'),
//       //   elevation: 0,
//       //   centerTitle: true,
//       //   actions: [
//       //     Padding(
//       //       padding: const EdgeInsets.only(right: 10.0),
//       //       child: IconButton(
//       //           onPressed: () {
//       //             setState(() {
//       //               open == true ? open = false : open = true;
//       //             });
//       //           },
//       //           icon: Icon(
//       //             open == true ? Icons.close_rounded : Icons.search_rounded,
//       //             size: 30,
//       //           )),
//       //     )
//       //   ],
//       // ),
//       drawer: ChatWidgets.drawer(),
//       body: SafeArea(
//         child: Stack(
//           alignment: AlignmentDirectional.topEnd,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Container(
//                 //   margin: const EdgeInsets.all(0),
//                 //   child: Container(
//                 //     color: Colors.indigo.shade400,
//                 //     padding: const EdgeInsets.all(8),
//                 //     height: 160,
//                 //     child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         const Spacer(),
//                 //         Padding(
//                 //           padding: const EdgeInsets.symmetric(
//                 //               horizontal: 8.0, vertical: 10),
//                 //           child: Text(
//                 //             'Recent Users',
//                 //             style: Styles.h1(),
//                 //           ),
//                 //         ),
//                 //         Container(
//                 //           margin: const EdgeInsets.symmetric(vertical: 10),
//                 //           height: 80,
//                 //           child: ListView.builder(
//                 //             scrollDirection: Axis.horizontal,
//                 //             itemBuilder: (context, i) {
//                 //               return ChatWidgets.circleProfile();
//                 //             },
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     decoration: Styles.friendsBox(),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 20),
//                           child: Text(
//                             'Contacts',
//                             style: Styles.h1().copyWith(color: Colors.indigo),
//                           ),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 12.0),
//                             child: StreamBuilder(
//                                 stream:
//                                     firestore.collection("Rooms").snapshots(),
//                                 builder: (context, snapshot) {
//                                   List data = !snapshot.hasData
//                                       ? []
//                                       : snapshot.data!.docs
//                                           .where((element) => element['users']
//                                               .toString()
//                                               .contains(FirebaseAuth
//                                                   .instance.currentUser!.uid))
//                                           .toList();
//                                   return ListView.builder(
//                                     itemCount: data.length,
//                                     itemBuilder: (context, i) {
//                                       List users = data[i]['users'];
//                                       var friend = users.where((element) =>
//                                           element !=
//                                           FirebaseAuth
//                                               .instance.currentUser!.uid);
//                                       var user = friend.isEmpty
//                                           ? friend.first
//                                           : users
//                                               .where((element) =>
//                                                   element ==
//                                                   FirebaseAuth.instance
//                                                       .currentUser!.uid)
//                                               .first;
//                                       return FutureBuilder(
//                                           future: firestore
//                                               .collection(chatCollection)
//                                               .doc(user)
//                                               .get(),
//                                           builder:
//                                               (context, AsyncSnapshot snap) {
//                                             return !snap.hasData
//                                                 ? Container()
//                                                 : ChatWidgets.card(
//                                                     title: snap.data['name'],
//                                                     subtitle:
//                                                         'Hi, How are you !',
//                                                     time: '04:40',
//                                                     onTap: () {
//                                                       Navigator.of(context)
//                                                           .push(
//                                                         MaterialPageRoute(
//                                                           builder: (context) {
//                                                             return ChatPage(
//                                                               id: user,
//                                                             );
//                                                           },
//                                                         ),
//                                                       );
//                                                     },
//                                                   );
//                                           });
//                                     },
//                                   );
//                                 }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // ChatWidgets.searchBar(open)
//           ],
//         ),
//       ),
//     );
//   }
// }
