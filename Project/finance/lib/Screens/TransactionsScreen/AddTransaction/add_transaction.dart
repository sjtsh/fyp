import 'package:finance/Entities/category.dart';
import 'package:finance/EntityServices/transactionService.dart';
import 'package:finance/Screens/CategoryScreen/AddCategory/add_category.dart';
import 'package:finance/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/LogInManagement.dart';
import '../../../Providers/ThemeManagement.dart';

class AddTransaction extends StatefulWidget {
  final List<Category> categories;
  final Function refreshTransaction;

  AddTransaction(
    this.categories,
    this.refreshTransaction,
  );

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  Category? dropDownValue;
  bool isDisabled = false;
  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isRemarkEmpty = false;
  bool isAmountEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeManagement>().background,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: context.watch<ThemeManagement>().allIconColor,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: context.watch<ThemeManagement>().allTextColor,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      context.watch<ThemeManagement>().textfieldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  maxLines: 100,
                  controller: remarkController,
                  autofocus: false,
                  style: TextStyle(
                    color: context.watch<ThemeManagement>().allTextColor,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    hintText: "Remark",
                    hintStyle: TextStyle(
                      color:
                          context.watch<ThemeManagement>().allTextColorOpacity5,
                    ),
                    fillColor: Colors.red,
                    enabledBorder: isRemarkEmpty
                        ? OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12))
                        : InputBorder.none,
                    focusedBorder: isRemarkEmpty
                        ? OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12))
                        : InputBorder.none,
                    border: isRemarkEmpty
                        ? OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12))
                        : InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color:
                    context.watch<ThemeManagement>().textfieldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                autofocus: false,
                style: TextStyle(
                  color: context.watch<ThemeManagement>().allTextColor,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: "Amount",
                  hintStyle: TextStyle(
                    color:
                        context.watch<ThemeManagement>().allTextColorOpacity5,
                  ),
                  fillColor: Colors.green,
                  enabledBorder: isAmountEmpty
                      ? OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12))
                      : InputBorder.none,
                  focusedBorder: isAmountEmpty
                      ? OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12))
                      : InputBorder.none,
                  border: isAmountEmpty
                      ? OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12))
                      : InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: context.watch<ThemeManagement>().containerColors,
                    ),
                    child: DropdownButton(
                      dropdownColor:
                          context.watch<ThemeManagement>().containerColors,
                      onChanged: (i) {
                        setState(() {
                          dropDownValue = i as Category;
                        });
                      },
                      underline: Container(),
                      value: dropDownValue,
                      items: widget.categories
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  e.name,
                                  style: TextStyle(
                                    color: context
                                        .watch<ThemeManagement>()
                                        .allTextColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: (dropDownValue?.isExpense ?? true)
                          ? Colors.red
                          : Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return AddCategory(() {});
                              },
                            ),
                          );
                        },
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: (dropDownValue?.isExpense ?? true)
                            ? Colors.red
                            : context.watch<ThemeManagement>().containerColors,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                color: (dropDownValue?.isExpense ?? true)
                                    ? Colors.white
                                    : context
                                        .watch<ThemeManagement>()
                                        .allTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: !(dropDownValue?.isExpense ?? true)
                            ? Colors.green
                            : context.watch<ThemeManagement>().containerColors,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: !(dropDownValue?.isExpense ?? true)
                                    ? Colors.white
                                    : context
                                        .watch<ThemeManagement>()
                                        .allTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12, right: 12, bottom: 12.0, top: 6),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: (dropDownValue?.isExpense ?? true)
                    ? Colors.red
                    : Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  remarkController.text == ""
                      ? setState(() => isRemarkEmpty = true)
                      : setState(() => isRemarkEmpty = false);
                  amountController.text == ""
                      ? setState(() => isAmountEmpty = true)
                      : setState(() => isAmountEmpty = false);
                  if (!isRemarkEmpty && !isAmountEmpty && dropDownValue!=null) {
                    setState(() {
                      isDisabled = true;
                    });
                    TransactionService()
                        .createTransaction(
                      categoryID: dropDownValue?.id ?? 0,
                      remark: remarkController.text,
                      amount: double.parse(amountController.text),
                      meUser: context.read<LogInManagement>().meUser!,
                    )
                        .then((value) {
                      if (dropDownValue!.isExpense) {
                        context.read<LogInManagement>().meUser?.bankBalance -=
                            double.parse(amountController.text);
                        context.read<LogInManagement>().userChange();
                      } else {
                        context.read<LogInManagement>().meUser?.bankBalance +=
                            double.parse(amountController.text);
                        context.read<LogInManagement>().userChange();
                      }
                      setState(() {
                        isDisabled = false;
                      });
                      widget.refreshTransaction();
                      Navigator.pop(context);
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 6,),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
