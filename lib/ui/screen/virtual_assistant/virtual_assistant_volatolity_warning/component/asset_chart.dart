import 'dart:math';

import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AssetChart extends StatefulWidget {
  const AssetChart({super.key});

  @override
  State<AssetChart> createState() => _AssetChartState();
}

class _AssetChartState extends State<AssetChart> {
  final Random random = Random();

  int get fakeData => random.nextInt(10);

  List<int> datas = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 20; i++) {
      datas.add(fakeData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<int, int>> series = [
      charts.Series<int, int>(
        id: 'volatility',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.semantic_01),
        domainFn: (int volatility, index) => index!,
        measureFn: (int volatility, _) => volatility,
        data: datas,
      )
    ];
    return charts.LineChart(
      series,
      animate: true,
      defaultRenderer: charts.LineRendererConfig(smoothLine: true),
      primaryMeasureAxis: const charts.NumericAxisSpec(
          renderSpec: charts.NoneRenderSpec(),
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(zeroBound: false)),
      domainAxis:
          const charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }
}
