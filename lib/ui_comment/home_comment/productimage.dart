// //import 'dart:html';
// //Page Number 3
// import 'package:flutter/material.dart';
//
// class ProductImage extends StatelessWidget {
//   const ProductImage({
//     Key? key,
//     required this.size,
//     required this.image,
//   }) : super(key: key);
//
//   final Size size;
//   final String image;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       height: size.width * 0.8, //0.8
//
//       child: Stack(
//         children: [
//           Container(
//             height: size.width * 0.7,
//             width: size.width * 0.7,
//             child: CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage(image),
//             ),
//           ),
//           //Image.asset(image),
//         ],
//       ),
//     );
//   }
// }
