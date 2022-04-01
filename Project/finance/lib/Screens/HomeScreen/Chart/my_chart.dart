import 'package:finance/Providers/AnalysisManagement.dart';
import 'package:finance/Providers/LogInManagement.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../EntityServices/RegessionService.dart';
import '../../../Providers/ThemeManagement.dart';

class BezierChartPersonal extends StatefulWidget {
  const BezierChartPersonal({Key? key}) : super(key: key);

  @override
  _BezierChartPersonalState createState() => _BezierChartPersonalState();
}

class _BezierChartPersonalState extends State<BezierChartPersonal> {
  List<double> actualData = [1, 2, 3, 4, 5, 6];
  List<double> predictedData = [6, 5, 4, 3, 2, 1];
  List<double> lastMonth = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  double interval = 1000;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    actualData = [1, 2, 3, 4, 5, 6];
    predictedData = [6, 5, 4, 3, 2, 1];
    lastMonth = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
    setState(() {});
    RegressionService()
        .fetchLinearModels(context.read<LogInManagement>().meUser!.id, context)
        .then((value) {
      if (mounted) {
        actualData = [
          ...context
              .read<AnalysisManagement>()
              .actualData15
              .entries
              .map((e) => e.value)
              .toList(),
        ];
        setState(() {});

        predictedData = [
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          context
              .read<AnalysisManagement>()
              .actualData15
              .entries
              .map((e) => e.value).last,
          ...context
              .read<AnalysisManagement>()
              .predictedData15
              .entries
              .map((e) => e.value)
              .toList(),
        ];
        setState(() {});

        lastMonth = [
          ...context
              .read<AnalysisManagement>()
              .lastMonthData30
              .entries
              .map((e) => e.value)
              .toList(),
        ];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              show: true,
              spots: predictedData
                  .asMap()
                  .entries
                  .map((content) =>
                  FlSpot(content.key + 1.0, content.value + 10000.0))
                  .toList(),
              dashArray: [5],
              isCurved: false,
              colors: [
                Colors.transparent,
                Colors.transparent,
                context.watch<ThemeManagement>().isDark ? Colors.white: Colors.black,
                context.watch<ThemeManagement>().isDark ? Colors.white: Colors.black,
              ],
              colorStops: [0, 0.48, 0.48, 1],
              belowBarData: BarAreaData(
                show: true,
                gradientFrom: const Offset(0, 0.5, ),
                gradientTo: const Offset(1, 0.5, ),
                colors: [
                  Colors.transparent,
                  Colors.transparent,

                   context.watch<ThemeManagement>().isDark ? Colors.white.withOpacity(0.1): Colors.black.withOpacity(0.1),
                  context.watch<ThemeManagement>().isDark ? Colors.white.withOpacity(0.1): Colors.black.withOpacity(0.1),
                ],
                // applyCutOffY: true,
                // cutOffY: 0.6,
                gradientColorStops: [0, 0.48, 0.48, 1],
              ),
              dotData: FlDotData(
                show: false,
              ),

            ),
            LineChartBarData(
              show: true,
              barWidth: 1,
              spots: actualData
                  .asMap()
                  .entries
                  .map((content) =>
                  FlSpot(content.key + 1.0, content.value + 10000.0))
                  .toList(),
              isCurved: false,
              colors: [
                context.watch<ThemeManagement>().lineChartColorActualOpacity7.withOpacity(0.3),
                context.watch<ThemeManagement>().lineChartColorActualOpacity7.withOpacity(0.3),
                Colors.transparent,
                Colors.transparent,
                // const Color(0xff5A6FF0),
                // const Color(0xffC31FE6),
              ],
              belowBarData: BarAreaData(
                show: true,
                gradientFrom: const Offset(0, 0.5, ),
                gradientTo: const Offset(1, 0.5, ),
                colors: [
                  context.watch<ThemeManagement>().lineChartColorActualOpacity7,
                  context.watch<ThemeManagement>().lineChartColorActualOpacity7,
                  Colors.transparent,
                  Colors.transparent,
                ],
                // applyCutOffY: true,
                // cutOffY: 0.6,
                gradientColorStops: [0, 0.65, 0.65, 1],
              ),
              colorStops: [0, 0.65, 0.65, 1],
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              show: true,
              barWidth: 1,
              spots: lastMonth
                  .asMap()
                  .entries
                  .map((content) =>
                  FlSpot(content.key + 1.0, content.value + 10000.0))
                  .toList(),
              isCurved: false,
              colors: [
                // Colors.transparent
                context
                    .watch<ThemeManagement>()
                    .lineChartColorPredicted.withOpacity(0.5)
                // const Color(0xff5A6FF0),
                // const Color(0xffC31FE6),
              ],
              belowBarData: BarAreaData(
                show: false,
                gradientFrom: const Offset(0, 1),
                gradientTo: const Offset(0, 0),
                colors: [
                  Colors.transparent,
                  context
                      .watch<ThemeManagement>()
                      .lineChartColorPredictedOpacity5,
                ],
              ),
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: false,
            ),
            leftTitles: SideTitles(
              showTitles: false,
              interval: 10000,
            ),
          ),
          axisTitleData: FlAxisTitleData(
            leftTitle: AxisTitle(showTitle: false),
            bottomTitle: AxisTitle(
              showTitle: false,
            ),
          ),
          gridData: FlGridData(
            show: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),
        ),

        swapAnimationDuration: const Duration(milliseconds: 400),
        swapAnimationCurve: Curves.ease,
      ),
    );
  }
}
