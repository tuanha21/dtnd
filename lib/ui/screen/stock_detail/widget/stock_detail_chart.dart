import 'dart:async';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../=models=/response/stock_trading_history.dart';
import '../../../../data/i_data_center_service.dart';
import '../../../../data/implementations/data_center_service.dart';
import '../../../../utilities/time_utils.dart';
import 'dart:math' as math;

class StockDetailChart extends StatefulWidget {
  const StockDetailChart({
    super.key,
    required this.stockModel,
  });

  final StockModel stockModel;

  @override
  State<StockDetailChart> createState() => _StockDetailChartState();
}

class _StockDetailChartState extends State<StockDetailChart>
    with AutomaticKeepAliveClientMixin {
  late StreamController<List<num>> stockTrading = StreamController.broadcast();

  final INetworkService iNetworkService = NetworkService();

  final IDataCenterService iDataCenterService = DataCenterService();

  StockTradingHistory chartData = StockTradingHistory.nullChartData();

  TimeSeries timeSeries = TimeSeries.day;

  StockTradingHistory? stockTradingHistory;

  @override
  void initState() {
    getStockTradingHistory();
    super.initState();
  }

  Future<void> getStockTradingHistory() async {
    try {
      stockTradingHistory = await iDataCenterService.getStockTradingHistory(
          widget.stockModel.stock.stockCode,
          timeSeries.type,
          timeSeries.dateTime,
          DateTime.now());
      stockTrading.sink.add(stockTradingHistory!.o!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<num> get listTime {
    if (stockTradingHistory == null) return [];
    return stockTradingHistory!.t!;
  }

  num annotation = 1;
  num max = 2;
  num min = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: StreamBuilder<List<num>>(
              stream: stockTrading.stream,
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var list = snapshot.data;
                  if (list == null || list.isEmpty) return const SizedBox();
                  annotation = list.first;
                  max = math.max<num>(list.reduce(math.max), annotation);
                  min = math.min<num>(list.reduce(math.min), annotation);
                  return Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: charts.NumericComboChart(
                      List<charts.Series<num, num>>.generate(
                          list.length,
                          (index) => charts.Series<num, num>(
                                id: 'chart1',
                                colorFn: (_, __) =>
                                    charts.ColorUtil.fromDartColor(
                                        widget.stockModel.stockData.color),
                                domainFn: (num indexBoard, int? index) {
                                  return listTime[index!].toInt();
                                },
                                measureFn: (num sales, _) {
                                  return sales;
                                },
                                data: list,
                              )..setAttribute(charts.measureAxisIdKey,
                                  "secondaryMeasureAxisId")),
                      defaultRenderer:
                          charts.LineRendererConfig(smoothLine: true),
                      domainAxis: domainSpec(listTime),
                      secondaryMeasureAxis: axisSpec(),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ),
        const SizedBox(height: 10),
        Row(
          children: List<Widget>.generate(
              TimeSeries.values.length,
              (index) => Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        timeSeries = TimeSeries.values[index];
                        getStockTradingHistory();
                      });
                    },
                    child: Container(
                        height: 22,
                        margin: EdgeInsets.only(left: index == 0 ? 0 : 7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.neutral_05,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          TimeSeries.values[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: timeSeries == TimeSeries.values[index]
                                      ? AppColors.primary_01
                                      : AppColors.text_black),
                        )),
                  ))),
        )
      ],
    );
  }

  charts.NumericAxisSpec domainSpec(List<num> list) {
    var now = DateTime.now();
    var min =
        DateTime(now.year, now.month, now.day, 9, 0).millisecondsSinceEpoch;
    var max =
        DateTime(now.year, now.month, now.day, 14, 30).millisecondsSinceEpoch;

    return charts.NumericAxisSpec(
        tickFormatterSpec: charts.BasicNumericTickFormatterSpec((time) {
          if (timeSeries == TimeSeries.day) {
            String formattedDate = DateFormat('HH:mm').format(
                DateTime.fromMillisecondsSinceEpoch(time!.toInt() * 1000));
            return formattedDate;
          }
          String formattedDate = DateFormat('dd/MM').format(
              DateTime.fromMillisecondsSinceEpoch(time!.toInt() * 1000));
          return formattedDate;
        }),
        tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          dataIsInWholeNumbers: true,
          //desiredMaxTickCount: 5,
          zeroBound: false,
        ),
        viewport: timeSeries == TimeSeries.day
            ? charts.NumericExtents(min / 1000, max / 1000)
            : null,
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
        desiredTickCount: 5,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

enum TimeSeries { day, week, month, month_3, month_6, year }

extension TimeSeriesExt on TimeSeries {
  String get title {
    switch (this) {
      case TimeSeries.day:
        return "1D";
      case TimeSeries.week:
        return "1W";
      case TimeSeries.month:
        return "1M";
      case TimeSeries.month_3:
        return "3M";
      case TimeSeries.month_6:
        return "6M";
      case TimeSeries.year:
        return "1Y";
    }
  }

  DateTime get dateTime {
    switch (this) {
      case TimeSeries.day:
        {
          var now = DateTime.now();
          return DateTime(now.year, now.month, now.day, 9, 0);
        }
      case TimeSeries.week:
        return TimeUtilities.getPreviousDateTime(const Duration(days: 7));
      case TimeSeries.month:
        return TimeUtilities.getPreviousDateTime(const Duration(days: 30));
      case TimeSeries.month_3:
        return TimeUtilities.getPreviousDateTime(const Duration(days: 90));
      case TimeSeries.month_6:
        return TimeUtilities.getPreviousDateTime(const Duration(days: 180));
      case TimeSeries.year:
        return TimeUtilities.getPreviousDateTime(const Duration(days: 365));
    }
  }

  String get type {
    switch (this) {
      case TimeSeries.day:
        return "5";
      default:
        {
          return "D";
        }
    }
  }
}
