import 'package:finance/EntityServices/categoryService.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
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
              icon: Icon(Icons.arrow_back_ios_rounded),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "Add Category",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
              color: const Color(0xffE9E9E9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: nameController,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Category Name",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
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
                    color: isExpense ? Colors.red : Colors.white,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isExpense = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            "Expense",
                            style: TextStyle(
                              color: isExpense ? Colors.white : Colors.black,
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
                    color: !isExpense ? Colors.green : Colors.white,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isExpense = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            "Income",
                            style: TextStyle(
                              color: !isExpense ? Colors.white : Colors.black,
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "Add related words",
                    style: TextStyle(
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
                            color: const Color(0xffE9E9E9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12),
                            child: Icon(
                              Icons.add,
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
                                        color: const Color(0xffE9E9E9),
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
                                          style: const TextStyle(fontSize: 12),
                                          decoration: InputDecoration(
                                            hintText: "Related Word",
                                            hintStyle: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                            fillColor: Colors.green,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
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
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isExpense ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
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
                    )
                        .then((value) {
                      setState(() {
                        disabled = false;
                      });
                      Navigator.pop(context);
                    });
                  }
                }
              },
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
