import 'package:finance/EntityServices/userService.dart';
import 'package:finance/Providers/LogInManagement.dart';
import 'package:finance/SignUpScreen/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/ThemeManagement.dart';

class ClearDataDialog extends StatelessWidget {
  const ClearDataDialog({Key? key}) : super(key: key);

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
            height: 100,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                      child: Center(
                          child: Text(
                    "Are you sure you want to delete account?",
                    style: TextStyle(
                        color: context.watch<ThemeManagement>().allTextColor),
                  ))),
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
                                  style: TextStyle(color: Colors.white),
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
                                  if (context.read<LogInManagement>().meUser !=
                                      null) {
                                    bool success = await UserService()
                                        .deleteUser(context
                                            .read<LogInManagement>()
                                            .meUser!
                                            .id);
                                    if (success) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return SignUpScreen();
                                      }));
                                    }
                                  }
                                },
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(color: Colors.white),
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
