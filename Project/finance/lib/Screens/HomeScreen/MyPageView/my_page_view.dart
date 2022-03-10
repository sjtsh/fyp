import 'package:finance/Entities/category.dart';
import 'package:finance/EntityServices/categoryService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Providers/LogInManagement.dart';
import '../../../Providers/ThemeManagement.dart';
import '../../../Skeletons/PageViewSkeleton.dart';
import '../../../database.dart';
import 'incoming.dart';
import 'outgoing.dart';

class MyPageView extends StatefulWidget {
  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  bool isIncoming = false;
  PageController pageController = PageController();

  refreshCategories() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, right: 12, left: 12),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pageController.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.watch<ThemeManagement>().containerColors,
                          border: Border(
                            bottom: BorderSide(
                              color: !isIncoming
                                  ? context
                                      .watch<ThemeManagement>()
                                      .lineChartColorActual
                                  : context
                                      .watch<ThemeManagement>()
                                      .lineChartColorActual
                                      .withOpacity(0.1),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "Expenses",
                              style: TextStyle(
                                color: !isIncoming
                                    ? context
                                        .watch<ThemeManagement>()
                                        .allTextColor
                                    : context
                                        .watch<ThemeManagement>()
                                        .allTextColorOpacity1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.watch<ThemeManagement>().containerColors,
                          border: Border(
                            bottom: BorderSide(
                              color: isIncoming
                                  ? context
                                      .watch<ThemeManagement>()
                                      .lineChartColorPredicted
                                  : context
                                      .watch<ThemeManagement>()
                                      .lineChartColorPredicted
                                      .withOpacity(0.1),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "Incomes",
                              style: TextStyle(
                                color: isIncoming
                                    ? context.watch<ThemeManagement>().allTextColor
                                    : context.watch<ThemeManagement>().allTextColorOpacity1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                  future: CategoryService()
                      .fetchCategorys(context.read<LogInManagement>().meUser!),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Category> allCategories = snapshot.data;
                      return Container(
                        height: (80 +
                                    allCategories
                                            .where(
                                                (element) => !element.isExpense)
                                            .length *
                                        62) >
                                (80 +
                                    allCategories
                                            .where(
                                                (element) => element.isExpense)
                                            .length *
                                        62)
                            ? (80 +
                                allCategories
                                        .where((element) => !element.isExpense)
                                        .length *
                                    62)
                            : (80 +
                                allCategories
                                        .where((element) => element.isExpense)
                                        .length *
                                    62),
                        color: context.watch<ThemeManagement>().containerColors,
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (int i) {
                            setState(() {
                              if (i == 0) {
                                isIncoming = false;
                              } else {
                                isIncoming = true;
                              }
                            });
                          },
                          children: [
                            Outgoing(allCategories, refreshCategories),
                            Incoming(allCategories, refreshCategories),
                          ],
                        ),
                      );
                    }
                    return Container(
                    color: context.watch<ThemeManagement>().containerColors,
                      height: 460,
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (int i) {
                          setState(() {
                            if (i == 0) {
                              isIncoming = false;
                            } else {
                              isIncoming = true;
                            }
                          });
                        },
                        children: [
                          PageViewSkeleton(),
                          PageViewSkeleton(),
                        ],
                      ),
                    );
                  })
            ],
          )),
    );
  }
}
