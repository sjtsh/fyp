import 'package:finance/Entities/category.dart';
import 'package:finance/Screens/HomeScreen/MyPageView/singular_category.dart';
import 'package:finance/database.dart';
import 'package:flutter/material.dart';

class Outgoing extends StatelessWidget {
  List<Category> categories;

  Outgoing(this.categories);

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
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffF4F4F4),
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            child: const Center(
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
