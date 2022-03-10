import 'package:flutter/foundation.dart';

import '../Entities/users.dart';

class LogInManagement with ChangeNotifier, DiagnosticableTreeMixin {
  User? _meUser;

  User? get meUser => _meUser;

  set meUser(User? value) {
    _meUser = value;
  }

  userChange() {
    notifyListeners();
  }

  userChangeAvatar(String url) {
    _meUser = User(
        id: _meUser!.id,
        avatarURL: url,
        name: _meUser!.name,
        monthlyTargetSaving: _meUser!.monthlyTargetSaving,
        bankBalance: _meUser!.bankBalance,
        dateTime: _meUser!.dateTime,
        isDeactivated: false);
    notifyListeners();
  }
}
