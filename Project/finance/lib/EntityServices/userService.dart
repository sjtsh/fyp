import 'dart:convert';
import 'package:finance/Entities/category.dart';
import 'package:finance/Entities/users.dart';
import 'package:http/http.dart' as http;

import '../database.dart';

class UserService {
  Future<User> fetchUsers() async {
    final res = await http.get(
      Uri.parse("http://$localhost/users/${1}"),
    );
    if (res.statusCode == 200) {
      dynamic value = jsonDecode(res.body);
      User user = User.fromJson(value);
      return user;
    } else {
      throw Exception("unsuccessful");
    }
  }

  Future<User> changeThemePreference({required String themePreference}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser!.id}/update"),
      body: <String, String>{
        "theme_preference": themePreference,
      },
    );
    if (res.statusCode == 200) {
      User user = User.fromJson(jsonDecode(res.body));
      return user;
    } else {
      throw Exception("unsuccessful");
    }
  }

  Future<User> changeTargetSaving({required double monthlyTargetSaving}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser!.id}/update"),
      body: <String, String>{
        "monthly_target_saving": monthlyTargetSaving.toString(),
      },
    );
    if (res.statusCode == 200) {
      User user = User.fromJson(jsonDecode(res.body));
      return user;
    } else {
      throw Exception("unsuccessful");
    }
  }

  Future<User> changePinCode({required int pinCode}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser!.id}/update"),
      body: <String, String>{
        "pin_code": pinCode.toString(),
      },
    );
    if (res.statusCode == 200) {
      User user = User.fromJson(jsonDecode(res.body));
      return user;
    } else {
      throw Exception("unsuccessful");
    }
  }

  Future<User> changeName({required String name}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser!.id}/update"),
      body: <String, String>{
        "name": name.toString(),
      },
    );
    if (res.statusCode == 200) {
      User user = User.fromJson(jsonDecode(res.body));
      return user;
    } else {
      throw Exception("unsuccessful");
    }
  }

  Future<User> changeAvatar({required int avatarID}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser!.id}/update"),
      body: <String, String>{
        "avatar": avatarID.toString(),
      },
    );
    if (res.statusCode == 200) {
      User user = User.fromJson(jsonDecode(res.body));
      return user;
    } else {
      throw Exception("unsuccessful");
    }
  }
}
