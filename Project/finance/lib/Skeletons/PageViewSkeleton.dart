import 'package:finance/Skeletons/CategorySkeleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/ThemeManagement.dart';

class PageViewSkeleton extends StatelessWidget {
  const PageViewSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        ...["", "", "", "", "", ""]
            .map(
              (e) => SingularCategorySkeleton(),
            )
            .toList(),
        Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 12, top: 6, bottom: 12),
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
      ],
    );
  }
}
