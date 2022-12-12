import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar({
    Key? key,
    required this.color,
    required this.percentage,
    required this.info,
  }) : super(key: key);

  var info;
  Color color;
  int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: info.color.withOpacity(.1),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: info.color.withOpacity(1),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
