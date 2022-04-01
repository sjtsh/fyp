import 'dart:convert';

import 'package:finance/Entities/avatar.dart';
import 'package:http/http.dart' as http;

import '../Entities/related_word.dart';
import '../Entities/users.dart';
import '../database.dart';

class RelatedWordService {
  Future<List<RelatedWord>> fetchRelatedWords(User user) async {
    final res = await http.get(
      Uri.parse("http://$localhost/relatedwords/${user.id}"),
    );
    if (res.statusCode == 200) {
      List<dynamic> values = jsonDecode(res.body);
      List<RelatedWord> relatedWords =
          values.map((e) => RelatedWord.fromJson(e)).toList();
      return relatedWords;
    } else {
      throw Exception("unsuccessful");
    }
  }
}
