import 'dart:convert';
import 'package:finance/Entities/category.dart';
import 'package:http/http.dart' as http;

import '../Entities/users.dart';
import '../database.dart';

class CategoryService {
  Future<List<Category>> fetchCategorys(User meUser) async {
    final res = await http.get(
      Uri.parse("http://$localhost/categorys/"),
      headers: <String, String>{'userID': meUser.id.toString()},
    );

    if (res.statusCode == 200) {
      List<dynamic> values = jsonDecode(res.body);
      List<Category> categorys =
          values.map((e) => Category.fromJson(e)).toList();
      return categorys;
    } else {
      throw Exception("unsuccessful");
    }
  }

  Future<Category> createCategory({
    required String name,
    required bool isExpense,
    required List<String> words,
    required User meUser
  }) async {
    Map<String, String> aMap = <String, String>{
      'name': name.toString(),
      'user': meUser.id.toString(),
      'is_expense': isExpense ? "True" : "False",
    };
    for (var element in words) {
      aMap[element] = "1";
    }
    final res = await http.post(
      Uri.parse("http://$localhost/category/insert/"),
      body: aMap,
    );
    if (res.statusCode == 200) {
      Category category = Category.fromJson(jsonDecode(res.body));
      return category;
    } else {
      throw Exception("unsuccessful");
    }
  }
}
