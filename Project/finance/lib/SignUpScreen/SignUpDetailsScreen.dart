import 'package:finance/EntityServices/TokenService.dart';
import 'package:finance/Providers/SignUpManagement.dart';
import 'package:finance/Providers/ThemeManagement.dart';
import 'package:finance/SettingsScreen/Dialogs/AvatarDialog.dart';
import 'package:finance/SignUpScreen/DetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

import '../PinCodeScreen/pin_code_screen.dart';
import '../Providers/LogInManagement.dart';
import '../main_screen.dart';
import 'SignUpAvatarDialog.dart';
import 'SignUpPreferences.dart';
import 'Stepper.dart';

class SignUpDetailsScreen extends StatefulWidget {
  @override
  State<SignUpDetailsScreen> createState() => _SignUpDetailsScreenState();
}

class _SignUpDetailsScreenState extends State<SignUpDetailsScreen> {
  int index = 0;
  List<String> menus = ["Details", "Avatar", "Preferences"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeManagement>().background,
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            menus[index],
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Builder(builder: (context) {
                  double width = MediaQuery.of(context).size.width - 26;
                  return Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      CustomPaint(
                        painter: MyStepper(width, index),
                      ),
                      Row(
                        children: menus.asMap().entries.map(
                          (e) {
                            return Container(
                              width: (width) / 3,
                              child: Center(
                                child: Text(
                                  e.value,
                                  style: TextStyle(
                                      color: index == e.key
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          Expanded(child: Builder(builder: (context) {
            double _height = MediaQuery.of(context).size.height;
            double _width = MediaQuery.of(context).size.width;
            return IndexedStack(
              index: index,
              children: [
                DetailsScreen(),
                SignUpAvatarDialog(
                  _height,
                  _width,
                ),
                SignUpPreferences(),
              ],
            );
          })),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (index != 0) {
                            index--;
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: index == 0 ? Colors.blueGrey : Colors.red,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (index == 0) {
                          {
                            if (context
                                    .read<SignUpManagement>()
                                    .pinController
                                    .text ==
                                context
                                    .read<SignUpManagement>()
                                    .comfirmPinController
                                    .text) {
                              if (context
                                          .read<SignUpManagement>()
                                          .pinController
                                          .text
                                          .length ==
                                      4 ||
                                  context
                                      .read<SignUpManagement>()
                                      .pinController
                                      .text
                                      .isEmpty) {
                                setState(() {
                                  index++;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Pin must be of 4 digits")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Pin do not match")));
                            }
                          }
                        } else if (index == 1) {
                          setState(() {
                            index++;
                          });
                        } else {
                          try {
                            bool success = await TokenService().signUp(
                                context,
                                context.read<SignUpManagement>().name!,
                                double.tryParse(context
                                        .read<SignUpManagement>()
                                        .currentBalanceController
                                        .text) ??
                                    0,
                                context.read<SignUpManagement>().isDark
                                    ? "Dark"
                                    : "Light",
                                context
                                    .read<SignUpManagement>()
                                    .selected
                                    ?.avatarID,
                                context.read<SignUpManagement>().gmail!,
                                double.tryParse(context
                                        .read<SignUpManagement>()
                                        .targetSavingController
                                        .text) ??
                                    0,
                                int.tryParse(context
                                    .read<SignUpManagement>()
                                    .pinController
                                    .text));
                            if (success) {
                              initAll(BuildContext context) {
                                context.read<ThemeManagement>().setTheme(context
                                        .read<LogInManagement>()
                                        .meUser
                                        ?.themePreference !=
                                    "Light");
                                if (context
                                        .read<LogInManagement>()
                                        .meUser
                                        ?.pinCode ==
                                    null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return MainScreen();
                                      },
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return PinCodeScreen(
                                          pinCode: context
                                              .read<LogInManagement>()
                                              .meUser
                                              ?.pinCode,
                                          isLogged: false,
                                        );
                                      },
                                    ),
                                  );
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Could not sign up")));
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Could not sign up")));
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                index != 2 ? "Next" : "Create",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
