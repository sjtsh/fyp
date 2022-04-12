import 'package:finance/EntityServices/correctionService.dart';
import 'package:finance/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/LogInManagement.dart';
import '../Providers/ThemeManagement.dart';

class CorrectionScreen extends StatefulWidget {
  @override
  State<CorrectionScreen> createState() => _CorrectionScreenState();
}

class _CorrectionScreenState extends State<CorrectionScreen> {
  bool isDisabled = false;
  bool isExpense = true;

  TextEditingController remarkController = TextEditingController();

  TextEditingController currentBalanceController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool isRemarkEmpty = false;

  bool isAmountEmpty = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<LogInManagement>().meUser != null) {
      currentBalanceController.text =
          context.read<LogInManagement>().meUser!.bankBalance.toString();
    }
  }

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
                icon: Icon(Icons.arrow_back_ios_rounded, color: context.watch<ThemeManagement>().allIconColor,),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Add Correction",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color:
                    context.watch<ThemeManagement>().textfieldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: currentBalanceController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                autofocus: false,
                onChanged: (String input) {
                  if (isExpense) {
                    amountController.text = (((context
                                    .read<LogInManagement>()
                                    .meUser
                                    ?.bankBalance) ??
                                0) -
                            (double.tryParse(input) ?? 0))
                        .toString();
                  } else {
                    amountController.text = ((double.tryParse(input) ?? 0) -
                            ((context
                                    .read<LogInManagement>()
                                    .meUser
                                    ?.bankBalance) ??
                                0))
                        .toString();
                  }
                  if ((double.tryParse(amountController.text) ?? 0) < 0) {
                    setState(() {
                      isExpense = !isExpense;
                    });
                    amountController.text =
                        (-1 * (double.tryParse(amountController.text) ?? 0))
                            .toString();
                  }
                  if ((double.tryParse(currentBalanceController.text) ?? 0) <
                      0) {
                    setState(() {
                      isExpense = true;
                    });
                    currentBalanceController.text = "0";
                    amountController.text =
                        (context.read<LogInManagement>().meUser?.bankBalance ??
                                0)
                            .toString();
                  }
                },
                style: TextStyle(color: context.watch<ThemeManagement>().allTextColor),
                decoration: InputDecoration(

                  label: Text("Bank Balance",
                      style: TextStyle(color: context.watch<ThemeManagement>().allTextColor),),
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: "BankBalance",
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color:
                    context.watch<ThemeManagement>().textfieldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: amountController,
                style: TextStyle(color: context.watch<ThemeManagement>().allTextColor),
                onChanged: (String input) {
                  if (isExpense) {
                    currentBalanceController.text = (((context
                                    .read<LogInManagement>()
                                    .meUser
                                    ?.bankBalance) ??
                                0) -
                            (double.tryParse(input) ?? 0))
                        .toString();
                  } else {
                    currentBalanceController.text = (((context
                                    .read<LogInManagement>()
                                    .meUser
                                    ?.bankBalance) ??
                                0) +
                            (double.tryParse(input) ?? 0))
                        .toString();
                  }
                  if ((double.tryParse(amountController.text) ?? 0) < 0) {
                    setState(() {
                      isExpense = !isExpense;
                    });
                    amountController.text =
                        (-1 * (double.tryParse(amountController.text) ?? 0))
                            .toString();
                  }
                  if ((double.tryParse(currentBalanceController.text) ?? 0) <
                      0) {
                    setState(() {
                      isExpense = true;
                    });
                    currentBalanceController.text = "0";
                    amountController.text =
                        (context.read<LogInManagement>().meUser?.bankBalance ??
                                0)
                            .toString();
                  }
                },
                keyboardType: TextInputType.number,
                maxLines: 1,
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12.0),
                  label: Text("Correction",
                    style: TextStyle(color: context.watch<ThemeManagement>().allTextColor),),
                  hintText: "Correction",
                  hintStyle: TextStyle(
                    color: context.watch<ThemeManagement>().allTextColorOpacity5
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
                  style: TextStyle(color: context.watch<ThemeManagement>().allTextColor),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    hintText: "Remark",
                    hintStyle: TextStyle(
                      color: context.watch<ThemeManagement>().allTextColorOpacity5,
                    ),
                    fillColor: Colors.green,
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpense = true;
                        currentBalanceController.text = ((context
                                        .read<LogInManagement>()
                                        .meUser
                                        ?.bankBalance ??
                                    0) -
                                ((double.tryParse(amountController.text) ?? 0)))
                            .toString();
                      });
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        child: AnimatedContainer(
                          color: isExpense ? Colors.red: context.watch<ThemeManagement>().containerColors,
                          duration: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpense = false;
                        currentBalanceController.text = ((context
                                        .read<LogInManagement>()
                                        .meUser
                                        ?.bankBalance ??
                                    0) +
                                ((double.tryParse(amountController.text) ?? 0)))
                            .toString();
                      });
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        child: AnimatedContainer(
                          color: !isExpense ? Colors.green : context.watch<ThemeManagement>().containerColors,
                          duration: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
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
                color: isExpense ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: () async {
                  remarkController.text == ""
                      ? setState(() => isRemarkEmpty = true)
                      : setState(() => isRemarkEmpty = false);
                  amountController.text == ""
                      ? setState(() => isAmountEmpty = true)
                      : setState(() => isAmountEmpty = false);
                  if (isRemarkEmpty || isAmountEmpty) {
                    setState(() {
                      isDisabled = true;
                    });
                  }

                  if (!isDisabled) {
                    setState(() {
                      isDisabled = true;
                    });
                    bool wasSuccess = await CorrectionService()
                        .createCorrection(
                            remark: remarkController.text,
                            amount: isExpense
                                ? "-" + amountController.text
                                : amountController.text,
                            meUser: context.read<LogInManagement>().meUser!);
                    if (wasSuccess) {
                      if (isExpense) {
                        context.read<LogInManagement>().meUser?.bankBalance -=
                            double.parse(amountController.text);
                        context.read<LogInManagement>().userChange();
                      } else {
                        context.read<LogInManagement>().meUser?.bankBalance +=
                            double.parse(amountController.text);
                        context.read<LogInManagement>().userChange();
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Correction was made"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Correction couldnt be made"),
                        ),
                      );
                    }
                  }

                  setState(() {
                    isDisabled = false;
                  });
                },
                child: !isDisabled
                    ? Text(
                        "Add",
                        style: TextStyle(color: Colors.white,),
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
