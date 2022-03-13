import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStepper extends CustomPainter {
  final double width;
  final int selectedPage;

  MyStepper(this.width, this.selectedPage);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 1;
    double sharpness = 6;
    int selected = selectedPage+1;
    Path path = Path();
    List<Offset> offsets = [
      Offset((width / 3) * (selected - 1) - sharpness, 0),
      Offset((width / 3) * selected - sharpness, 0),
      Offset((width / 3) * selected - sharpness, 36),
      Offset((width / 3) * (selected - 1) - sharpness, 36),
    ];
    if (selected != 1) {
      offsets.add(Offset((width / 3) * (selected - 1) + sharpness, 18));
    }
    if (selected != 3) {
      offsets.insert(
        2,
        Offset((width / 3) * selected + sharpness, 18),
      );
    } else {
      offsets.insert(2, Offset((width / 3) * 3 + sharpness + 10, 36));
      offsets.insert(2, Offset((width / 3) * 3 + sharpness + 10, 0));
    }
    path.addPolygon(
      offsets,
      true,
    );
    canvas.drawPath(path, paint);
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(Offset((width / 3) * i - sharpness, 0),
          Offset((width / 3) * i + sharpness, 18), paint);
      canvas.drawLine(Offset((width / 3) * i + sharpness, 18),
          Offset((width / 3) * i - sharpness, 36), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
