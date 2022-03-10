import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Providers/ThemeManagement.dart';

class PieChartSkeleton extends StatelessWidget {
  const PieChartSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(

      gradient: context.watch<ThemeManagement>().shimmerGradient,
      child: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 6,
              ),
              child: Column(
                children: [["",""],["",""]]
                    .map(
                      (aColumn) => Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: aColumn
                              .map(
                                (aRow) => Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: const BoxDecoration(
                                        color:  Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Container(width: 70,height: 10,color: Colors.grey,),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 3,
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: PieChart(
                  PieChartData(
                      centerSpaceRadius: 0,
                      centerSpaceColor: Colors.transparent,
                      pieTouchData: PieTouchData(enabled: true),
                      sections: [
                        PieChartSectionData(
                            showTitle: false,
                            titleStyle: const TextStyle(
                                color: Colors.white, fontSize: 10),
                            radius: 100,
                            color: Colors.grey,
                            value: 1)
                      ]),
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
