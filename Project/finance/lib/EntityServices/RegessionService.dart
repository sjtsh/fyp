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
      context.read<AnalysisManagement>().actualData15 = values["actual"];
      context.read<AnalysisManagement>().predictedData15 = values["predicted"];
      context.read<AnalysisManagement>().lastMonthData30 = values["last_month"];
      return true;
    } else {
      throw Exception("unsuccessful");
    }
  }
}
