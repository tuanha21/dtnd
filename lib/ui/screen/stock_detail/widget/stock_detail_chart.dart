import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../=models=/response/stock_his.dart';
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

class _StockDetailChartState extends State<StockDetailChart> {
  late Future<List<StockHis>> stockTrading;

  final INetworkService iDataCenterService = NetworkService();

  StockTradingHistory chartData = StockTradingHistory.nullChartData();

  TimeSeries timeSeries = TimeSeries.day;

  @override
  void initState() {
    stockTrading = iDataCenterService.getStockHis(
        widget.stockModel.stock.stockCode,
        DateFormat('yyyy-MM-dd').format(timeSeries.dateTime),
        DateFormat('yyyy-MM-dd').format(DateTime.now()));
    super.initState();
  }

  num annotation = 1;
  num max = 2;
  num min = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: FutureBuilder<List<StockHis>>(
              future: stockTrading,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var list = snapshot.data;
                  if (list == null) return const SizedBox();
                  annotation = list.first.lastPrice!;
                  List<num> listValue = list.map((e) => e.lastPrice!).toList();
                  max = math.max<num>(listValue.reduce(math.max), annotation);
                  min = math.min<num>(listValue.reduce(math.min), annotation);

                  return Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: charts.NumericComboChart(
                      List<charts.Series<num, num>>.generate(
                          listValue.length,
                          (index) => charts.Series<num, num>(
                                id: 'chart1',
                                colorFn: (_, __) =>
                                    charts.ColorUtil.fromDartColor(
                                        widget.stockModel.stockData.color),
                                domainFn: (num indexBoard, int? index) =>
                                    index!,
                                measureFn: (num sales, _) {
                                  return sales;
                                },
                                data: listValue,
                              )..setAttribute(charts.measureAxisIdKey,
                                  "secondaryMeasureAxisId")),
                      defaultRenderer:
                          charts.LineRendererConfig(smoothLine: true),
                      domainAxis: domainSpec(list
                          .map((e) =>
                              (e.dateTime?.millisecond ?? 0) )
                          .toList()),
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
                        stockTrading = iDataCenterService.getStockHis(
                            widget.stockModel.stock.stockCode,
                            DateFormat('yyyy-MM-dd')
                                .format(timeSeries.dateTime),
                            DateFormat('yyyy-MM-dd').format(DateTime.now()));
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
    return charts.NumericAxisSpec(
        tickFormatterSpec: charts.BasicNumericTickFormatterSpec((index) {
          if (index! < list.length) {
            String formattedDate = DateFormat('HH:mm').format(
                DateTime.fromMillisecondsSinceEpoch(
                    list[index.toInt()].toInt() * 1000));
            return formattedDate;
          }
          return "";
        }),
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

enum TimeSeries { day, week, month, month_3, month_6, year, year_5 }

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
      case TimeSeries.year_5:
        return "5Y";
    }
  }

  DateTime get dateTime {
    switch (this) {
      case TimeSeries.day:
        return TimeUtilities.getPreviousDateTime(const Duration(days: 1));
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
      case TimeSeries.year_5:
        return TimeUtilities.getPreviousDateTime(const Duration(days: 1825));
    }
  }
}
