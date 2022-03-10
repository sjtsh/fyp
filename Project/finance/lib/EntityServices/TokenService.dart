import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:finance/Entities/users.dart' as us;

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Providers/LogInManagement.dart';
import '../database.dart';

class TokenService {
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
        final res = await http.put(
          Uri.parse("http://$localhost/user/${context
              .read<LogInManagement>()
              .meUser!.id}/update"),
          body: <String, String>{
            "email": creds.user?.email ?? "ananymous@gmail.com",
            "name" : creds.user?.displayName ?? "ananymous",
          },
        );
        if (res.statusCode == 200) {
          us.User user = us.User.fromJson(jsonDecode(res.body));
          context
              .read<LogInManagement>()
              .meUser = user;
          context.read<LogInManagement>().userChange();
          return true;
        }else{
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
