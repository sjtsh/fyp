import 'package:finance/Header/header.dart';
import 'package:finance/NavBar/navbar.dart';
import 'package:finance/Screens/HomeScreen/home_screen.dart';
import 'package:finance/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Entities/users.dart';
import 'EntityServices/categoryService.dart';
import 'Providers/ThemeManagement.dart';
import 'Screens/CategoryScreen/category_screen.dart';
import 'Screens/HomeScreen/Chart/line_chart.dart';
import 'Screens/HomeScreen/MyPageView/my_page_view.dart';
import 'Screens/TransactionsScreen/transactions_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;

  void setIndex(int i) {
    setState(() {
      currentIndex = i;
    });
  }


  Widget changeActivity(currentIndex) {
    if (currentIndex == 0) {
      return CategoryScreen();
    } else if (currentIndex == 1) {
      return HomeScreen();
    } else {
      return TransactionsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: NavBar(setIndex, currentIndex),
        backgroundColor: context.watch<ThemeManagement>().background ,
        body: ListView(
          children: [
            Header(),
            changeActivity(currentIndex),
          ],
        ),
      ),
    );
  }
}
