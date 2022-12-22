import 'package:flutter/material.dart';

import '../../components/Constants.dart';

class urlogohere extends StatelessWidget {
  const urlogohere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage(
          'assets/images/car-service-logo-template_175455-original (1)-fococlipping-standard.png'),
      // child: Text(
      //   "Your logo here",
      //   style: textheading2,
      // ),
      backgroundColor: Colors.white,
      radius: 100,
    );
  }
}
