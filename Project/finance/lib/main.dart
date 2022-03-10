import 'package:finance/EntityServices/userService.dart';
import 'package:finance/PinCodeScreen/pin_code_screen.dart';
import 'package:finance/Providers/ThemeManagement.dart';
import 'package:finance/SignUpScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'EntityServices/AvatarService.dart';
import 'Providers/LogInManagement.dart';
import 'SplashScreen.dart';
import 'database.dart';
import 'firebase_options.dart';
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LogInManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeManagement(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      title: 'Finance',
      debugShowCheckedModeBanner: false,
      routes: {
        'signup': (context) => const SignUpScreen(),
      },
      home: FutureBuilder(
        future: UserService().fetchUsers(1).then(
          (value) {
            context
                .read<ThemeManagement>()
                .setTheme(value.themePreference != "Light");
            return value;
          },
        ),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            context.read<LogInManagement>().meUser = snapshot.data;
            if (context.read<LogInManagement>().meUser?.pinCode == null) {
              return MainScreen();
            } else {
              return PinCodeScreen(
                pinCode: context.read<LogInManagement>().meUser?.pinCode,
                isLogged: false,
              );
            }
          }
          return const SplashScreen();
        },
      ),
    );
  }
}
