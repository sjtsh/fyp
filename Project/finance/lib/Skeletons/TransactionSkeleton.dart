import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Providers/ThemeManagement.dart';

class SingularTransactionSkeleton extends StatelessWidget {
  const SingularTransactionSkeleton({Key? key}) : super(key: key);

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
              color: Colors.grey,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 5,
                      width: 40,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Text(
              //   "\$${addCommas(transaction.amount)}",
              //   style: TextStyle(
              //     color: transaction.isExpense
              //         ? const Color(0xffFF0000)
              //         : const Color(0xff0B8B00),
              //   ),
              // ),

              Container(
                height: 10,
                width: 50,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 6,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "icons/up.svg",
                    color: Colors.grey,
                  ),
                  SvgPicture.asset(
                    "icons/down.svg",
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
