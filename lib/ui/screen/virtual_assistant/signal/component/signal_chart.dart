import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/top_signal_stock_model.dart';
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
  const SignalChart({super.key, required this.stockModel, required this.data});
  final StockModel stockModel;
  final TopSignalStockModel data;
  @override
  State<SignalChart> createState() => _SignalChartState();
}

class _SignalChartState extends State<SignalChart> {
  final IDataCenterService dataCenterService = DataCenterService();
  String currentPeriod = _label.first;
  StockTradingHistory? datas;
  late num annotationX;
  late DateTime annotationY;
  charts.RangeAnnotation? rangeAnnotation;
  num max = 2;
  num min = 0;
  num length = 2;

  num maxX = 1;
  num minX = 0;

  @override
  void initState() {
    print(widget.data.cBUYPRICE);
    print(widget.data.cBUYDATE);
    annotationX = widget.data.cBUYPRICE;
    annotationY = widget.data.cBUYDATE;
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
    if (history == null || (history.c.isEmpty)) {
      return;
    } else {
      setState(() {
        datas = history;
        max = datas!.c.reduce(math.max);
        min = datas!.c.reduce(math.min);
        length = datas!.c.length;
        maxX = datas!.t.reduce(math.max);
        minX = datas!.t.reduce(math.min);
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
        if (datas == null || (datas!.t.isEmpty))
          const SizedBox(height: 20)
        else
          SizedBox(
            height: 240,
            child: charts.TimeSeriesChart(
              [
                charts.Series<num, DateTime>(
                  id: 'signalChart',
                  domainFn: (_, int? index) {
                    if (index != null) {
                      int epoc = datas!.t[index].toInt() * 1000;
                      return DateTime.fromMillisecondsSinceEpoch(epoc);
                    } else {
                      throw Exception("Chart index null");
                    }
                  },
                  measureFn: (num o, _) {
                    return o;
                  },
                  seriesColor: charts.ColorUtil.fromDartColor(
                      widget.stockModel.stockData.color),
                  data: datas!.o,
                ),
                // ..setAttribute(
                //     charts.measureAxisIdKey, "secondaryMeasureAxisId"),
                charts.Series<num, DateTime>(
                  id: 'signal2Chart',
                  domainFn: (_, int? index) {
                    if (index != null) {
                      int epoc = datas!.t[index].toInt() * 1000;
                      return DateTime.fromMillisecondsSinceEpoch(epoc);
                    } else {
                      throw Exception("Chart index null");
                    }
                  },
                  measureFn: (num o, _) {
                    return o;
                  },
                  seriesColor: charts.ColorUtil.fromDartColor(
                      widget.stockModel.stockData.color),
                  data: datas!.o,
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
              domainAxis: charts.DateTimeAxisSpec(
                  tickFormatterSpec:
                      charts.BasicDateTimeTickFormatterSpec((time) {
                    String formattedDate =
                        TimeUtilities.dateMonthTimeFormat.format(time);
                    return formattedDate;
                  }),
                  tickProviderSpec: const charts.AutoDateTimeTickProviderSpec(),
                  // viewport: charts.NumericExtents(minX, maxX),
                  renderSpec: const charts.GridlineRendererSpec(
                      axisLineStyle: charts.LineStyleSpec(
                        dashPattern: [4],
                        thickness: 0,
                        color: charts.Color(r: 74, g: 85, b: 104),
                      ),
                      labelStyle: charts.TextStyleSpec(fontSize: 9),
                      lineStyle: charts.LineStyleSpec(dashPattern: [4]))),
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
                  dataIsInWholeNumbers: false,
                ),
                viewport: charts.NumericExtents(min, max),
                renderSpec: const charts.NoneRenderSpec(),
              ),
              secondaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
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
              ),
              defaultRenderer: charts.LineRendererConfig(smoothLine: true),
              behaviors: [
                charts.RangeAnnotation<DateTime>(
                  [
                    charts.LineAnnotationSegment<num>(
                      annotationX,
                      charts.RangeAnnotationAxisType.measure,
                      color: charts.ColorUtil.fromDartColor(
                        AppColors.neutral_02,
                      ),
                      startLabel: annotationX.toString(),
                      endLabel: "Giá mua",
                      dashPattern: [5, 5],
                      strokeWidthPx: 0.3,
                    ),
                    charts.LineAnnotationSegment<DateTime>(
                      annotationY,
                      charts.RangeAnnotationAxisType.domain,
                      color: charts.ColorUtil.fromDartColor(
                        AppColors.neutral_02,
                      ),
                      startLabel: "Ngày mua",
                      endLabel:
                          TimeUtilities.commonTimeFormat.format(annotationY),
                      dashPattern: [5, 5],
                      strokeWidthPx: 0.3,
                    )
                  ],
                )
              ],
            ),
          ),
      ],
    );
  }

  charts.RangeAnnotation get anotation => charts.RangeAnnotation(
        [
          charts.LineAnnotationSegment(
            annotationX,
            charts.RangeAnnotationAxisType.measure,
            color: charts.ColorUtil.fromDartColor(
              AppColors.neutral_02,
            ),
            endLabel: "Giá mua",
            dashPattern: [5, 5],
            strokeWidthPx: 0.3,
          ),
          charts.LineAnnotationSegment(
            annotationY,
            charts.RangeAnnotationAxisType.domain,
            color: charts.ColorUtil.fromDartColor(
              AppColors.neutral_02,
            ),
            startLabel: "Ngày mua",
            dashPattern: [5, 5],
            strokeWidthPx: 0.3,
          )
        ],
      );

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
