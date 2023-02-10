import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;

enum DataType { inday, month, year }

extension DataTypeX on DataType {}

class SimpleLineChart extends StatefulWidget {
  const SimpleLineChart({
    super.key,
    required this.data,
    required this.getData,
  });

  final StockModel data;
  // final Future future;
  final Future<StockTradingHistory?> Function() getData;
  @override
  State<SimpleLineChart> createState() => _SimpleLineChartState();
}

class _SimpleLineChartState extends State<SimpleLineChart> {
  StockTradingHistory chartData = StockTradingHistory.nullChartData();
  num annotation = 1;
  num max = 2;
  num min = 0;
  num length = 2;

  @override
  void initState() {
    super.initState();
    // print("init");
    getChartData();
  }

  Future<void> getChartData() async {
    // print("calling history api");
    final response = await widget.getData.call();
    if (response == null || response.o == null) {
      return;
    } else if (response.o!.length == 1) {
      chartData =
          StockTradingHistory.oneChartData(defaultValue: response.o!.first);
      annotation = response.o!.first;
      max = annotation + 1;
      min = annotation - 1;
      length = 2;
    } else {
      setState(() {
        chartData = response;
        annotation = widget.data.stockData.r.value ?? (response.o!.first);
        max = math.max<num>(response.o!.reduce(math.max), annotation);
        min = math.min<num>(response.o!.reduce(math.min), annotation);
        length = response.o!.length;
      });
    }
  }

  List<charts.Series<num, int>> toSeries(StockTradingHistory chartData) => [
        charts.Series<num, int>(
          id: "SimpleChart",
          domainFn: (_, index) => index ?? 0,
          measureFn: (datum, index) => datum,
          data: chartData.o!,
          seriesColor:
              charts.ColorUtil.fromDartColor(widget.data.stockData.color),
        ),
      ];

  @override
  void didUpdateWidget(covariant SimpleLineChart oldWidget) {
    // print(widget.data.stockData.sstatus.name);
    if (oldWidget.data.stock.stockCode != widget.data.stock.stockCode ||
        oldWidget.data.stockData.sstatus != widget.data.stockData.sstatus ||
        chartData.lastUpdatedTime == null ||
        DateTime.now().difference(chartData.lastUpdatedTime!).inMinutes > 5) {
      if (mounted) {
        // print("rebuilt");
        getChartData();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

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
            zeroBound: false,
          ),
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
