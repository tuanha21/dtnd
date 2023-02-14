import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/stock_model.dart';
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

class _StockDetailChartState extends State<StockDetailChart> {
  late Future<StockTradingHistory?> stockTrading;

  final IDataCenterService iDataCenterService = DataCenterService();

  StockTradingHistory chartData = StockTradingHistory.nullChartData();

  @override
  void initState() {
    stockTrading = iDataCenterService.getStockTradingHistory.call(
        widget.stockModel.stock.stockCode,
        "5",
        TimeUtilities.beginningOfDay,
        DateTime.now());
    super.initState();
  }

  num annotation = 1;
  num max = 2;
  num min = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StockTradingHistory?>(
        future: stockTrading,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data;
            if (list == null) return const SizedBox();
            annotation = list.o!.first;
            max = math.max<num>(list.o!.reduce(math.max), annotation);
            min = math.min<num>(list.o!.reduce(math.min), annotation);
            return Padding(
              padding: const EdgeInsets.only(left: 0, right: 20),
              child: charts.NumericComboChart(
                List<charts.Series<num, num>>.generate(
                    list.o!.length,
                    (index) => charts.Series<num, num>(
                          id: 'chart1',
                          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
                              widget.stockModel.stockData.color),
                          domainFn: (num indexBoard, int? index) => index!,
                          measureFn: (num sales, _) {
                            return sales;
                          },
                          data: list.o!,
                        )..setAttribute(
                            charts.measureAxisIdKey, "secondaryMeasureAxisId")),
                defaultRenderer: charts.LineRendererConfig(smoothLine: true),
                domainAxis: domainSpec(list.t!),
                secondaryMeasureAxis: axisSpec(),
              ),
            );
          }
          return const SizedBox();
        });
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
