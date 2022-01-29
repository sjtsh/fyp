import 'package:finance/EntityServices/userService.dart';
import 'package:finance/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PinCodeScreen extends StatefulWidget {
  final int? pinCode;
  final Function refresh;

  PinCodeScreen({this.pinCode, required this.refresh});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String passcode = "";
  bool isVerified = false;
  int? initialPasscode;

  void keyEntered(int f) {
    setState(() {
      passcode += f.toString();
      if (passcode.length == 4) {
        if (widget.pinCode != null && !isVerified) {
          widget.pinCode == int.parse(passcode) ? isVerified = true : 1;
        } else {
          if (initialPasscode == null) {
            initialPasscode = int.parse(passcode);
          } else {
            if (initialPasscode == int.parse(passcode)) {
              int a = int.parse(passcode);
              UserService().changePinCode(pinCode: a).then((value) {
                meUser = value;
                widget.refresh();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("New password has been set"),
                  ),
                );
                Navigator.pop(context);
              });
            } else {
              initialPasscode = null;
            }
          }
        }
        passcode = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: const Color(0xff5A6FF0).withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                height: 160,
                width: 160,
                decoration: const BoxDecoration(
                  color: Color(0xff5A6FF0),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/me.png"), fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            (isVerified || widget.pinCode == null)
                ? (initialPasscode == null
                    ? "Set your 4 digit pin"
                    : "Re-enter your 4 digit code")
                : "Enter your 4 digit code",
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3, 4]
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 3,
                                  offset: const Offset(0, 2))
                            ]),
                        child: e <= passcode.length
                            ? Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      [1, 2, 3],
                      [4, 5, 6],
                      [7, 8, 9]
                    ]
                        .map((e) => Expanded(
                              child: Row(
                                children: e
                                    .map(
                                      (f) => Expanded(
                                        child: Center(
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Material(
                                              color: const Color(0xffC4C4C4),
                                              child: InkWell(
                                                splashColor:
                                                    const Color(0xff5A6FF0),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                onTap: () {
                                                  keyEntered(f);
                                                },
                                                child: SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: Center(
                                                      child: Text(
                                                    f.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 30,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              color: const Color(0xffC4C4C4),
                              child: InkWell(
                                splashColor: const Color(0xff5A6FF0),
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  setState(() {
                                    passcode = "";
                                  });
                                },
                                child: const SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              color: const Color(0xffC4C4C4),
                              child: InkWell(
                                splashColor: const Color(0xff5A6FF0),
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  keyEntered(0);
                                },
                                child: const SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        "0",
                                        style: TextStyle(
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              color: const Color(0xffC4C4C4),
                              child: InkWell(
                                splashColor: const Color(0xff5A6FF0),
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  setState(() {
                                    passcode = passcode.substring(
                                        0, passcode.length - 1);
                                  });
                                },
                                child: const SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Center(
                                    child: Icon(
                                      Icons.backspace,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
