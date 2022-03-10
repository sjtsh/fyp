import 'package:finance/Entities/category.dart';
import 'package:finance/Screens/CategoryScreen/AddCategory/add_category.dart';
import 'package:finance/Screens/HomeScreen/MyPageView/singular_category.dart';
import 'package:finance/Screens/TransactionsScreen/singular_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/ThemeManagement.dart';
import '../../../database.dart';

class Incoming extends StatefulWidget {
  final List<Category> categories;
  final Function refreshCategories;

  Incoming(
    this.categories,
    this.refreshCategories,
  );

  @override
  State<Incoming> createState() => _IncomingState();
}

class _IncomingState extends State<Incoming> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        ...widget.categories
            .where((element) => !element.isExpense)
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
                    return AddCategory(widget.refreshCategories);
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
                child: Icon(Icons.add, color: context.watch<ThemeManagement>().allIconColor,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
