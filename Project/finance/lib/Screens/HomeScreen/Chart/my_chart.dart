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
  List<int> actualData = [0, 0, 0, 0, 0, 0, 0, 0];
  List<int> predictedData = [
    5000,
    25000,
    17000,
    40000,
    40000,
    17000,
    12000,
    21000
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RegressionService()
        .fetchLinearModels(context
        .read<LogInManagement>()
        .meUser!
        .id, context)
        .then((value) {
      actualData = context
          .read<AnalysisManagement>()
          .actualData15
          .entries
          .map((e) => e.value).toList();
      setState(() {});

      predictedData = context
          .read<AnalysisManagement>()
          .predictedData15
          .entries
          .map((e) => e.value).toList();
      setState(() {});
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
              barWidth: 50,
              spots: predictedData
                  .asMap()
                  .entries
                  .map((content) =>
                  FlSpot(content.key + 1.0, content.value + 0.0))
                  .toList(),
              isCurved: true,
              colors: [
                Colors.transparent
                // const Color(0xff5A6FF0),
                // const Color(0xffC31FE6),
              ],
              belowBarData: BarAreaData(
                show: true,
                gradientFrom: const Offset(0, 1),
                gradientTo: const Offset(0.5, 0),
                colors: [
                  context
                      .watch<ThemeManagement>()
                      .containerColors,
                  context
                      .watch<ThemeManagement>()
                      .lineChartColorPredictedOpacity5,
                ],
              ),
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: actualData
                  .asMap()
                  .entries
                  .map((content) =>
                  FlSpot(content.key + 1.0, content.value + 0.0))
                  .toList(),
              isCurved: true,
              colors: [
                Colors.transparent
                // const Color(0xff5A6FF0),
                // const Color(0xffC31FE6),
              ],
              belowBarData: BarAreaData(
                show: true,
                gradientFrom: const Offset(0, 1),
                gradientTo: const Offset(0, 0),
                colors: [
                  context
                      .watch<ThemeManagement>()
                      .containerColors,
                  context
                      .watch<ThemeManagement>()
                      .lineChartColorActualOpacity7,
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
