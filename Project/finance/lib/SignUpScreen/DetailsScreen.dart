import 'package:finance/Providers/SignUpManagement.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Providers/ThemeManagement.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Lottie.asset(
            "assets/invest.json",
            height: height - 480,
            repeat: true,
            reverse: true,
            animate: true,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 6),
            child: Container(
              decoration: BoxDecoration(
                color:
                    context.watch<ThemeManagement>().textfieldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller:
                    context.read<SignUpManagement>().currentBalanceController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                autofocus: false,
                style: TextStyle(
                  color: context.watch<ThemeManagement>().allTextColor,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: "Current Balance (default = 0)",
                  hintStyle: TextStyle(
                    color:
                        context.watch<ThemeManagement>().allTextColorOpacity5,
                  ),
                  fillColor: Colors.green,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color:
                    context.watch<ThemeManagement>().textfieldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller:
                    context.read<SignUpManagement>().targetSavingController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                autofocus: false,
                style: TextStyle(
                  color: context.watch<ThemeManagement>().allTextColor,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: "Target Saving (default = 0)",
                  hintStyle: TextStyle(
                    color:
                        context.watch<ThemeManagement>().allTextColorOpacity5,
                  ),
                  fillColor: Colors.green,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Want security?",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color:
                    context.watch<ThemeManagement>().textfieldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: context.read<SignUpManagement>().pinController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                autofocus: false,
                style: TextStyle(
                  color: context.watch<ThemeManagement>().allTextColor,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: "Enter a 4 digit pin",
                  hintStyle: TextStyle(
                    color:
                        context.watch<ThemeManagement>().allTextColorOpacity5,
                  ),
                  fillColor: Colors.green,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color:
                    context.watch<ThemeManagement>().textfieldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller:
                    context.read<SignUpManagement>().comfirmPinController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                autofocus: false,
                style: TextStyle(
                  color: context.watch<ThemeManagement>().allTextColor,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: "Re Enter the pin",
                  hintStyle: TextStyle(
                    color:
                        context.watch<ThemeManagement>().allTextColorOpacity5,
                  ),
                  fillColor: Colors.green,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
