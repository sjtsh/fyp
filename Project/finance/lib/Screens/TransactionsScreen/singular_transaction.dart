import 'package:countup/countup.dart';
import 'package:finance/Entities/transaction.dart';
import 'package:finance/database.dart';
import 'package:finance/methods/getIconData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../Providers/ThemeManagement.dart';
import '../../methods.dart';

class SingularTransaction extends StatelessWidget {
  final Transaction transaction;

  SingularTransaction(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.watch<ThemeManagement>().background,
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Icon(
              getIconData(transaction.category), color: context.watch<ThemeManagement>().allIconColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.remark,
                    style: TextStyle(
                        color: context.watch<ThemeManagement>().allTextColor,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    transaction.dateTime.toString().substring(0, 19),
                    style: TextStyle(
                        color: context
                            .watch<ThemeManagement>()
                            .allTextColorOpacity5,
                        fontSize: 10),
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

            Countup(
              begin: 0,
              end: transaction.amount,
              duration: Duration(milliseconds: 200),
              separator: ',',
              style: TextStyle(
                color: !transaction.isExpense
                    ? context
                        .watch<ThemeManagement>()
                        .transactionExceededIncomeColor
                    : context
                        .watch<ThemeManagement>()
                        .transactionExceededExpenseColor,
              ),
              prefix: "\$",
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "icons/up.svg",
                  color: !transaction.isExpense
                      ? context
                          .watch<ThemeManagement>()
                          .transactionExceededIncomeColor
                      : context
                          .watch<ThemeManagement>()
                          .transactionNotExceededColor,
                ),
                SvgPicture.asset(
                  "icons/down.svg",
                  color: transaction.isExpense
                      ? context
                          .watch<ThemeManagement>()
                          .transactionExceededExpenseColor
                      : context
                          .watch<ThemeManagement>()
                          .transactionNotExceededColor,
                ),
              ],
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
