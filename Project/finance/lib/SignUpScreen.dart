import 'dart:ui';

import 'package:finance/Providers/ThemeManagement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<List<double>> myPositions = [
    [-20, -60],
    [-45, -15],
    [100, -40],
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: context.watch<ThemeManagement>().background,
        body: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              top: myPositions[0][0],
              right: myPositions[0][1],
              duration: Duration(seconds: 4),
              child: Spheres1(1, 1),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 4),
              bottom: myPositions[1][0],
              right: myPositions[1][1],
              child: Spheres1(2, 0),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 4),
              top: myPositions[2][0],
              left: myPositions[2][1],
              child: Spheres1(0, 2),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (context) {
                    String a = "Goodevening!!!";
                    DateTime now = DateTime.now();
                    if (now.hour < 12) {
                      a = "Goodmorning!!!";
                    } else if (now.hour < 18) {
                      a = "Goodafternoon!!!";
                    }
                    return Text(
                      a,
                      style: TextStyle(
                        color: context.watch<ThemeManagement>().allTextColor,
                        fontSize: 20,
                      ),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Have your money Financed",
                    style: TextStyle(
                      color: context.watch<ThemeManagement>().allTextColor,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              context.watch<ThemeManagement>().containerColors,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 3,
                                offset: Offset(2, 0),
                                blurRadius: 3),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign in with google",
                            style: TextStyle(
                              color:
                                  context.watch<ThemeManagement>().allTextColor,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: context.watch<ThemeManagement>().allTextColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "OR",
                          style: TextStyle(
                              color: context
                                  .watch<ThemeManagement>()
                                  .allTextColorOpacity5,
                              fontSize: 16,
                              letterSpacing: 5),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: context.watch<ThemeManagement>().allTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.watch<ThemeManagement>().containerColors,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              offset: Offset(2, 0),
                              blurRadius: 3),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Try our ",
                                style: TextStyle(
                                  color: context
                                      .watch<ThemeManagement>()
                                      .allTextColor,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "anonymous",
                                style: TextStyle(
                                  color: context
                                      .watch<ThemeManagement>()
                                      .allTextColorOpacity5,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                " sign up",
                                style: TextStyle(
                                  color: context
                                      .watch<ThemeManagement>()
                                      .allTextColor,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: context
                                      .watch<ThemeManagement>()
                                      .background,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {

                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: context
                                        .watch<ThemeManagement>()
                                        .allIconColor,
                                    size: 60,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  runAnimations() {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      print("first animation");
      myPositions = [
        [25, -40],
        [-50, 30],
        [80, -3],
      ];
      setState(() {});
      Future.delayed(Duration(seconds: 4)).then((value) {
        myPositions = [
          [-20, -20],
          [-45, -15],
          [100, -40],
        ];
        setState(() {});
        Future.delayed(Duration(seconds: 4)).then((value) {
          myPositions = [
            [0, 80],
            [-50, 0],
            [300, 100],
          ];
          setState(() {});
          Future.delayed(Duration(seconds: 4)).then((value) {
            myPositions = [
              [-20, 120],
              [10, 80],
              [400, 150],
            ];
            setState(() {});
            Future.delayed(Duration(seconds: 4)).then((value) {
              myPositions = [
                [-20, 120],
                [6, 80],
                [400, 9],
              ];
              setState(() {});
            });
            Future.delayed(Duration(seconds: 4)).then((value) {
              myPositions = [
                [-0, 20],
                [3, 150],
                [10, 20],
              ];
              setState(() {});
            });
            Future.delayed(Duration(seconds: 4)).then((value) {
              myPositions = [
                [25, -40],
                [-50, 30],
                [80, -3],
              ];
              setState(() {});
              runAnimations();
            });
          });
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    runAnimations();
  }
}

class Spheres1 extends StatelessWidget {
  final int index;
  final int ListIndex;

  Spheres1(this.index, this.ListIndex);

  List list = const [
    [Color(0xff767676), Color(0xff343434)],
    [Color(0xffD2E4FF), Color(0xff0065FF)],
    [Color(0xffFFCDCD), Color(0xffFF0000)],
  ];
  List list2 = const [
    Colors.black,
    Color(0xff0065FF),
    Color(0xffFF0000),
  ];
  List listIndex = [200.0, 150.0, 250.0];

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: Stack(
        children: [
          Container(
            height: listIndex[ListIndex],
            width: listIndex[ListIndex],
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: list[index],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: list2[index].withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 10)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
