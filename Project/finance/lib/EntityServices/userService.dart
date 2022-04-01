import 'dart:convert';
import 'package:finance/Entities/users.dart';
import 'package:http/http.dart' as http;
import '../database.dart';

class UserService {
  Future<User> fetchUsers(int userID) async {
    final res = await http.get(
      Uri.parse("http://$localhost/users/$userID"),
    );
    if (res.statusCode == 200) {
      dynamic value = jsonDecode(res.body);
      User user = User.fromJson(value);
      await http.get(
        Uri.parse("http://$localhost/linearmodel/${user.id}/train"),
      );
      return user;
    } else {
      throw Exception("unsuccessful");
    }
  }

  Future<bool> deleteUser(int userID) async {
    final res = await http.delete(
      Uri.parse("http://$localhost/user/$userID/delete"),
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> changeThemePreference(
      {required String themePreference, required User meUser}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser.id}/update"),
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

  Future<User> changeTargetSaving(
      {required double monthlyTargetSaving, required User meUser}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser.id}/update"),
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

  Future<User> changePinCode(
      {required int pinCode, required User meUser}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser.id}/update"),
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

  Future<bool> removePinCode(User meUser) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser.id}/update"),
      body: <String, String>{
        "pin_code": "None",
      },
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> changeName({required String name, required User meUser}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser.id}/update"),
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

  Future<User> changeAvatar(
      {required int avatarID, required User meUser}) async {
    final res = await http.put(
      Uri.parse("http://$localhost/user/${meUser.id}/update"),
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
