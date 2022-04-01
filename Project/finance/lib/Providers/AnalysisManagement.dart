import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Entities/users.dart';

class AnalysisManagement with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, double> actualData15 = {};
  Map<String, double> predictedData15 = {};
  Map<String, double> lastMonthData30 = {};
}
