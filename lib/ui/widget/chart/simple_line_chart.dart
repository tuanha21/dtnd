import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;

class SimpleLineChart extends StatefulWidget {
  const SimpleLineChart({
    super.key,
    this.data,
    this.annotation,
    this.color,
  });

  final List<num>? data;
  final num? annotation;
  final Color? color;
  @override
  State<SimpleLineChart> createState() => _SimpleLineChartState();
}

class _SimpleLineChartState extends State<SimpleLineChart> {
  List<num> chartData = [];
  num annotation = 1;
  num max = 2;
  num min = 0;
  num length = 2;

  @override
  void initState() {
    super.initState();
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
      setState(() {});
    }
  }

  List<charts.Series<num, int>> toSeries(List<num> chartData) => [
        charts.Series<num, int>(
          id: "SimpleChart",
          domainFn: (_, index) => index ?? 0,
          measureFn: (datum, index) => datum,
          data: chartData,
          seriesColor: charts.ColorUtil.fromDartColor(
              widget.color ?? AppColors.semantic_02),
        ),
      ];

  // @override
  // void didUpdateWidget(covariant SimpleLineChart oldWidget) {
  //   // print(widget.data.stockData.sstatus.name);
  //   if (oldWidget.data?.stock.stockCode != widget.data?.stock.stockCode ||
  //       oldWidget.data?.stockData.sstatus != widget.data?.stockData.sstatus ||
  //       chartData.lastUpdatedTime == null ||
  //       DateTime.now().difference(chartData.lastUpdatedTime!).inMinutes > 5) {
  //     if (mounted) {
  //       // print("rebuilt");
  //       getChartData();
  //     }
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    // print("built code ${widget.data.stock.stockCode}");
    return AbsorbPointer(
      child: charts.LineChart(
        toSeries(chartData),
        animate: false,
        layoutConfig: charts.LayoutConfig(
          leftMarginSpec: charts.MarginSpec.fixedPixel(3),
          topMarginSpec: charts.MarginSpec.fixedPixel(3),
          rightMarginSpec: charts.MarginSpec.fixedPixel(3),
          bottomMarginSpec: charts.MarginSpec.fixedPixel(3),
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
        defaultRenderer: charts.LineRendererConfig(smoothLine: true),
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
    );
  }
}
