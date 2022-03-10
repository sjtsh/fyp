import 'package:finance/ChartScreen/pie_chart.dart';
import 'package:finance/ChartScreen/radar_chart.dart';
import 'package:finance/Header/header.dart';
import 'package:finance/Header/header2.dart';
import 'package:finance/Providers/ThemeManagement.dart';
import 'package:finance/Screens/HomeScreen/Chart/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeManagement>().background,
      body: ListView(
        children: [
          const Header2(),
          const SizedBox(
            height: 6,
          ),
          Center(
            child: Text(
              "Predicted vs Actual (This Month)",
              style: TextStyle(
                  color: context.watch<ThemeManagement>().allTextColor),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: Container(
              decoration: BoxDecoration(
                color: context.watch<ThemeManagement>().containerColors,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: const LineChart(),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
              child: Text(
            "Category Wise (This Month)",
            style:
                TextStyle(color: context.watch<ThemeManagement>().allTextColor),
          )),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: Container(
              decoration: BoxDecoration(
                color: context.watch<ThemeManagement>().containerColors,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: const PieChartPersonal(),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
              child: Text(
            "Expenses, Incomes and Savings",
            style:
                TextStyle(color: context.watch<ThemeManagement>().allTextColor),
          )),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: Container(
              decoration: BoxDecoration(
                color: context.watch<ThemeManagement>().containerColors,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: RadarChartPersonal(),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
