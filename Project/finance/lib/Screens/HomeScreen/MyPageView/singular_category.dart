import 'package:finance/Entities/category.dart';
import 'package:flutter/material.dart';

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
          color: category.isExceeded && !category.isExpense
              ? const Color(0xffCBF8DD)
              : category.isExceeded && category.isExpense
                  ? const Color(0xffF8CBCB)
                  : const Color(0xffF4F4F4),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Icon(category.icon),
            const SizedBox(width: 12),
            Text(category.name),
            Expanded(child: Container()),
            Text("\$${category.amount.toStringAsFixed(0)}"),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
