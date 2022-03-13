import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Entities/avatar.dart';
import '../Entities/users.dart';

class SignUpManagement with ChangeNotifier, DiagnosticableTreeMixin {
  TextEditingController currentBalanceController = TextEditingController();
  TextEditingController targetSavingController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController comfirmPinController = TextEditingController();
  Avatar? selected;
  String? name;
  String? gmail;
  bool get isDark => _isDark;

  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }

  bool _isDark = true;

}
