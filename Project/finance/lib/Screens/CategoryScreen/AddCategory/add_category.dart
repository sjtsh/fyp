import 'package:finance/EntityServices/categoryService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/LogInManagement.dart';
import '../../../Providers/ThemeManagement.dart';

class AddCategory extends StatefulWidget {
  final Function refreshCategories;

  AddCategory(this.refreshCategories);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool isExpense = true;
  bool isNameEmpty = false;
  bool disabled = false;
  TextEditingController nameController = TextEditingController();
  List<TextEditingController> relatedWords =
      List.generate(3, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeManagement>().background,
      body: Column(children: [
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
                  "Add Category",
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
                )),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color: context.watch<ThemeManagement>().textfieldBackgroundColor,
              // color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: nameController,
              autofocus: false,
              style: TextStyle(
                  color: context.watch<ThemeManagement>().allTextColor),
              decoration: InputDecoration(
                hintText: "Category Name",
                hintStyle: TextStyle(
                  color: context.watch<ThemeManagement>().allTextColorOpacity5,
                ),
                fillColor: Colors.green,
                enabledBorder: isNameEmpty
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12))
                    : InputBorder.none,
                focusedBorder: isNameEmpty
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12))
                    : InputBorder.none,
                border: isNameEmpty
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12))
                    : InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isExpense = true;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: isExpense ? Colors.red : context.watch<ThemeManagement>().containerColors,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                color: isExpense
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
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isExpense = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: !isExpense
                            ? Colors.green
                            : context.watch<ThemeManagement>().containerColors,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: isExpense
                                    ? context
                                        .watch<ThemeManagement>()
                                        .allTextColor
                                    : Colors.white,
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "Add related words",
                    style: TextStyle(
                      color: context.watch<ThemeManagement>().allTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            relatedWords.add(TextEditingController());
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: context
                                .watch<ThemeManagement>()
                                .textfieldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12),
                            child: Icon(
                              Icons.add,
                              color:
                                  context.watch<ThemeManagement>().allIconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: relatedWords
                          .asMap()
                          .entries
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 6, bottom: 6, right: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: context
                                            .watch<ThemeManagement>()
                                            .textfieldBackgroundColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            topLeft: Radius.circular(12)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: TextField(
                                          controller: e.value,
                                          autofocus: false,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: context
                                                  .watch<ThemeManagement>()
                                                  .allTextColor),
                                          decoration: InputDecoration(
                                            hintText: "Related Word",
                                            hintStyle: TextStyle(
                                              color: context
                                                  .watch<ThemeManagement>()
                                                  .allTextColorOpacity5,
                                            ),
                                            fillColor: Colors.green,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color:
                                          isExpense ? Colors.red : Colors.green,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12)),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          relatedWords.removeAt(e.key);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 6.0),
          child: AnimatedContainer(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isExpense ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(milliseconds: 200),
            child: MaterialButton(
              minWidth: double.infinity,
              onPressed: () {
                if (!disabled) {
                  setState(() {
                    disabled = true;
                  });
                  int counter = 0;
                  for (var element in relatedWords) {
                    if (element.text != "") {
                      counter++;
                    }
                    if (counter == 3) {
                      break;
                    }
                  }
                  if (nameController.text != "") {
                    setState(() {
                      isNameEmpty = false;
                    });
                  } else {
                    setState(() {
                      isNameEmpty = true;
                    });
                  }
                  if (counter < 3) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please type 3 or more related words"),
                      ),
                    );
                  } else if (!isNameEmpty) {
                    List<TextEditingController> relatedWordsFiltered =
                        relatedWords
                            .where((element) => element.text != "")
                            .toList();
                    CategoryService()
                        .createCategory(
                      name: nameController.text,
                      isExpense: isExpense,
                      words: List.generate(
                        relatedWordsFiltered.length,
                        (index) => relatedWordsFiltered[index].text,
                      ),
                      meUser: context.read<LogInManagement>().meUser!,
                    )
                        .then((value) {
                      setState(() {
                        disabled = false;
                      });
                      widget.refreshCategories();

                      Navigator.pop(context);
                    });
                  }
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
