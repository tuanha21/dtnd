import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;

const List<String> _label = ["1M", "3M", "6M", "1Y"];

class SignalChart extends StatefulWidget {
  const SignalChart({super.key, required this.stockModel});
  final StockModel stockModel;
  @override
  State<SignalChart> createState() => _SignalChartState();
}

class _SignalChartState extends State<SignalChart> {
  final IDataCenterService dataCenterService = DataCenterService();
  String currentPeriod = _label.first;
  StockTradingHistory? datas;
  num annotation = 1;
  num max = 2;
  num min = 0;
  num length = 2;

  num maxX = 1;
  num minX = 0;

  @override
  void initState() {
    super.initState();
    getDatas();
  }

  Future<void> getDatas() async {
    final now = DateTime.now();
    final DateTime from;
    switch (currentPeriod) {
      case "3M":
        from = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
        break;
      case "6M":
        from = TimeUtilities.getPreviousDateTime(TimeUtilities.month(6));
        break;
      case "1Y":
        from = TimeUtilities.getPreviousDateTime(TimeUtilities.year(1));
        break;
      default:
        from = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    }
    final history = await dataCenterService.getStockTradingHistory(
        widget.stockModel.stock.stockCode, "1D", from, now);
    if (history == null || (history.c?.isEmpty ?? true)) {
      return;
    } else {
      setState(() {
        datas = history;
        max = datas!.c!.reduce(math.max);
        min = datas!.c!.reduce(math.min);
        length = datas!.c!.length;
        maxX = datas!.t?.reduce(math.max) ?? 1;
        minX = datas!.t?.reduce(math.min) ?? 0;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < _label.length; i++)
              Padding(
                padding: EdgeInsets.only(left: i != 0 ? 4 : 0),
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: InkWell(
                    onTap: () {
                      if (_label[i] != currentPeriod) {
                        setState(() {
                          currentPeriod = _label[i];
                          getDatas();
                        });
                      }
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        color: _label[i] == currentPeriod
                            ? AppColors.primary_03
                            : AppColors.neutral_06,
                      ),
                      child: Text(
                        _label[i],
                        style: AppTextStyle.labelSmall_10.copyWith(
                            color: _label[i] == currentPeriod
                                ? AppColors.primary_01
                                : null,
                            fontWeight: _label[i] == currentPeriod
                                ? null
                                : FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 16),
        if (datas == null || (datas!.t?.isEmpty ?? true))
          const SizedBox(height: 20)
        else
          SizedBox(
            height: 240,
            child: charts.NumericComboChart(
              [
                charts.Series<num, num>(
                  id: 'signalChart',
                  domainFn: (_, int? index) {
                    var time = datas!.t?[index ?? 0].toInt() ??
                        (DateTime.now().millisecondsSinceEpoch ~/ 1000);
                    return time;
                  },
                  measureFn: (num o, _) {
                    return o;
                  },
                  seriesColor: charts.ColorUtil.fromDartColor(
                      widget.stockModel.stockData.color),
                  data: datas!.o ?? [],
                )..setAttribute(
                    charts.measureAxisIdKey, "secondaryMeasureAxisId"),
              ],
              animate: false,
              layoutConfig: charts.LayoutConfig(
                bottomMarginSpec: charts.MarginSpec.defaultSpec,
                leftMarginSpec: charts.MarginSpec.defaultSpec,
                rightMarginSpec: charts.MarginSpec.defaultSpec,
                topMarginSpec: charts.MarginSpec.defaultSpec,
              ),
              domainAxis: domainSpec(min, max),
              secondaryMeasureAxis: axisSpec(),
              defaultRenderer: charts.LineRendererConfig(smoothLine: true),
              // behaviors: [
              //   charts.RangeAnnotation(
              //     [
              //       charts.LineAnnotationSegment(
              //         annotation,
              //         charts.RangeAnnotationAxisType.measure,
              //         color: charts.ColorUtil.fromDartColor(
              //           AppColors.neutral_02,
              //         ),
              //         dashPattern: [5, 5],
              //         strokeWidthPx: 0.3,
              //       )
              //     ],
              //   )
              // ],
            ),
          ),
      ],
    );
  }

  charts.NumericAxisSpec domainSpec(num minX, num maxX) {
    return charts.NumericAxisSpec(
        tickFormatterSpec: charts.BasicNumericTickFormatterSpec((time) {
          String formattedDate = TimeUtilities.dateMonthTimeFormat.format(
              DateTime.fromMillisecondsSinceEpoch((time?.toInt() ??
                      (DateTime.now().millisecondsSinceEpoch ~/ 1000)) *
                  1000));
          return formattedDate;
        }),
        tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          dataIsInWholeNumbers: true,
          //desiredMaxTickCount: 5,
          zeroBound: false,
        ),
        // viewport: charts.NumericExtents(minX, maxX),
        renderSpec: const charts.GridlineRendererSpec(
            axisLineStyle: charts.LineStyleSpec(
              dashPattern: [4],
              thickness: 0,
              color: charts.Color(r: 74, g: 85, b: 104),
            ),
            labelStyle: charts.TextStyleSpec(fontSize: 9),
            lineStyle: charts.LineStyleSpec(dashPattern: [4])));
  }

  charts.NumericAxisSpec axisSpec() {
    return charts.NumericAxisSpec(
      showAxisLine: true,
      tickProviderSpec: const charts.BasicNumericTickProviderSpec(
        zeroBound: false,
        // desiredTickCount: 5,
        dataIsInWholeNumbers: false,
      ),
      viewport: charts.NumericExtents(min, max),
      renderSpec: const charts.GridlineRendererSpec(
          axisLineStyle: charts.LineStyleSpec(
            dashPattern: [4],
            thickness: 0,
            color: charts.Color(r: 74, g: 85, b: 104),
          ),
          labelStyle: charts.TextStyleSpec(fontSize: 9),
          lineStyle: charts.LineStyleSpec(dashPattern: [4])),
    );
  }
}
