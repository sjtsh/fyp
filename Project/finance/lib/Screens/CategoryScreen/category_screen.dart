import 'package:countup/countup.dart';
import 'package:finance/Entities/category.dart';
import 'package:finance/Entities/users.dart';
import 'package:finance/EntityServices/categoryService.dart';
import 'package:finance/Screens/HomeScreen/MyPageView/singular_category.dart';
import 'package:finance/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/LogInManagement.dart';
import '../../Providers/ThemeManagement.dart';
import '../../Skeletons/CategorySkeleton.dart';
import '../../methods.dart';
import 'AddCategory/add_category.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  refreshCategories() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
          child: Container(
            height: 80,
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
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: Row(
                      children: [
                        Text(
                          "Target Saving",
                          style: TextStyle(
                            color:
                                context.watch<ThemeManagement>().allTextColor,
                          ),
                        ),
                        Expanded(child: Container()),
                        // Text(
                        //   "\$${addCommas(meUser!.monthlyTargetSaving)}",
                        //   style: TextStyle(color: Color(0xff0B8B00)),
                        // ),

                        Countup(
                          begin: 0,
                          end: context
                              .watch<LogInManagement>()
                              .meUser!
                              .monthlyTargetSaving,
                          duration: Duration(milliseconds: 200),
                          separator: ',',
                          style: TextStyle(
                              color: context
                                  .watch<ThemeManagement>()
                                  .monthlyTargetSavingText),
                          prefix: "\$",
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: Row(
                      children: [
                        Text(
                          "Bank Balance",
                          style:
                              TextStyle(
                              color: context.watch<ThemeManagement>().allTextColorOpacity5),
                        ),
                        Expanded(child: Container()),
                        Countup(
                          begin: 0,
                          end: context
                              .watch<LogInManagement>()
                              .meUser!
                              .bankBalance,
                          duration: Duration(milliseconds: 200),
                          separator: ',',
                          style: TextStyle(
                              color: context
                                  .watch<ThemeManagement>()
                                  .monthlyTargetSavingTextOpacity5),
                          prefix: "\$",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 6.0, left: 12, right: 12, bottom: 6),
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12, top: 12, bottom: 6),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return AddCategory(refreshCategories);
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: context.watch<ThemeManagement>().background,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: context.watch<ThemeManagement>().allIconColor,
                        ),
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: CategoryService()
                      .fetchCategorys(context.read<LogInManagement>().meUser!),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Category> allCategories = snapshot.data;
                      allCategories
                          .sort((a, b) => b.amount.compareTo(a.amount));
                      return Column(
                        children: allCategories
                            .map((e) => SingularCategory(e))
                            .toList(),
                      );
                    }
                    return Column(
                      children: ["", "", "", "", "", ""]
                          .map((e) => SingularCategorySkeleton())
                          .toList(),
                    );
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
