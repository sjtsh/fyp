import 'package:finance/Entities/transaction.dart';
import 'package:finance/database.dart';
import 'package:finance/methods/getIconData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          color: const Color(0xffF4F4F4),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Icon(
              getIconData(transaction.category),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.remark,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    transaction.dateTime.toString().substring(0, 19),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "\$${transaction.amount.toStringAsFixed(0)}",
              style: TextStyle(
                color: transaction.isExpense
                    ? const Color(0xffFF0000)
                    : const Color(0xff0B8B00),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("icons/up.svg",
                    color: !transaction.isExpense
                        ? const Color(0xff0B8B00)
                        : Colors.black.withOpacity(0.1)),
                SvgPicture.asset(
                  "icons/down.svg",
                  color: transaction.isExpense
                      ? const Color(0xffFF0000)
                      : Colors.black.withOpacity(0.1),
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
