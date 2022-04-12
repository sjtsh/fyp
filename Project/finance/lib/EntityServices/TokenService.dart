import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:finance/Entities/users.dart' as us;

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Providers/LogInManagement.dart';
import '../Providers/SignUpManagement.dart';
import '../database.dart';

class TokenService {
  Future<bool> ananymousLogIn(BuildContext context) async {
    final res = await http.get(
      Uri.parse("http://$localhost/users/ananymous/"),
    );
    if (res.statusCode == 200) {
      us.User user = us.User.fromJson(jsonDecode(res.body));
      context.read<LogInManagement>().meUser = user;
      context.read<LogInManagement>().userChange();
      await http.get(
        Uri.parse("http://$localhost/linearmodel/${user.id}/train"),
      );
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isAvailable(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      UserCredential creds =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (creds.user != null && creds.user?.email != null) {
        final res = await http.post(
          Uri.parse("http://$localhost/users/available/"),
          body: <String, String>{
            "email": creds.user?.email ?? "ananymous@gmail.com",
          },
        );
        if (jsonDecode(res.body).toString().toLowerCase() == "false") {
          context.read<SignUpManagement>().gmail = creds.user?.email;
          context.read<SignUpManagement>().name = creds.user?.displayName;

          return false;
        } else {
          us.User user = us.User.fromJson(jsonDecode(res.body));
          context.read<LogInManagement>().meUser = user;
          return true;
        }
      } else {
        throw Exception("unsuccessful");
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(
      BuildContext context,
      String name,
      double bank_balance,
      String theme_preference,
      int? avatar,
      String email,
      double monthly_target_saving,
      int? pin_code) async {
    Map<String, String> aMap = {
      "email": email,
      "name": name,
      "bank_balance": bank_balance.toString(),
      "theme_preference": theme_preference,
      "monthly_target_saving": monthly_target_saving.toString(),
      "pin_code": pin_code.toString(),
    };
    if (avatar != null) {
      aMap["avatar"] = avatar.toString();
    }
    final res = await http.post(
      Uri.parse("http://$localhost/users/insert/"),
      body: aMap,
    );
    if (res.statusCode == 200) {
      us.User user = us.User.fromJson(jsonDecode(res.body));
      context.read<LogInManagement>().meUser = user;
      context.read<LogInManagement>().userChange();
      await http.get(
        Uri.parse("http://$localhost/linearmodel/${user.id}/train/"),
      );
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      UserCredential creds =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (creds.user != null && creds.user?.email != null) {
        print(
            "http://$localhost/user/${context.read<LogInManagement>().meUser!.id}/update/");
        final res = await http.put(
          Uri.parse(
              "http://$localhost/user/${context.read<LogInManagement>().meUser!.id}/update/"),
          body: <String, String>{
            "email": creds.user?.email ?? "ananymous@gmail.com",
            "name": creds.user?.displayName ?? "ananymous",
          },
        );
        if (res.statusCode == 200) {
          us.User user = us.User.fromJson(jsonDecode(res.body));
          context.read<LogInManagement>().meUser = user;
          context.read<LogInManagement>().userChange();
          await http.get(
            Uri.parse("http://$localhost/linearmodel/${user.id}/train/"),
          );
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception("unsuccessful");
      }
    } catch (e) {
      return false;
    }
  }
}
