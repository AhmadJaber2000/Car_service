// import 'package:Car_service/ui/User_cart/UserCart.dart';
// import 'package:Car_service/ui/home/cardWidget.dart';
// import 'package:flutter/material.dart';
//
// class SpareCart extends StatelessWidget {
//   const SpareCart({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           Expanded(
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xffeac784),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40),
//                     ),
//                   ),
//                   margin: EdgeInsets.only(top: 70),
//                 ),
//                 ListView.builder(
//                   itemCount: usercard.length,
//                   itemBuilder: (context, index) => CardWidget(
//                     itemindex: index,
//                     userCart: usercard[index],
//                     press: () {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
