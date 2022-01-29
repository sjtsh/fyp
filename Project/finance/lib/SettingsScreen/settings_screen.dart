import 'package:finance/Entities/users.dart';
import 'package:finance/EntityServices/userService.dart';
import 'package:finance/Header/header2.dart';
import 'package:finance/PinCodeScreen/pin_code_screen.dart';
import 'package:finance/SettingsScreen/Dialogs/deactivate_account_dialog.dart';
import 'package:flutter/material.dart';

import '../database.dart';
import '../database.dart';
import '../database.dart';
import 'Dialogs/clear_data_dialog.dart';

class SettingsScreen extends StatefulWidget {
  final Function refresh;

  const SettingsScreen(this.refresh, {Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<bool> isSelected = [true, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (meUser!.themePreference == "Light") {
      isSelected = [true, false];
    } else {
      isSelected = [false, true];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header2(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              height: 150,
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
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xff5A6FF0).withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                            color: Color(0xff5A6FF0),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/me.png"),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        [
                          "UserID: ",
                          "#UD" +
                              (meUser!.id > 10
                                  ? meUser!.id.toString()
                                  : "0" + meUser!.id.toString())
                        ],
                        ["Name: ", meUser!.name],
                        [
                          "Target Saving: ",
                          "\$" + meUser!.monthlyTargetSaving.toStringAsFixed(0)
                        ],
                        [
                          "Bank Balance: ",
                          "\$" + meUser!.bankBalance.toStringAsFixed(0)
                        ]
                      ]
                          .map((e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 12,
                                ),
                                child: Row(
                                  children: [
                                    Text(e[0]),
                                    Expanded(child: Container()),
                                    Text(
                                      e[1],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12,
              ),
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
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Preferences",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          const Text("Change Theme: "),
                          Expanded(child: Container()),
                          ToggleButtons(
                              children: const [
                                Icon(Icons.wb_sunny),
                                Icon(Icons.nightlight_round),
                              ],
                              onPressed: (int i) {
                                setState(() {
                                  if (i == 0) {
                                    isSelected = [true, false];
                                    UserService()
                                        .changeThemePreference(
                                            themePreference: "Light")
                                        .then((value) {
                                      meUser = value;
                                      widget.refresh();
                                    });
                                  } else {
                                    isSelected = [false, true];
                                    UserService()
                                        .changeThemePreference(
                                            themePreference: "Dark")
                                        .then((value) {
                                      meUser = value;
                                      widget.refresh();
                                    });
                                  }
                                });
                              },
                              color: Colors.blueGrey,
                              selectedColor: Colors.black,
                              selectedBorderColor: Colors.black.withOpacity(1),
                              isSelected: isSelected,
                              borderColor: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                              constraints: const BoxConstraints.tightFor(
                                  width: 60, height: 40)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          const Text("Change Passcode: "),
                          Expanded(child: Container()),
                          Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return PinCodeScreen(
                                        pinCode: meUser!.pinCode,
                                        refresh: widget.refresh,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                child: Center(
                                  child: Text(
                                    meUser!.pinCode == null ? "Set" : "Change",
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          const Text("Clear Data: "),
                          Expanded(child: Container()),
                          Material(
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const ClearDataDialog();
                                    });
                              },
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                child: const Center(child: Text("Delete")),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          const Text("Add Correction: "),
                          Expanded(child: Container()),
                          Material(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                child: const Center(child: Text("Add")),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          const Text("Deactivate Account: "),
                          Expanded(child: Container()),
                          Material(
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const DeactivateAccountDialog();
                                    });
                              },
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                child: const Center(
                                  child: Text("Deactivate"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 12,
                      ),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MaterialButton(
                          height: 40,
                          minWidth: MediaQuery.of(context).size.width,
                          color: Colors.green,
                          onPressed: () {},
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Text(
                      "User created at ${meUser!.dateTime.toString().substring(0, 10)}",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 12,
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
