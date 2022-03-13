import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/SignUpManagement.dart';
import '../Providers/ThemeManagement.dart';

class SignUpPreferences extends StatelessWidget {
  const SignUpPreferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Text(
          "Choose your theme: ",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(
          height: 12,
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<SignUpManagement>().isDark = true;
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: !context.watch<SignUpManagement>().isDark
                              ? Colors.white.withOpacity(0.5)
                              : Colors.green,
                        ),
                        child: !context.watch<SignUpManagement>().isDark
                            ? Container()
                            : Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Opacity(
                            opacity: !context.watch<SignUpManagement>().isDark
                                ? 0.5
                                : 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.nightlight_round,
                                  color: Colors.yellow,
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<SignUpManagement>().isDark = false;
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.watch<SignUpManagement>().isDark
                              ? Colors.white.withOpacity(0.5)
                              : Colors.green,
                        ),
                        child: context.watch<SignUpManagement>().isDark
                            ? Container()
                            : Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Opacity(
                            opacity: context.watch<SignUpManagement>().isDark
                                ? 0.5
                                : 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.wb_sunny,
                                  color: Colors.black,
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
