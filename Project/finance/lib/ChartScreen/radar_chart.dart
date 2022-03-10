import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/ThemeManagement.dart';

class RadarChartPersonal extends StatelessWidget {
  RadarChartPersonal({Key? key}) : super(key: key);

  final aDataset = [
    [3033, 3687, 2572],
    [3320, 2129, 2110],
    [987, 1200, 1101]
  ];
  final radarTitles = ['Predicted', 'Actual', 'Last Month'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: ["Expense", "Income", "Savings"]
                  .map(
                    (element) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: context
                                  .watch<ThemeManagement>()
                                  .radarChartColors[[
                                "Expense",
                                "Income",
                                "Savings"
                              ].indexOf(element)],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            element,
                            style: TextStyle(
                              color: context
                                  .watch<ThemeManagement>()
                                  .allTextColorOpacity5,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: RadarChart(
              RadarChartData(
                getTitle: (index) {
                  return radarTitles[index];
                },
                ticksTextStyle: TextStyle(
                    color: context.watch<ThemeManagement>().allTextColor),
                titleTextStyle: TextStyle(
                    color: context.watch<ThemeManagement>().allTextColor),
                radarBorderData: BorderSide(
                    color:
                        context.watch<ThemeManagement>().allTextColorOpacity5,
                    width: 1),
                tickBorderData: BorderSide(
                    color:
                        context.watch<ThemeManagement>().allTextColorOpacity5,
                    width: 1),
                dataSets: aDataset
                    .map(
                      (dataset) => RadarDataSet(
                        borderColor: context
                            .watch<ThemeManagement>()
                            .radarChartColors[aDataset.indexOf(dataset)],
                        borderWidth: 2,
                        fillColor: context
                            .watch<ThemeManagement>()
                            .radarChartColors[aDataset.indexOf(dataset)]
                            .withOpacity(0.3),
                        dataEntries: dataset
                            .map(
                              (e) => RadarEntry(
                                value: e + 0.0,
                              ),
                            )
                            .toList(),
                      ),
                    )
                    .toList(),
                borderData: FlBorderData(show: false),
              ),
              swapAnimationDuration: const Duration(milliseconds: 150),
              swapAnimationCurve: Curves.linear,
            ),
          ),
        ],
      ),
    );
  }
}
