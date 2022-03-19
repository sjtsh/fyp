import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Entities/users.dart';

class AnalysisManagement with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, int> actualData15 = {};
  Map<String, int> predictedData15 = {};
  Map<String, int> lastMonthData30 = {};
}
