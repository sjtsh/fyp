import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Entities/users.dart';

class ThemeManagement
    with ChangeNotifier, DiagnosticableTreeMixin, ColorVariables {
  bool isDark = false;

  setTheme(isDark) {
    this.isDark = isDark;
    if (isDark) {

      background = Color(0xff1D1E20);
      allTextColor = Colors.white;
      allTextColorOpacity5 = Colors.white.withOpacity(0.5);
      allTextColorOpacity1 = Colors.white.withOpacity(0.1);
      allIconColor = Colors.white;
      allIconColorOpacity5 = Colors.white;
      allTextColorNegative = Colors.black;
      allIconColorNegative = Colors.black;
      containerColors = Color(0xff333436);

      transaparentTextButtonColorOpacity05 = Colors.white.withOpacity(0.1);
      materialButtonColor = Color(0xffC4C4C4);
      logoBgColorOpacity5 = Colors.transparent;
      logoBgColor = Colors.transparent;
      headerTextColorOpacity7 = Colors.white;
      monthlyTargetSavingText = Color(0xff6F9B4E);
      monthlyTargetSavingTextOpacity5 = Color(0xff6F9B4E).withOpacity(0.5);
      textfieldBackgroundColor = const Color(0xff333436);
      lineChartColorPredicted = Color(0xffC31FE6);
      lineChartColorActualOpacity7 = Color(0xff3A57E8).withOpacity(0.7);
      lineChartColorPredictedOpacity5 = Color(0xffC31FE6).withOpacity(0.5);
      lineChartColorActual = Color(0xff3A57E8);
      exceededIncomeColor = Color(0xff6F9B4E);
      exceededExpenseColor = Color(0xffCE5858);
      transactionExceededIncomeColor = Color(0xff6F9B4E);
      transactionExceededExpenseColor = Color(0xffCE5858);
      transactionNotExceededColor = Colors.black.withOpacity(0.1);

      shimmerGradient = LinearGradient(
        colors: [Color(0xff242424), Color(0xff4c4c4c)],
      );
      pieChartColors = [
        const Color(0xffC31FE6),
        const Color(0xff3A57E8),
        Colors.blue,
        Colors.red,
        Colors.orange,
        Colors.green,
      ];
      radarChartColors = [
        const Color(0xffC31FE6),
        const Color(0xff3A57E8),
        Colors.green,
      ];
    } else {
      background = Color(0xffF4F4F4);

      // Color background =  Color(0xff1D1E20);
      allTextColor = Colors.black;
      allTextColorOpacity5 = Colors.black.withOpacity(0.5);
      allTextColorOpacity1 = Colors.black.withOpacity(0.1);
      allIconColor = Colors.black;
      allIconColorOpacity5 = Colors.black;
      allTextColorNegative = Colors.white;
      allIconColorNegative = Colors.white;
      containerColors = Colors.white;
      transaparentTextButtonColorOpacity05 = Colors.black.withOpacity(0.05);

      materialButtonColor = Color(0xffC4C4C4);
      logoBgColorOpacity5 = Color(0xff5A6FF0).withOpacity(0.5);
      logoBgColor = Color(0xff5A6FF0);
      headerTextColorOpacity7 = Color(0xffC31FE6).withOpacity(0.7);
      monthlyTargetSavingText = Color(0xff0B8B00);
      monthlyTargetSavingTextOpacity5 = Color(0xff0B8B00).withOpacity(0.5);
      textfieldBackgroundColor = const Color(0xffE9E9E9);
      lineChartColorPredicted = Color(0xffC31FE6);
      lineChartColorActualOpacity7 = Color(0xff3A57E8).withOpacity(0.7);
      lineChartColorPredictedOpacity5 = Color(0xffC31FE6).withOpacity(0.5);
      lineChartColorActual = Color(0xff3A57E8);
      exceededIncomeColor = Color(0xffCBF8DD);
      exceededExpenseColor = Color(0xffF8CBCB);
      transactionExceededIncomeColor = Color(0xff0B8B00);
      transactionExceededExpenseColor = Color(0xffFF0000);
      transactionNotExceededColor = Colors.black.withOpacity(0.1);

      shimmerGradient = LinearGradient(colors: [Colors.white, Colors.grey]);
      pieChartColors = [
        const Color(0xffC31FE6),
        const Color(0xff3A57E8),
        Colors.blue,
        Colors.red,
        Colors.orange,
        Colors.green,
      ];
      radarChartColors = [
        const Color(0xffC31FE6),
        const Color(0xff3A57E8),
        Colors.green,
      ];
    }
    notifyListeners();
  }
}

class ColorVariables {
  Color background = Color(0xff1D1E20);
  Color allTextColor = Colors.white;
  Color allTextColorOpacity5 = Colors.white.withOpacity(0.5);
  Color allTextColorOpacity1 = Colors.white.withOpacity(0.1);
  Color allIconColor = Colors.white;
  Color allIconColorOpacity5 = Colors.white;
  Color allTextColorNegative = Colors.black;
  Color allIconColorNegative = Colors.black;
  Color containerColors = Color(0xff333436);

  Color transaparentTextButtonColorOpacity05 = Colors.white.withOpacity(0.1);
  Color materialButtonColor = Color(0xffC4C4C4);
  Color logoBgColorOpacity5 = Colors.black.withOpacity(0.5);
  Color logoBgColor = Colors.black;
  Color headerTextColorOpacity7 = Colors.white;
  Color monthlyTargetSavingText = Color(0xff6F9B4E);
  Color monthlyTargetSavingTextOpacity5 = Color(0xff6F9B4E).withOpacity(0.5);
  Color textfieldBackgroundColor = const Color(0xff333436);
  Color lineChartColorPredicted = Color(0xffC31FE6);
  Color lineChartColorActualOpacity7 = Color(0xff3A57E8).withOpacity(0.7);
  Color lineChartColorPredictedOpacity5 = Color(0xffC31FE6).withOpacity(0.5);
  Color lineChartColorActual = Color(0xff3A57E8);
  Color exceededIncomeColor = Color(0xff6F9B4E);
  Color exceededExpenseColor = Color(0xffCE5858);
  Color transactionExceededIncomeColor = Color(0xff6F9B4E);
  Color transactionExceededExpenseColor = Color(0xffCE5858);
  Color transactionNotExceededColor = Colors.black.withOpacity(0.1);

  LinearGradient shimmerGradient = LinearGradient(
    colors: [Color(0xff242424), Color(0xff4c4c4c)],
  );
  List pieChartColors = [
    const Color(0xffC31FE6),
    const Color(0xff3A57E8),
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.green,
  ];
  List radarChartColors = [
    const Color(0xffC31FE6),
    const Color(0xff3A57E8),
    Colors.green,
  ];
}
