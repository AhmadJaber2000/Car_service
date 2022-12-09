
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/MyFiles.dart';
import 'file_info_card.dart';

class GridViewBuilderGrid extends StatelessWidget {
   GridViewBuilderGrid({
    Key? key,
      this.childAspectRatio=1.0,
      this.crossAxisCount=4,

  }) : super(key: key);

   int crossAxisCount;
   double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: demoMyFiels.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),

      itemBuilder: (BuildContext context, int index) =>FileInfoCard(info: demoMyFiels[index]),
    );
  }
}
