import 'package:finance/EntityServices/TokenService.dart';
import 'package:finance/EntityServices/userService.dart';
import 'package:finance/Header/header2.dart';
import 'package:finance/PinCodeScreen/pin_code_screen.dart';
import 'package:finance/SettingsScreen/Dialogs/deactivate_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/LogInManagement.dart';
import '../Providers/ThemeManagement.dart';
import '../SignUpScreen.dart';
import '../database.dart';
import '../methods.dart';
import 'Dialogs/AvatarDialog.dart';
import 'Dialogs/target_saving_screen.dart';
import 'correction_screen.dart';
import 'Dialogs/clear_data_dialog.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<bool> isSelected = [true, false];
  PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<LogInManagement>().meUser?.themePreference == "Light") {
      isSelected = [true, false];
    } else {
      isSelected = [false, true];
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            backgroundColor: context.watch<ThemeManagement>().background,
            body: Column(
              children: [
                const Header2(),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context
                                .watch<ThemeManagement>()
                                .containerColors,
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
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.nextPage(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.easeIn);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: context
                                            .watch<ThemeManagement>()
                                            .logoBgColorOpacity5,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: context
                                                    .watch<LogInManagement>()
                                                    .meUser ==
                                                null
                                            ? Container()
                                            : Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: context
                                                      .watch<ThemeManagement>()
                                                      .logoBgColor,
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "http://$localhost/" +
                                                              context
                                                                  .watch<
                                                                      LogInManagement>()
                                                                  .meUser!
                                                                  .avatarURL),
                                                      fit: BoxFit.contain),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    [
                                      "UserID: ",
                                      "#UD" +
                                          (context
                                                      .watch<LogInManagement>()
                                                      .meUser!
                                                      .id >
                                                  10
                                              ? context
                                                  .watch<LogInManagement>()
                                                  .meUser!
                                                  .id
                                                  .toString()
                                              : "0" +
                                                  context
                                                      .watch<LogInManagement>()
                                                      .meUser!
                                                      .id
                                                      .toString())
                                    ],
                                    [
                                      "Name: ",
                                      context
                                          .watch<LogInManagement>()
                                          .meUser!
                                          .name
                                    ],
                                    [
                                      "Target Saving: ",
                                      "\$" +
                                          addCommas(context
                                              .watch<LogInManagement>()
                                              .meUser!
                                              .monthlyTargetSaving)
                                    ],
                                    [
                                      "Bank Balance: ",
                                      "\$" +
                                          addCommas(context
                                              .watch<LogInManagement>()
                                              .meUser!
                                              .bankBalance)
                                    ],
                                  ]
                                      .map((e) => Row(
                                            children: [
                                              Text(
                                                e[0],
                                                style: TextStyle(
                                                    color: context
                                                        .watch<
                                                            ThemeManagement>()
                                                        .allTextColor),
                                              ),
                                              Expanded(child: Container()),
                                              Text(
                                                e[1],
                                                style: TextStyle(
                                                  color: context
                                                      .watch<ThemeManagement>()
                                                      .allTextColorOpacity5,
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 12,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context
                                .watch<ThemeManagement>()
                                .containerColors,
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
                              Text(
                                "Preferences",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: context
                                        .watch<ThemeManagement>()
                                        .allTextColor),
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
                                    Text(
                                      "Change Theme: ",
                                      style: TextStyle(
                                          color: context
                                              .watch<ThemeManagement>()
                                              .allTextColor),
                                    ),
                                    Expanded(child: Container()),
                                    ToggleButtons(
                                        children: [
                                          Icon(
                                            Icons.wb_sunny,
                                            color: context
                                                .watch<ThemeManagement>()
                                                .allIconColor,
                                          ),
                                          Icon(
                                            Icons.nightlight_round,
                                            color: context
                                                .watch<ThemeManagement>()
                                                .allIconColor,
                                          ),
                                        ],
                                        onPressed: (int i) {
                                          setState(() {
                                            if (i == 0) {
                                              isSelected = [true, false];
                                              context
                                                  .read<ThemeManagement>()
                                                  .setTheme(false);
                                              UserService()
                                                  .changeThemePreference(
                                                      themePreference: "Light",
                                                      meUser: context
                                                          .read<
                                                              LogInManagement>()
                                                          .meUser!)
                                                  .then((value) {
                                                context
                                                    .read<LogInManagement>()
                                                    .meUser = value;
                                                context
                                                    .read<LogInManagement>()
                                                    .userChange();
                                              });
                                            } else {
                                              isSelected = [false, true];
                                              context
                                                  .read<ThemeManagement>()
                                                  .setTheme(true);
                                              UserService()
                                                  .changeThemePreference(
                                                      themePreference: "Dark",
                                                      meUser: context
                                                          .read<
                                                              LogInManagement>()
                                                          .meUser!)
                                                  .then((value) {
                                                context
                                                    .read<LogInManagement>()
                                                    .meUser = value;
                                                context
                                                    .read<LogInManagement>()
                                                    .userChange();
                                              });
                                            }
                                          });
                                        },
                                        color: Colors.blueGrey,
                                        selectedColor: Colors.black,
                                        selectedBorderColor: context
                                            .watch<ThemeManagement>()
                                            .allTextColorOpacity5,
                                        isSelected: isSelected,
                                        borderRadius: BorderRadius.circular(12),
                                        borderColor: context
                                            .watch<ThemeManagement>()
                                            .allTextColorOpacity5,
                                        constraints:
                                            const BoxConstraints.tightFor(
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
                                    Text(
                                      "Change Passcode: ",
                                      style: TextStyle(
                                          color: context
                                              .watch<ThemeManagement>()
                                              .allTextColor),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      width: 120,
                                      height: 40,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: context
                                                .watch<ThemeManagement>()
                                                .allTextColorOpacity5),
                                      ),
                                      child: Material(
                                        color: context
                                            .watch<ThemeManagement>()
                                            .transaparentTextButtonColorOpacity05,
                                        borderRadius: BorderRadius.circular(12),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) {
                                                  return PinCodeScreen(
                                                    pinCode: context
                                                        .read<LogInManagement>()
                                                        .meUser!
                                                        .pinCode,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Center(
                                            child: Text(
                                              context
                                                          .watch<
                                                              LogInManagement>()
                                                          .meUser!
                                                          .pinCode ==
                                                      null
                                                  ? "Set"
                                                  : "Change",
                                              style: TextStyle(
                                                  color: context
                                                      .watch<ThemeManagement>()
                                                      .allTextColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              context
                                          .watch<LogInManagement>()
                                          .meUser!
                                          .pinCode ==
                                      null
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 6,
                                      ),
                                      child: Row(
                                        children: [
                                          const Text("Remove Passcode: "),
                                          Expanded(child: Container()),
                                          Container(
                                            width: 120,
                                            height: 40,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: context
                                                      .watch<ThemeManagement>()
                                                      .allTextColorOpacity5),
                                            ),
                                            child: Material(
                                              color: context
                                                  .watch<ThemeManagement>()
                                                  .transaparentTextButtonColorOpacity05,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return PinCodeScreen(
                                                          pinCode: context
                                                              .read<
                                                                  LogInManagement>()
                                                              .meUser!
                                                              .pinCode,
                                                          isToBeRemoved: false,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Center(
                                                  child: Text(
                                                    "Remove",
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
                                    Text(
                                      "Clear Data: ",
                                      style: TextStyle(
                                          color: context
                                              .watch<ThemeManagement>()
                                              .allTextColor),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      width: 120,
                                      height: 40,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: context
                                                .watch<ThemeManagement>()
                                                .allTextColorOpacity5),
                                      ),
                                      child: Material(
                                        color: context
                                            .watch<ThemeManagement>()
                                            .transaparentTextButtonColorOpacity05,
                                        borderRadius: BorderRadius.circular(12),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return const ClearDataDialog();
                                                });
                                          },
                                          child: Center(
                                              child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: context
                                                    .watch<ThemeManagement>()
                                                    .allTextColor),
                                          )),
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
                                    Text(
                                      "Add Correction: ",
                                      style: TextStyle(
                                          color: context
                                              .watch<ThemeManagement>()
                                              .allTextColor),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      width: 120,
                                      height: 40,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: context
                                                .watch<ThemeManagement>()
                                                .allTextColorOpacity5),
                                      ),
                                      child: Material(
                                        color: context
                                            .watch<ThemeManagement>()
                                            .transaparentTextButtonColorOpacity05,
                                        borderRadius: BorderRadius.circular(12),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) {
                                                  return CorrectionScreen();
                                                },
                                              ),
                                            );
                                          },
                                          child: Center(
                                              child: Text(
                                            "Add",
                                            style: TextStyle(
                                                color: context
                                                    .watch<ThemeManagement>()
                                                    .allTextColor),
                                          )),
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
                                    Text(
                                      "Update Target Saving: ",
                                      style: TextStyle(
                                          color: context
                                              .watch<ThemeManagement>()
                                              .allTextColor),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      width: 120,
                                      height: 40,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: context
                                                .watch<ThemeManagement>()
                                                .allTextColorOpacity5),
                                      ),
                                      child: Material(
                                        color: context
                                            .watch<ThemeManagement>()
                                            .transaparentTextButtonColorOpacity05,
                                        borderRadius: BorderRadius.circular(12),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return TargetSavingScreen();
                                                });
                                          },
                                          child: Center(
                                              child: Text(
                                            "Update",
                                            style: TextStyle(
                                                color: context
                                                    .watch<ThemeManagement>()
                                                    .allTextColor),
                                          )),
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
                                    Text(
                                      "Deactivate Account: ",
                                      style: TextStyle(
                                          color: context
                                              .watch<ThemeManagement>()
                                              .allTextColor),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      width: 120,
                                      height: 40,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: context
                                                .watch<ThemeManagement>()
                                                .allTextColorOpacity5),
                                      ),
                                      child: Material(
                                        color: context
                                            .watch<ThemeManagement>()
                                            .transaparentTextButtonColorOpacity05,
                                        borderRadius: BorderRadius.circular(12),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return const DeactivateAccountDialog();
                                                });
                                          },
                                          child: Center(
                                            child: Text(
                                              "Deactivate",
                                              style: TextStyle(
                                                  color: context
                                                      .watch<ThemeManagement>()
                                                      .allTextColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              context.watch<LogInManagement>().meUser?.email ==
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 12,
                                      ),
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: MaterialButton(
                                          height: 40,
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.green,
                                          onPressed: () async {
                                            bool userCredential =
                                                await TokenService()
                                                    .signInWithGoogle(context);
                                            if (userCredential) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          Text("Successful")));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          Text("Bad Creds")));
                                            }
                                          },
                                          child: const Text(
                                            "Sign In With Google",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 12,
                                      ),
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: MaterialButton(
                                          height: 40,
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.red,
                                          onPressed: () {
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder: (_) {
                                            //   return SignUpScreen();
                                            // }));
                                            Navigator.pushNamed(
                                                context, "signup");
                                          },
                                          child: const Text(
                                            "Log Out",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            "User created at ${context.read<LogInManagement>().meUser!.dateTime.toString().substring(0, 10)}",
                            style: TextStyle(
                              color: context
                                  .watch<ThemeManagement>()
                                  .allTextColorOpacity5,
                            ),
                          ),
                        ),
                      ),
                      context.watch<LogInManagement>().meUser?.email != null
                          ? Container(
                              child: Center(
                                child: Text(
                                  "Logged in as ${context.read<LogInManagement>().meUser!.email.toString()}",
                                  style: TextStyle(
                                    color: context
                                        .watch<ThemeManagement>()
                                        .allTextColorOpacity5,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AvatarDialog(context.read<LogInManagement>().meUser!.avatarURL,
              height, width, controller),
        ]);
  }
}
