// import 'package:Car_service/model/user.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/physics.dart';
// import '../models/chat_user.dart';
// import '../screens/chat_screen.dart';
//
// //card to represent a single user in home screen
// class ChatUserCard extends StatefulWidget {
//   final ChatUser user;
//
//   const ChatUserCard({super.key, required this.user});
//
//   @override
//   State<ChatUserCard> createState() => _ChatUserCardState();
// }
//
// class _ChatUserCardState extends State<ChatUserCard> {
//   @override
//   Widget build(BuildContext context) {
//     Size mq = MediaQuery.of(context).size;
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
//       // color: Colors.blue.shade100,
//       elevation: 0.5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: InkWell(
//         onTap: () {
//           //for navigating to chat screen
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => ChatScreen(
//                         user: widget.user,
//                       )));
//         },
//         child: ListTile(
//           //user profile picture
//           // leading: const CircleAvatar(child: Icon(CupertinoIcons.person)),
//           leading: ClipRRect(
//             borderRadius: BorderRadius.circular(mq.height * .03),
//             child: CachedNetworkImage(
//               width: mq.height * .055,
//               height: mq.height * .055,
//               imageUrl: widget.user.image,
//               errorWidget: (context, url, error) =>
//                   const CircleAvatar(child: Icon(CupertinoIcons.person)),
//             ),
//           ),
//
//           //user name
//           title: Text(widget.user.name),
//
//           //last message
//           subtitle: Text(widget.user.about, maxLines: 1),
//
//           //last message time
//           trailing: Container(
//             width: 15,
//             height: 15,
//             decoration: BoxDecoration(
//                 color: Colors.greenAccent.shade400,
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//           // trailing: const Text(
//           //   '12:00 PM',
//           //   style: TextStyle(color: Colors.black54),
//           // ),
//         ),
//       ),
//     );
//   }
// }
