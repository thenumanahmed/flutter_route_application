import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../configs/themes/app_color.dart';

class Chart extends StatelessWidget {
  Chart({
    super.key,
  });

  final List<PieChartSectionData> pieChartSectionData = [
    PieChartSectionData(
      showTitle: false,
      value: 25,
      color: primaryColorLight,
      radius: 22,
    ),
    PieChartSectionData(
      showTitle: false,
      value: 20,
      color: const Color(0xFF26E5FF),
      radius: 20,
    ),
    PieChartSectionData(
      showTitle: false,
      value: 15,
      color: const Color(0xFFFFCF26),
      radius: 18,
    ),
    PieChartSectionData(
      showTitle: false,
      value: 10,
      color: const Color(0xFFEE2727),
      radius: 15,
    ),
    PieChartSectionData(
      showTitle: false,
      value: 25,
      color: primaryColorLight.withOpacity(0.1),
      radius: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: pieChartSectionData,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '29.1',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Text('of 128 GB'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
