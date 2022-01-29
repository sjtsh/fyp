import 'package:finance/Entities/transaction.dart';
import 'package:finance/EntityServices/categoryService.dart';
import 'package:finance/EntityServices/transactionService.dart';
import 'package:finance/database.dart';
import 'package:finance/Screens/TransactionsScreen/singular_transaction.dart';
import 'package:flutter/material.dart';

import 'AddTransaction/add_transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String dropDownValue = "All";
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Transactions",
                    ),
                  ),
                  DropdownButton(
                    onChanged: (_value) {
                      setState(() {
                        dropDownValue = _value.toString();
                      });
                    },
                    value: dropDownValue,
                    elevation: 0,
                    underline: Container(),
                    items: ["All", "Month", "Year", "Day"]
                        .map((e) => DropdownMenuItem(
                              child: Text(e, style: TextStyle(fontSize: 14)),
                              value: e,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 6),
              child: Material(
                child: InkWell(
                  onTap: () {
                    if (!isDisabled) {
                      setState(() {
                        isDisabled = true;
                      });
                      CategoryService().fetchCategorys().then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return AddTransaction(value);
                        }));
                        setState(() {
                          isDisabled = false;
                        });
                      });
                    }
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
            ),
            FutureBuilder(
              future: TransactionService().fetchTransactions(dropDownValue),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Transaction> transactions = snapshot.data;
                  return Column(
                    children: transactions
                        .map((e) => SingularTransaction(e))
                        .toList(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
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
