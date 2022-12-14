// import 'package:Car_service/tools/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'Comps/style.dart';
// import 'Comps/widget.dart';
//
// class ChatPage extends StatefulWidget {
//   final String id;
//
//   const ChatPage({Key? key, required this.id}) : super(key: key);
//
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   var roomId;
//
//   @override
//   Widget build(BuildContext context) {
//     final firestore = FirebaseFirestore.instance;
//     return Scaffold(
//       backgroundColor: Colors.indigo.shade400,
//       appBar: AppBar(
//         backgroundColor: Colors.indigo.shade400,
//         title: const Text('John Doe'),
//         elevation: 0,
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Chats',
//                   style: Styles.h1(),
//                 ),
//                 const Spacer(),
//                 Text(
//                   'Last seen: 04:50',
//                   style: Styles.h1().copyWith(
//                       fontSize: 12,
//                       fontWeight: FontWeight.normal,
//                       color: Colors.white70),
//                 ),
//                 const Spacer(),
//                 const SizedBox(
//                   width: 50,
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: Styles.friendsBox(),
//               child: StreamBuilder(
//                   stream: firestore.collection('Rooms').snapshots(),
//                   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.hasData) {
//                       if (snapshot.data!.docs.isNotEmpty) {
//                         List alldata = snapshot.data!.docs
//                             .where((element) =>
//                                 element['users']
//                                     .toString()
//                                     .contains(widget.id) &&
//                                 element['users'].toString().contains(
//                                     FirebaseAuth.instance.currentUser!.uid))
//                             .toList();
//                         QueryDocumentSnapshot? data =
//                             alldata.isNotEmpty ? alldata.first : null;
//                         if (data != null) {
//                           roomId = data.id;
//                         }
//                         return data == null
//                             ? Container()
//                             : StreamBuilder(
//                                 stream: data.reference
//                                     .collection(chatCollection)
//                                     .orderBy('date_time', descending: true)
//                                     .snapshots(),
//                                 builder: (context,
//                                     AsyncSnapshot<QuerySnapshot> snap) {
//                                   return !snap.hasData
//                                       ? Container()
//                                       : ListView.builder(
//                                           itemCount: snap.data!.docs.length,
//                                           reverse: true,
//                                           itemBuilder: (context, i) {
//                                             return ChatWidgets.messagesCard(
//                                                 snap.data!.docs[i]['sent_by'] ==
//                                                     FirebaseAuth.instance
//                                                         .currentUser!.uid,
//                                                 snap.data!.docs[i]['message'],
//                                                 DateFormat('hh:mm a').format(
//                                                     snap.data!
//                                                         .docs[i]['datetime']
//                                                         .toData()));
//                                           },
//                                         );
//                                 });
//                       } else {
//                         return Center(
//                           child: Text('No Conversion'),
//                         );
//                       }
//                     } else {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                   }),
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             child: ChatWidgets.messageField(onSubmit: (controller) {
//               if (roomId != null) {
//                 Map<String, dynamic> data = {
//                   'messages': controller.text.trim(),
//                   'sent_by': FirebaseAuth.instance.currentUser!.uid,
//                   'datetime': DateTime.now(),
//                 };
//                 firestore.collection('Rooms').doc(roomId).update({
//                   'last_message_time': DateTime.now(),
//                   'last_message': controller.text,
//                 });
//                 firestore
//                     .collection('Rooms')
//                     .doc(roomId)
//                     .collection(chatCollection)
//                     .add(data);
//               } else {
//                 Map<String, dynamic> data = {
//                   'messages': controller.text.trim(),
//                   'sent_by': FirebaseAuth.instance.currentUser!.uid,
//                   'datetime': DateTime.now(),
//                 };
//
//                 firestore.collection('Rooms').add({
//                   'users': [
//                     widget.id,
//                     FirebaseAuth.instance.currentUser!.uid,
//                   ],
//                   'last_message_time': DateTime.now(),
//                   'last_message': controller.text,
//                 }).then((value) async {
//                   value.collection(chatCollection).add(data);
//                 });
//               }
//               controller.clear();
//             }),
//           )
//         ],
//       ),
//     );
//   }
// }
