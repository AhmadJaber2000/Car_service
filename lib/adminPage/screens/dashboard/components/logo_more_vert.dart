import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

class Logo_MoreVert extends StatelessWidget {
  Logo_MoreVert({
    Key? key,
    required this.info,
  }) : super(key: key);

  var info;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(defaultPadding),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: info.color.withOpacity(0.1),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: SvgPicture.asset('assets/images/admin.png'),
        ),
        Icon(
          Icons.more_vert,
          color: Colors.white,
        )
      ],
    );
  }
}
