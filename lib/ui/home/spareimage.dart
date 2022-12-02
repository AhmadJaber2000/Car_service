import 'package:flutter/material.dart';

class SpareImage extends StatelessWidget {
  const SpareImage({Key? key, required this.size, required this.image})
      : super(key: key);
  final Size size;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: size.width * 0.8,
      child: Stack(
        children: [
          Container(
            height: size.width * 0.1,
            width: size.width * 0.1,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Image.asset(image),
        ],
      ),
    );
  }
}
