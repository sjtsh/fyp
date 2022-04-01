import 'package:finance/Providers/ThemeManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: context.watch<ThemeManagement>().background,
      body: Center(
        child: SvgPicture.asset("assets/logodark.svg", ),
      ),
    );
  }
}
