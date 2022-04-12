import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/ThemeManagement.dart';
import 'my_chart.dart';

class LineChart extends StatelessWidget {
  const LineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 6,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: context
                          .watch<ThemeManagement>()
                          .lineChartColorPredicted,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Last Month",
                    style: TextStyle(
                      color:
                          context.watch<ThemeManagement>().allTextColorOpacity5,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color:
                          context.watch<ThemeManagement>().lineChartColorActual,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "This Month",
                    style: TextStyle(
                      color:
                          context.watch<ThemeManagement>().allTextColorOpacity5,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: context.watch<ThemeManagement>().allTextColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Predicted",
                    style: TextStyle(
                      color:
                          context.watch<ThemeManagement>().allTextColorOpacity5,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Hero(tag: "chart", child: BezierChartPersonal()),
            ),
          ],
        ));
  }
}
