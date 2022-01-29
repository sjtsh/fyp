import 'package:finance/Entities/category.dart';
import 'package:finance/EntityServices/transactionService.dart';
import 'package:finance/Screens/CategoryScreen/AddCategory/add_category.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  List<Category> categories;

  AddTransaction(this.categories);

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
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownValue = widget.categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
              Expanded(
                child: Center(
                  child: const Text(
                    "Add Transaction",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                  color: const Color(0xffE9E9E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  maxLines: 100,
                  controller: remarkController,
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.0),
                    hintText: "Remark",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffE9E9E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: "Amount",
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffe9e9e9),
                  ),
                  child: DropdownButton(
                    dropdownColor: const Color(0xffe9e9e9),
                    onChanged: (i) {
                      setState(() {
                        dropDownValue = i as Category;
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    underline: Container(),
                    value: dropDownValue,
                    items: widget.categories
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: SizedBox(
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Text(e.name),
                                    Expanded(child: Container()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Expanded(
                  child: Container(
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
                                return AddCategory();
                              },
                            ),
                          );
                        },
                        child: const Icon(Icons.add, color: Colors.white),
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
                      color: (dropDownValue?.isExpense ?? true)
                          ? Colors.red
                          : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            "Expense",
                            style: TextStyle(
                              color: (dropDownValue?.isExpense ?? true)
                                  ? Colors.white
                                  : Colors.black,
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
                      color: !(dropDownValue?.isExpense ?? true)
                          ? Colors.green
                          : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            "Income",
                            style: TextStyle(
                              color: !(dropDownValue?.isExpense ?? true)
                                  ? Colors.white
                                  : Colors.black,
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
            child: Container(
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
                  if (!isRemarkEmpty && !isAmountEmpty) {
                    setState(() {
                      isDisabled = true;
                    });
                    TransactionService()
                        .createTransaction(
                      categoryID: dropDownValue?.id ?? 0,
                      remark: remarkController.text,
                      amount: double.parse(amountController.text),
                    )
                        .then((value) {
                      setState(() {
                        isDisabled = false;
                      });
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
