import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Providers/ThemeManagement.dart';

class SingularCategorySkeleton extends StatelessWidget {
  const SingularCategorySkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: context.watch<ThemeManagement>().shimmerGradient,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                color: Colors.grey,
                width: 100,
                height: 10,
              ),
              Expanded(child: Container()),
              // Text("\$${addCommas(category.amount)}"),
              Container(
                color: Colors.grey,
                width: 50,
                height: 10,
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
