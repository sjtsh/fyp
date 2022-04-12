import 'package:finance/ChartScreen/chart_screen.dart';
import 'package:finance/Providers/ThemeManagement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/AnalysisManagement.dart';
import 'Chart/line_chart.dart';
import 'MyPageView/my_page_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Material(
              color: context.watch<ThemeManagement>().containerColors,
              child: InkWell(
                  onTap: () {
                    if ((context
                                .read<AnalysisManagement>()
                                .actualData15
                                .values)
                            .reduce((a, b) => a + b) !=
                        0)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return const ChartScreen();
                          },
                        ),
                      );
                  },
                  child: const LineChart()),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        MyPageView(),
      ],
    );
  }
}
