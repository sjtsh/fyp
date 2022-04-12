import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Providers/ThemeManagement.dart';

class RadarSkeleton extends StatelessWidget {
  const RadarSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: context.watch<ThemeManagement>().shimmerGradient,
      child: Container(
      color: Colors.red,
        height: 300,
      ),
    );
  }
}
