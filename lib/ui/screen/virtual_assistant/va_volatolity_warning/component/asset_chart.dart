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

  List<double> datas = [
    1051.66,
    1050.91,
    1052.02,
    1056.87,
    1055.55,
    1053.41,
    1051.47,
    1052.02,
    1048.93,
    1048.16,
    1052.45,
    1052.2,
    1051.99,
    1051.55,
    1051.53,
    1054.18,
    1055.06,
    1056.93,
    1057.91,
    1057.66,
    1058.63,
    1055.88,
    1053.94,
    1053.94,
    1053.85,
    1051.71,
    1052.23,
    1053.49,
    1053.06,
    1051.41,
    1051.9,
    1052.3,
    1051.68,
    1049.42,
    1050.01,
    1052.7,
    1051.84,
    1050.82,
    1051.81,
    1051.91,
    1048.08,
    1048.96,
    1050.25,
    1050.11,
    1052.46,
    1051.68,
    1049.98,
    1050.15,
    1052.32,
    1055.31,
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   for (var i = 0; i < 30; i++) {
  //     datas.add(fakeData);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<double, int>> series = [
      charts.Series<double, int>(
        id: 'volatility',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(widget.lineColor),
        domainFn: (double volatility, index) => index!,
        measureFn: (double volatility, _) => volatility,
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
