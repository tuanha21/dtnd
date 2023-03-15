import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/color_util.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;

class SimpleLineAreaChart extends StatefulWidget {
  const SimpleLineAreaChart({
    super.key,
    this.data,
    this.annotation,
    this.color,
  });

  final List<num>? data;
  final num? annotation;
  final Color? color;
  @override
  State<SimpleLineAreaChart> createState() => _SimpleLineAreaChartState();
}

class _SimpleLineAreaChartState extends State<SimpleLineAreaChart> {
  List<num> chartData = [];
  num annotation = 1;
  num max = 2;
  num min = 0;
  num length = 2;
  late Color color;

  MaterialColor get areaColor => (color == AppColors.semantic_01)
      ? (greenColor)
      : (color == AppColors.semantic_03)
          ? (redColor)
          : (color == AppColors.semantic_05)
              ? (purpilColor)
              : (color == AppColors.semantic_04)
                  ? (blueColor)
                  : (yellowColor);

  @override
  void initState() {
    super.initState();
    getChartData();
  }

  Future<void> getChartData() async {
    // print("calling history api");
    if (widget.data?.isEmpty ?? true) {
      return;
    } else if (widget.data!.length == 1) {
      chartData = widget.data!;
      annotation = chartData.first;
      max = annotation + 1;
      min = annotation - 1;
      length = 2;
    } else {
      chartData = widget.data!;
      annotation = widget.annotation ?? chartData.first;
      max = math.max<num>(chartData.reduce(math.max), annotation);
      min = math.min<num>(chartData.reduce(math.min), annotation);
      length = chartData.length;
    }
    if (mounted) {
      setState(() {
        color = widget.color ?? AppColors.semantic_02;
      });
    }
  }

  List<charts.Series<num, int>> toSeries(List<num> chartData) => [
        charts.Series<num, int>(
          id: "SimpleChart",
          domainFn: (_, index) => index ?? 0,
          measureFn: (datum, index) => datum,
          data: chartData,
          seriesColor: charts.ColorUtil.fromDartColor(color),
        ),
      ];

  @override
  void didUpdateWidget(covariant SimpleLineAreaChart oldWidget) {
    // print(widget.data.stockData.sstatus.name);
    if (oldWidget.data != widget.data) {
      if (mounted) {
        // print("rebuilt");
        getChartData();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // logger.v(widget.data);
    // print("built code ${widget.data.stock.stockCode}");
    return SizedBox(
      height: 60,
      child: AbsorbPointer(
        child: Stack(
          children: [
            // ShaderMask(
            //   shaderCallback: (Rect bounds) {
            //     return LinearGradient(
            //       begin: Alignment.bottomCenter,
            //       end: Alignment.topCenter,
            //       colors: [
            //         Colors.transparent,
            //         areaColor.shade300,
            //         areaColor.shade400,
            //         areaColor.shade500,
            //         areaColor.shade600,
            //         areaColor.shade700,
            //         areaColor.shade800,
            //       ],
            //       stops: const [
            //         0.2,
            //         0.3,
            //         0.4,
            //         0.5,
            //         0.6,
            //         0.8,
            //         0.9,
            //       ],
            //     ).createShader(bounds);
            //   },
            //   blendMode: BlendMode.srcATop,
            //   child: charts.LineChart(
            //     toSeries(chartData),
            //     animate: false,
            //     layoutConfig: charts.LayoutConfig(
            //       leftMarginSpec: charts.MarginSpec.fixedPixel(0),
            //       topMarginSpec: charts.MarginSpec.fixedPixel(0),
            //       rightMarginSpec: charts.MarginSpec.fixedPixel(0),
            //       bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
            //     ),
            //     primaryMeasureAxis: charts.NumericAxisSpec(
            //       showAxisLine: false,
            //       renderSpec: const charts.NoneRenderSpec(),
            //       viewport: charts.NumericExtents(
            //         min,
            //         max,
            //       ),
            //       tickProviderSpec: const charts.BasicNumericTickProviderSpec(
            //           dataIsInWholeNumbers: false,
            //           desiredTickCount: 4,
            //           zeroBound: false),
            //     ),
            //     domainAxis: charts.NumericAxisSpec(
            //       showAxisLine: false,
            //       renderSpec: const charts.NoneRenderSpec(),
            //       viewport: charts.NumericExtents(0, length - 1),
            //       tickProviderSpec: const charts.BasicNumericTickProviderSpec(
            //         zeroBound: false,
            //       ),
            //     ),
            //     defaultRenderer: charts.LineRendererConfig(
            //       smoothLine: true,
            //       includeArea: true,
            //       areaOpacity: 0.3,
            //     ),
            //     behaviors: [
            //       charts.RangeAnnotation(
            //         [
            //           charts.LineAnnotationSegment(
            //             annotation,
            //             charts.RangeAnnotationAxisType.measure,
            //             color: charts.ColorUtil.fromDartColor(
            //               AppColors.neutral_02,
            //             ),
            //             dashPattern: [5, 5],
            //             strokeWidthPx: 0.3,
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            charts.LineChart(
              toSeries(chartData),
              animate: false,
              layoutConfig: charts.LayoutConfig(
                leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                topMarginSpec: charts.MarginSpec.fixedPixel(0),
                rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                showAxisLine: false,
                renderSpec: const charts.NoneRenderSpec(),
                viewport: charts.NumericExtents(
                  min,
                  max,
                ),
                tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                    dataIsInWholeNumbers: false,
                    desiredTickCount: 4,
                    zeroBound: false),
              ),
              domainAxis: charts.NumericAxisSpec(
                showAxisLine: false,
                renderSpec: const charts.NoneRenderSpec(),
                viewport: charts.NumericExtents(0, length - 1),
                tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
                ),
              ),
              defaultRenderer: charts.LineRendererConfig(
                smoothLine: true,
                includeArea: true,
                areaOpacity: 0.3,
              ),
              behaviors: [
                charts.RangeAnnotation(
                  [
                    charts.LineAnnotationSegment(
                      annotation,
                      charts.RangeAnnotationAxisType.measure,
                      color: charts.ColorUtil.fromDartColor(
                        AppColors.neutral_02,
                      ),
                      dashPattern: [5, 5],
                      strokeWidthPx: 0.3,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
