import 'package:finance/Entities/category.dart';
import 'package:finance/EntityServices/categoryService.dart';
import 'package:flutter/material.dart';

import '../../../database.dart';
import 'incoming.dart';
import 'outgoing.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  bool isIncoming = false;
  PageController pageController = PageController();

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
                          border: Border(
                            bottom: BorderSide(
                              color: !isIncoming
                                  ? const Color(0xff5A6FF0)
                                  : const Color(0xff5A6FF0).withOpacity(0.1),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("Expenses",
                                style: TextStyle(
                                    color: !isIncoming
                                        ? Colors.black
                                        : Colors.black.withOpacity(0.1))),
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
                          border: Border(
                            bottom: BorderSide(
                              color: isIncoming
                                  ? const Color(0xffC31FE6)
                                  : const Color(0xffC31FE6).withOpacity(0.1),
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
                                    ? Colors.black
                                    : Colors.black.withOpacity(0.1),
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
                  future: CategoryService().fetchCategorys(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Category> allCategories = snapshot.data;
                      return SizedBox(
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
                            Outgoing(allCategories),
                            Incoming(allCategories),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ],
          )),
    );
  }
}
