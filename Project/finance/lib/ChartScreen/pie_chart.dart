import 'package:finance/Entities/category.dart';
import 'package:finance/EntityServices/categoryService.dart';
import 'package:finance/database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

class PieChartPersonal extends StatefulWidget {
  const PieChartPersonal({Key? key}) : super(key: key);

  @override
  State<PieChartPersonal> createState() => _PieChartPersonalState();
}

class _PieChartPersonalState extends State<PieChartPersonal> {
  List<List> pieListCategories = [[], [], []];
  List pieListCategories1 = [];
  List colors = [
    const Color(0xffC31FE6),
    const Color(0xff3A57E8),
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CategoryService().fetchCategorys(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Category> allCategories = snapshot.data;
            pieListCategories = [[], [], []];
            pieListCategories1 = [];
            allCategories
                .where((element) => element.isExpense)
                .toList()
                .sublist(0, 2)
                .forEach((element) {
              pieListCategories[0].add([element.name, element.amount]);
              pieListCategories1.add([element.name, element.amount]);
            });
            allCategories
                .where((element) => element.isExpense)
                .toList()
                .sublist(2, 4)
                .forEach((element) {
              pieListCategories[1].add([element.name, element.amount]);
              pieListCategories1.add([element.name, element.amount]);
            });
            pieListCategories[2].add([
              allCategories
                  .where((element) => element.isExpense)
                  .toList()[4]
                  .name,
              allCategories
                  .where((element) => element.isExpense)
                  .toList()[4]
                  .amount
            ]);
            pieListCategories1.add([
              allCategories
                  .where((element) => element.isExpense)
                  .toList()[4]
                  .name,
              allCategories
                  .where((element) => element.isExpense)
                  .toList()[4]
                  .amount
            ]);
            double othersTotal = 0;
            allCategories.sublist(5, allCategories.length).forEach((element) {
              othersTotal += element.amount;
            });
            pieListCategories[2].add(["others", othersTotal]);
            pieListCategories1.add(["others", othersTotal]);
            return SizedBox(
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
                      children: pieListCategories
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
                                            decoration: BoxDecoration(
                                              color: colors[pieListCategories1
                                                  .indexOf(pieListCategories1
                                                      .firstWhere((element) =>
                                                          element[0] ==
                                                          aRow[0]))],
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            aRow[0],
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 10,
                                            ),
                                          ),
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
                          sections: pieListCategories1
                              .map(
                                (e) => PieChartSectionData(
                                    showTitle: false,
                                    titleStyle: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                    radius: 100,
                                    color:
                                        colors[pieListCategories1.indexOf(e)],
                                    value: e[1] + 0.0),
                              )
                              .toList(),
                        ),
                        swapAnimationDuration:
                            const Duration(milliseconds: 150),
                        swapAnimationCurve: Curves.linear,
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
