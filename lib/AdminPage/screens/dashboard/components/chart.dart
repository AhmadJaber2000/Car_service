import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
          children: [
            PieChart(
              PieChartData(

                sectionsSpace: 0,
                startDegreeOffset: -89,
                centerSpaceRadius: 70,
                sections: pieChartSectionData,
              ),

            ),

            Positioned.fill(
              child: Column(
                children: [
                  SizedBox(height: defaultPadding*5,),
                  Text("29.1 GB"),
                  Text("Of 1Tb is empty"),
                ],
              ),
            ),
          ]
      ),

    );
  }
}

List<PieChartSectionData> pieChartSectionData= [
  PieChartSectionData(
    value:25,
    color: primaryColor,
    radius: 10,
    showTitle: false,

  ),
  PieChartSectionData(
    value:25,
    color: Colors.green,
    radius:12,
    showTitle: false,

  ),
  PieChartSectionData(
    value:30,
    color: Colors.yellow,
    radius: 14,
    showTitle: false,

  ),
  PieChartSectionData(
    value:25,
    color: Colors.red,
    radius: 15,
    showTitle: false,

  ),
  PieChartSectionData(
    value:25,
    color: primaryColor.withOpacity(.1),
    radius: 10,
    showTitle: false,

  ),



];