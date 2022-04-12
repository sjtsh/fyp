import 'package:finance/Entities/users.dart';
import 'package:finance/EntityServices/userService.dart';
import 'package:finance/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/LogInManagement.dart';
import '../../Providers/ThemeManagement.dart';

class TargetSavingScreen extends StatefulWidget {
  @override
  State<TargetSavingScreen> createState() => _TargetSavingScreenState();
}

class _TargetSavingScreenState extends State<TargetSavingScreen> {
  bool isTargetSavingEmpty = false;
  TextEditingController targetSavingController = TextEditingController();
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: context.watch<ThemeManagement>().background,
          child: Container(
            height: 150,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context
                            .watch<ThemeManagement>()
                            .textfieldBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: targetSavingController,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        autofocus: false,
                        style: TextStyle(color: context.watch<ThemeManagement>().allTextColor),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12.0),
                          hintText: "Bank balance",
                          hintStyle: TextStyle(
                            color:  context
                                .watch<ThemeManagement>()
                                .allTextColorOpacity5,
                          ),

                          fillColor: Colors.green,

                          enabledBorder: isTargetSavingEmpty
                              ? OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12))
                              : InputBorder.none,
                          focusedBorder: isTargetSavingEmpty
                              ? OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12))
                              : InputBorder.none,
                          border: isTargetSavingEmpty
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
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: MaterialButton(
                                onPressed: () async {
                                  if (targetSavingController.text != "") {
                                    setState(() {
                                      isDisabled = true;
                                    });
                                    context.read<LogInManagement>().meUser =
                                        await UserService().changeTargetSaving(
                                      monthlyTargetSaving: double.parse(
                                          targetSavingController.text),
                                      meUser: context
                                          .read<LogInManagement>()
                                          .meUser!,
                                    );
                                    context
                                        .read<LogInManagement>()
                                        .userChange();
                                    Navigator.pop(context);
                                    setState(() {
                                      isDisabled = false;
                                    });
                                  } else {
                                    setState(() {
                                      isTargetSavingEmpty = true;
                                    });
                                  }
                                },
                                child: isDisabled
                                    ? CircularProgressIndicator()
                                    : Text(
                                        "Confirm",
                                        style: TextStyle(
                                            color: Colors.white),
                                      )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
