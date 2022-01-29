import 'package:finance/Entities/category.dart';
import 'package:finance/Entities/users.dart';
import 'package:finance/EntityServices/categoryService.dart';
import 'package:finance/Screens/HomeScreen/MyPageView/singular_category.dart';
import 'package:finance/database.dart';
import 'package:flutter/material.dart';

import 'AddCategory/add_category.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
          child: Container(
            height: 80,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: Row(
                      children: [
                        const Text("Target Saving"),
                        Expanded(child: Container()),
                        Text(
                          "\$${meUser!.monthlyTargetSaving}",
                          style: TextStyle(color: Color(0xff0B8B00)),
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
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "\$2${meUser!.bankBalance}",
                          style: TextStyle(
                              color: const Color(0xff0B8B00).withOpacity(0.5)),
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12, top: 12, bottom: 6),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return AddCategory();
                          },
                        ),
                      );
                    },
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
                ),
                FutureBuilder(
                  future: CategoryService().fetchCategorys(),
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
                    return const Center(
                      child: CircularProgressIndicator(),
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
