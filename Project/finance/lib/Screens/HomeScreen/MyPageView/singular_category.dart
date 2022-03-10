import 'package:countup/countup.dart';
import 'package:finance/Entities/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/ThemeManagement.dart';
import '../../../methods.dart';

class SingularCategory extends StatelessWidget {
  final Category category;

  SingularCategory(this.category);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          color: category.isExceeded && !category.isExpense
              ? context.watch<ThemeManagement>().exceededIncomeColor
              : category.isExceeded && category.isExpense
                  ? context.watch<ThemeManagement>().exceededExpenseColor
                  : context.watch<ThemeManagement>().background,
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Icon(category.icon , color: context.watch<ThemeManagement>().allIconColor,),
            const SizedBox(width: 12),
            Text(
              category.name,
              style: TextStyle(
                  color: context.watch<ThemeManagement>().allTextColor),
            ),
            Expanded(child: Container()),
            // Text("\$${addCommas(category.amount)}"),
            Countup(
              begin: 0,
              end: category.amount,
              duration: Duration(milliseconds: 200),
              separator: ',',
              prefix: "\$",
              style: TextStyle(

                color: context.watch<ThemeManagement>().allTextColor,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
