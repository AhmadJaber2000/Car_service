import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../constants.dart';
import '../../../models/MyFiles.dart';
import '../../../responsive.dart';
import 'file_info_card.dart';
import 'grid_view_builder_grid.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("All Users",
                style: TextStyle(color: Color(0xff946b2d), fontSize: 15)),
          ],
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Responsive(
          mobile: GridViewBuilderGrid(
            crossAxisCount: size.width < 850 ? 2 : 4,
            childAspectRatio: size.width < 850 ? 1 : 1.4,
          ),
          tablet: GridViewBuilderGrid(
            crossAxisCount: size.width < 1400 ? 3 : 4,
            childAspectRatio: size.width < 1400 ? 1 : 1.4,
          ),
          desktop: GridViewBuilderGrid(
            childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}
