import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../constants.dart';
import 'components/header.dart';
import 'components/my_files.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Header(),
          SizedBox(
            height: defaultPadding,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    MyFiles(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
