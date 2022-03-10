import '../Entities/users.dart';
import '../database.dart';
import 'package:http/http.dart' as http;

class CorrectionService {
  Future<bool> createCorrection({
    required String remark,
    required String amount,
    required User meUser
  }) async {
    final res = await http.post(
      Uri.parse("http://$localhost/correction/insert/"),
      body: <String, String>{
        'user': meUser.id.toString(),
        'correction': amount.toString(),
        'remark': remark.toString(),
      },
    );

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
