import 'dart:convert';
import 'package:finance/Entities/category.dart';
import 'package:finance/Entities/transaction.dart';
import 'package:finance/Entities/transaction.dart';
import 'package:finance/Entities/transaction.dart';
import 'package:http/http.dart' as http;

import '../Entities/users.dart';
import '../database.dart';

class TransactionService {
  Future<List<Transaction>> fetchTransactions(String dropdownValue, User meUser) async {
    final res = await http.get(
      Uri.parse("http://$localhost/transactions/"),
      headers: <String, String>{
        'userID': meUser.id.toString(),
        'dropdownValue': dropdownValue,
      },
    );

    if (res.statusCode == 200) {
      List<dynamic> values = jsonDecode(res.body);
      List<Transaction> transactions =
          values.map((e) => Transaction.fromJson(e)).toList();
      return transactions;
    } else {
      throw Exception("unsuccessful");
    }
  }

  Future<Transaction> createTransaction(
      {required int categoryID,
      required String remark,
      required double amount,required User meUser}) async {
    final res = await http.post(
      Uri.parse("http://$localhost/transaction/insert/"),
      body: <String, String>{
        'user': meUser.id.toString(),
        'category': categoryID.toString(),
        'remark': remark.toString(),
        'amount': amount.toString(),
      },
    );
    if (res.statusCode == 200) {
      Transaction transaction = Transaction.fromJson(jsonDecode(res.body));
      return transaction;
    } else {
      throw Exception("unsuccessful");
    }
  }
}
