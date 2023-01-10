import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CircleProcessChart extends StatelessWidget {
  const CircleProcessChart({
    super.key,
    this.percent = 0,
    this.arcWidth = 8,
  });
  final double percent;
  final int arcWidth;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        charts.PieChart<int>(
          [
            charts.Series<double, int>(
              id: 'Percent',
              domainFn: (_, index) => index ?? 0,
              measureFn: (double per, _) => per,
              colorFn: (_, index) => charts.ColorUtil.fromDartColor(
                  (index ?? 0) == 0 ? AppColors.primary_01 : Colors.white),
              data: [percent, 100 - percent],
            )
          ],
          animate: true,
          // Configure the width of the pie slices to 60px. The remaining space in
          // the chart will be left as a hole in the center.
          defaultRenderer: charts.ArcRendererConfig(arcWidth: 3),

          layoutConfig: charts.LayoutConfig(
            leftMarginSpec: charts.MarginSpec.fixedPixel(0),
            topMarginSpec: charts.MarginSpec.fixedPixel(0),
            rightMarginSpec: charts.MarginSpec.fixedPixel(0),
            bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "$percent%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
