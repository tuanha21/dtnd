import 'dart:math';

import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AssetChart extends StatefulWidget {
  const AssetChart({super.key, this.lineColor = AppColors.semantic_01});
  final Color lineColor;
  @override
  State<AssetChart> createState() => _AssetChartState();
}

class _AssetChartState extends State<AssetChart> {
  final Random random = Random();

  int get fakeData => random.nextInt(1000);

  List<int> datas = [
    // 65,
    // 8,
    // 90,
    // 81,
    // 56,
    // 55,
    // 40,
    // 73,
    // 82,
    // 93,
    // 120,
    // 56,
    // 75,
    // 63,
    // 73,
    // 27,
    // 94,
    // 81,
    // 56,
    // 55,
    // 40,
    // 73,
    // 82,
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 30; i++) {
      datas.add(fakeData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<int, int>> series = [
      charts.Series<int, int>(
        id: 'volatility',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(widget.lineColor),
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
        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
      ),
      domainAxis:
          const charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
    );
  }
}
