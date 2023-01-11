import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CircleProcessChart extends StatelessWidget {
  const CircleProcessChart({
    super.key,
    this.percent = 0,
    this.arcWidth = 3,
    this.color = AppColors.primary_01,
    this.child,
    this.onTap,
  });
  final double percent;
  final int arcWidth;
  final Color color;
  final Widget? child;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          IgnorePointer(
            child: charts.PieChart<int>(
              [
                charts.Series<double, int>(
                  id: 'Percent',
                  domainFn: (_, index) => index ?? 0,
                  measureFn: (double per, _) => per,
                  colorFn: (_, index) => charts.ColorUtil.fromDartColor(
                      (index ?? 0) == 0 ? color : Colors.white),
                  data: [percent, 100 - percent],
                )
              ],
              animate: true,
              // Configure the width of the pie slices to 60px. The remaining space in
              // the chart will be left as a hole in the center.
              defaultRenderer: charts.ArcRendererConfig(arcWidth: arcWidth),

              layoutConfig: charts.LayoutConfig(
                leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                topMarginSpec: charts.MarginSpec.fixedPixel(0),
                rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: child ??
                Padding(
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
      ),
    );
  }
}
