import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AssetCatalogRatioChart extends StatelessWidget {
  const AssetCatalogRatioChart({
    super.key,
    this.ratio = 0,
  });

  final double ratio;

  List<charts.Series<double, int>> toSeries(double ratio) {
    final data = [ratio, 100 - ratio];
    return [
      charts.Series<double, int>(
          id: 'Analyse',
          domainFn: (datum, index) => index ?? 0,
          measureFn: (datum, index) => datum,
          colorFn: (datum, index) {
            switch (index) {
              case 0:
                return charts.ColorUtil.fromDartColor(AppColors.semantic_01);
              default:
                return charts.ColorUtil.fromDartColor(AppColors.neutral_04);
            }
          },
          data: data),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      toSeries(ratio),
      animate: false,
      defaultRenderer: charts.ArcRendererConfig<int>(strokeWidthPx: 2),
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
    );
  }
}
