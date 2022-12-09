// import 'dart:math';
// import 'package:Car_service/Tools/constants.dart';
// import 'package:Car_service/model/user.dart';
// import 'package:Car_service/services/helper.dart';
// import 'package:Car_service/ui/User_cart/UserCart.dart';
// import 'package:Car_service/ui/auth/authentication_bloc.dart';
// import 'package:Car_service/ui/auth/welcome/welcome_screen.dart';
// import 'package:Car_service/ui/home/cardWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class MechanicHome extends StatefulWidget {
//   ////final User user;////
//
//   const MechanicHome({
//     Key? key,
//     /*required this.user*/
//   }) : super(key: key);
//
//   @override
//   State createState() => _MechanicHome();
// }
//
// class _MechanicHome extends State<MechanicHome> {
//   ////late User user;////
//
//   @override
//   void initState() {
//     super.initState();
//     ////user = widget.user;////
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthenticationBloc, AuthenticationState>(
//       listener: (context, state) {
//         if (state.authState == AuthState.unauthenticated) {
//           pushAndRemoveUntil(context, const WelcomeScreen(), false);
//         }
//       },
//       child: Scaffold(
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               const DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Color(colorPrimary),
//                 ),
//                 child: Text(
//                   'Drawer Header',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               ListTile(
//                 title: Text(
//                   'Logout',
//                   style: TextStyle(
//                       color: isDarkMode(context)
//                           ? Colors.grey.shade50
//                           : Colors.grey.shade900),
//                 ),
//                 leading: Transform.rotate(
//                   angle: pi / 1,
//                   child: Icon(
//                     Icons.exit_to_app,
//                     color: isDarkMode(context)
//                         ? Colors.grey.shade50
//                         : Colors.grey.shade900,
//                   ),
//                 ),
//                 onTap: () {
//                   context.read<AuthenticationBloc>().add(LogoutEvent());
//                 },
//               ),
//             ],
//           ),
//         ),
//         appBar: AppBar(
//           title: Text(
//             'Mechanic Home',
//             style: TextStyle(
//                 color: isDarkMode(context)
//                     ? Colors.grey.shade50
//                     : Colors.grey.shade900),
//           ),
//           iconTheme: IconThemeData(
//               color: isDarkMode(context)
//                   ? Colors.grey.shade50
//                   : Colors.grey.shade900),
//           backgroundColor:
//               isDarkMode(context) ? Colors.grey.shade900 : Colors.grey.shade50,
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               /* user.profilePictureURL == ''
//                   ? CircleAvatar(
//                       radius: 35,
//                       backgroundColor: Colors.grey.shade400,
//                       child: ClipOval(
//                         child: SizedBox(
//                           width: 70,
//                           height: 70,
//                           child: Image.asset(
//                             'assets/images/placeholder.jpg',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     )
//                   : displayCircleImage(user.profilePictureURL, 80, false),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(user.fullName()),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("Hello " + user.fullName()),
//               ),*/
//               /*Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(user.userID),
//               ),*/
//               Expanded(
//                 child: Stack(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(top: 70), //70
//                       decoration: BoxDecoration(
//                         color: Color(0xff0b421a),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(40),
//                           topRight: Radius.circular(40),
//                         ),
//                       ),
//                     ),
//                     ListView.builder(
//                       itemCount: usercard.length,
//                       itemBuilder: (context, index) => CardWidget(
//                         itemindex: index,
//                         userCart: usercard[index],
//                         press: () {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
