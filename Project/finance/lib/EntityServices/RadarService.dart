import 'dart:convert';

import 'package:finance/Entities/avatar.dart';
import 'package:http/http.dart' as http;

import '../Entities/users.dart';
import '../database.dart';

class Radar {
  double lastMonthExpense;
  double thisMonthExpense;
  double lastMonthIncome;
  double thisMonthIncome;
  double lastMonthSaving;
  double thisMonthSaving;

  Radar(
    this.lastMonthExpense,
    this.thisMonthExpense,
    this.lastMonthIncome,
    this.thisMonthIncome,
    this.lastMonthSaving,
    this.thisMonthSaving,
  );
}

// {"last_month": {"expense": expenseLastMonth, "income": incomeLastMonth, "saving": savingLastMonth},
// "this_month": {"expense": expenseThisMonth, "income": incomeThisMonth, "saving": savingThisMonth}}

class RadarService {
  Future<Radar> fetchRadarData(User user) async {
    final res = await http.get(
      Uri.parse("http://$localhost/radar/${user.id}/"),
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> values = jsonDecode(res.body);
      Map<String, dynamic> thisMonth = values["this_month"];
      Map<String, dynamic> lastMonth = values["last_month"];
      return Radar(
          lastMonth["expense"] + 0.0,
          thisMonth["expense"] + 0.0,
          lastMonth["income"] + 0.0,
          thisMonth["income"] + 0.0,
          lastMonth["saving"] + 0.0,
          thisMonth["saving"] +0.0);
    } else {
      throw Exception("unsuccessful");
    }
  }
}
