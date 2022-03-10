import 'dart:convert';

import 'package:finance/Entities/avatar.dart';
import 'package:http/http.dart' as http;

import '../database.dart';

class AvatarService{

  Future<List<Avatar>> fetchAvatars() async {
    final res = await http.get(
      Uri.parse("http://$localhost/avatars/"),
    );
    if (res.statusCode == 200) {
      List<dynamic> values = jsonDecode(res.body);
      List<Avatar> avatars =
      values.map((e) => Avatar.fromJson(e)).toList();
      return avatars;
    } else {
      throw Exception("unsuccessful");
    }
  }

}