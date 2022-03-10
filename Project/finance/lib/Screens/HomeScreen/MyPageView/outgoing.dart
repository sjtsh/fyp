import 'package:finance/Entities/category.dart';
import 'package:finance/Screens/CategoryScreen/AddCategory/add_category.dart';
import 'package:finance/Screens/HomeScreen/MyPageView/singular_category.dart';
import 'package:finance/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/ThemeManagement.dart';

class Outgoing extends StatelessWidget {
  final List<Category> categories;
  final Function refreshCategories;

  Outgoing(this.categories, this.refreshCategories,);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        ...categories
            .where((element) => element.isExpense)
            .map(
              (e) => SingularCategory(e),
            )
            .toList(),
        Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 12, top: 6, bottom: 12),
          child: GestureDetector(
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
              child:  Center(
                child: Icon(Icons.add, color: context.watch<ThemeManagement>().allIconColor,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
