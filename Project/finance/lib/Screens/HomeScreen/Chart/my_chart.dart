import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BezierChartPersonal extends StatefulWidget {
  const BezierChartPersonal({Key? key}) : super(key: key);

  @override
  _BezierChartPersonalState createState() => _BezierChartPersonalState();
}

class _BezierChartPersonalState extends State<BezierChartPersonal> {
  List<int> actualData = [200, 20003, 19000, 30000, 30000, 20003, 20000, 35000];
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
                  Colors.white,
                  const Color(0xffC31FE6).withOpacity(0.5),
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
                  Colors.white,
                  const Color(0xff3A57E8).withOpacity(0.7),
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
        swapAnimationDuration: const Duration(milliseconds: 500), // Optional
        swapAnimationCurve: Curves.easeIn,
      ),
    );
  }
}
