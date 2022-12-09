import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class StorageInfoCard extends StatelessWidget {
  StorageInfoCard({
    Key? key,
    required this.title,
    required this.svgPic,
    required this.amountOfFiles,
    required this.numOfFiles,

  }) : super(key: key);

  String title,svgPic,amountOfFiles;
  int numOfFiles;




  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor.withOpacity(.2),
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(defaultPadding),),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(svgPic),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('$numOfFiles Files here',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          Text(amountOfFiles),
        ],
      ),
    );
  }
}

