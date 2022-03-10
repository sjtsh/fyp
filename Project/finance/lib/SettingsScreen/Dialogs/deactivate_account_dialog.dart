import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/ThemeManagement.dart';

class DeactivateAccountDialog extends StatelessWidget {
  const DeactivateAccountDialog({Key? key}) : super(key: key);

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
                    "Are you sure you want to deactivate the account?",
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
                                onPressed: () {},
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: context
                                          .watch<ThemeManagement>()
                                          .allTextColorNegative),
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
                                onPressed: () {},
                                child: Text(
                                  "Confirm",

                                    style: TextStyle(
                                        color: context
                                            .watch<ThemeManagement>()
                                            .allTextColorNegative),
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
