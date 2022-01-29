import 'package:finance/EntityServices/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Entities/users.dart';
import 'EntityServices/categoryService.dart';
import 'EntityServices/transactionService.dart';
import 'database.dart';
import 'main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      title: 'Finance',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: UserService().fetchUsers().then((value){
          return value;
        }),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            meUser = snapshot.data;
            return MainScreen();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
