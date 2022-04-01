import 'package:finance/Entities/transaction.dart';
import 'package:finance/EntityServices/RelatedWordService.dart';
import 'package:finance/EntityServices/categoryService.dart';
import 'package:finance/EntityServices/transactionService.dart';
import 'package:finance/database.dart';
import 'package:finance/Screens/TransactionsScreen/singular_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/LogInManagement.dart';
import '../../Providers/ThemeManagement.dart';
import '../../Skeletons/TransactionSkeleton.dart';
import 'AddTransaction/add_transaction.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String dropDownValue = "All";
  bool isDisabled = false;

  refreshTransaction() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.watch<ThemeManagement>().containerColors,
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Transactions",
                      style: TextStyle(
                        color: context.watch<ThemeManagement>().allTextColor,
                      ),
                    ),
                  ),
                  DropdownButton(
                    onChanged: (_value) {
                      setState(() {
                        dropDownValue = _value.toString();
                      });
                    },
                    value: dropDownValue,
                    dropdownColor:
                        context.watch<ThemeManagement>().containerColors,
                    elevation: 0,
                    underline: Container(),
                    items: ["All", "Month", "Year", "Day"]
                        .map((e) => DropdownMenuItem(
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context
                                      .watch<ThemeManagement>()
                                      .allTextColor,
                                ),
                              ),
                              value: e,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 6),
              child: InkWell(
                onTap: () {
                  if (!isDisabled) {
                    setState(() {
                      isDisabled = true;
                    });
                    CategoryService()
                        .fetchCategorys(context.read<LogInManagement>().meUser!)
                        .then((value) {
                      RelatedWordService()
                          .fetchRelatedWords(
                              context.read<LogInManagement>().meUser!)
                          .then((relatedWords) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return AddTransaction(value, relatedWords, refreshTransaction);
                        }));
                        setState(() {
                          isDisabled = false;
                        });
                      });
                    });
                  }
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
                    child: Icon(
                      Icons.add,
                      color: context.watch<ThemeManagement>().allIconColor,
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: TransactionService().fetchTransactions(
                  dropDownValue, context.read<LogInManagement>().meUser!),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Transaction> transactions = snapshot.data;
                  return Column(
                    children: transactions
                        .map((e) => SingularTransaction(e))
                        .toList(),
                  );
                }
                return Column(
                  children: ["", "", "", "", "", "", "", "", "", "", "", ""]
                      .map((e) => SingularTransactionSkeleton())
                      .toList(),
                );
              },
            ),
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
