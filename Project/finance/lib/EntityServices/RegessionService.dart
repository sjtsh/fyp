import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Providers/AnalysisManagement.dart';
import '../database.dart';

class RegressionService {
  Future<bool> fetchLinearModels(int userID, BuildContext context) async {
    final res = await http.get(
      Uri.parse("http://$localhost/linearmodel/$userID/"),
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> values = jsonDecode(res.body);
      Map<String, dynamic> actualValue = values["actual"];
      actualValue.forEach((key, value) =>
          context.read<AnalysisManagement>().actualData15[key] = value + 0.0);

      Map<String, dynamic> predictedValue = values["predicted"];
      predictedValue.forEach((key, value) =>
          context.read<AnalysisManagement>().predictedData15[key] = value + 0.0);

      Map<String, dynamic> lastValue = values["last_month"];
      lastValue.forEach((key, value) =>
          context.read<AnalysisManagement>().lastMonthData30[key] = value + 0.0);

      await http.get(
        Uri.parse("http://$localhost/linearmodel/$userID/train"),
      );

      return true;
    } else {
      throw Exception("unsuccessful");
    }
  }
}
