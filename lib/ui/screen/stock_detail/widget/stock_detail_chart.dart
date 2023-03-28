import 'dart:async';
import 'dart:math' as math;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/sec_event.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/stock_trading_history.dart';
import '../../../../data/i_data_center_service.dart';
import '../../../../data/implementations/data_center_service.dart';
import '../../../../utilities/time_utils.dart';
import '../tab/overview_tab.dart';

class StockDetailChart extends StatefulWidget {
  const StockDetailChart({
    super.key,
    required this.stockModel,
    this.listEvent,
  });

  final StockModel stockModel;
  final List<SecEvent>? listEvent;

  @override
  State<StockDetailChart> createState() => _StockDetailChartState();
}

class _StockDetailChartState extends State<StockDetailChart>
    with AutomaticKeepAliveClientMixin {
  final INetworkService iNetworkService = NetworkService();

  final IDataCenterService iDataCenterService = DataCenterService();

  StockTradingHistory chartData = StockTradingHistory.nullChartData();

  TimeSeries timeSeries = TimeSeries.month_3;

  StockTradingHistory? stockTradingHistory;

  final List<SecEvent> listEvent = [];

  @override
  void initState() {
    getStockTradingHistory();
    getListEvent();
    super.initState();
  }

  Future<void> getStockTradingHistory() async {
    try {
      stockTradingHistory = await iDataCenterService.getStockTradingHistory(
          widget.stockModel.stock.stockCode,
          timeSeries.type,
          timeSeries.dateTime,
          DateTime.now());
      // print("timeSeries: " + timeSeries.type);
      if (stockTradingHistory != null) {
        setState(() {
          max = stockTradingHistory!.c.reduce(math.max);
          min = stockTradingHistory!.c.reduce(math.min);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void getListEvent() {
    listEvent.clear();
    for (SecEvent event in widget.listEvent ?? <SecEvent>[]) {
      if (event.dateTime == null ||
          event.dateTime!.isBefore(timeSeries.dateTime)) {
        continue;
      } else {
        listEvent.add(event);
      }
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(StockDetailChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listEvent?.length != oldWidget.listEvent?.length) {
      getListEvent();
    }
  }

  num max = 2;
  num min = 0;

  num maxX = 1;
  num minX = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Widget chart;
    final Widget row;
    if (stockTradingHistory != null) {
      row = BasicIndex(
          stockModel: widget.stockModel, history: stockTradingHistory!);
      chart = charts.TimeSeriesChart(
        [
          ...List<charts.Series<num, DateTime>>.generate(
              stockTradingHistory!.c.length,
              (index) => charts.Series<num, DateTime>(
                    id: 'chart1',
                    colorFn: (_, __) => charts.ColorUtil.fromDartColor(
                        widget.stockModel.stockData.color),
                    domainFn: (num indexBoard, int? index) {
                      if (index != null) {
                        if (timeSeries == TimeSeries.day) {
                          return stockTradingHistory!.time[index];
                        }
                        return stockTradingHistory!.time[index].beginningOfDay;
                      } else {
                        throw Exception("Chart index null");
                      }
                    },
                    measureFn: (num price, _) {
                      return price;
                    },
                    data: stockTradingHistory!.c,
                  )..setAttribute(
                      charts.measureAxisIdKey, "secondaryMeasureAxisId")),
          // if (listEvent.isNotEmpty)
          //   charts.Series<SecEvent, DateTime>(
          //     id: 'Annotation Series 2',
          //     colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          //     domainFn: (SecEvent event, _) => event.dateTime ?? DateTime.now(),
          //     domainLowerBoundFn: (SecEvent event, _) => event.dateTime,
          //     domainUpperBoundFn: (SecEvent event, _) => event.dateTime,
          //     // No measure values are needed for symbol annotations.
          //     measureFn: (_, __) => null,
          //     data: listEvent,
          //   )
          //     // Configure our custom symbol annotation renderer for this series.
          //     ..setAttribute(charts.rendererIdKey, 'customSymbolAnnotation')
          //     // Optional radius for the annotation shape. If not specified, this will
          //     // default to the same radius as the points.
          //     ..setAttribute(charts.boundsLineRadiusPxKey, 3.5),
        ],
        layoutConfig: charts.LayoutConfig(
            bottomMarginSpec: charts.MarginSpec.fromPercent(minPercent: 5),
            leftMarginSpec: charts.MarginSpec.defaultSpec,
            rightMarginSpec: charts.MarginSpec.defaultSpec,
            topMarginSpec: charts.MarginSpec.fromPercent(minPercent: 10)),
        defaultRenderer: charts.LineRendererConfig(
          smoothLine: true,
          includeArea: true,
        ),
        domainAxis: charts.DateTimeAxisSpec(
            tickFormatterSpec: charts.BasicDateTimeTickFormatterSpec((time) {
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
        primaryMeasureAxis: const charts.NumericAxisSpec(
          showAxisLine: false,
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            zeroBound: false,
            // desiredTickCount: 5,
            dataIsInWholeNumbers: false,
          ),
          // viewport: charts.NumericExtents(min.floor(), max.round()),
          renderSpec: charts.NoneRenderSpec(),
        ),
        secondaryMeasureAxis: axisSpec(),
        customSeriesRenderers: [
          charts.SymbolAnnotationRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customSymbolAnnotation')
        ],
        // Optionally pass in a [DateTimeFactory] used by the chart. The factory
        // should create the same type of [DateTime] as the data provided. If none
        // specified, the default creates local date time.
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        behaviors: [
          charts.LinePointHighlighter(
              symbolRenderer: CustomTooltipRenderer(_ToolTipMgr.instance,
                  size: MediaQuery.of(context).size,
                  fontSize: 10) // add this line in behaviours,

              ),
        ],
        selectionModels: [
          charts.SelectionModelConfig(
            updatedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection) {
                // for (var i = 0; i < model.selectedDatum.length; i++) {
                //   print(model.selectedDatum.elementAt(i).datum.toString());
                // }
                final List<String> datas = [];
                if (model.selectedDatum.length > 1) {
                  final SecEvent event = model.selectedDatum.first.datum;
                  datas.add(
                      "Ngày ${TimeUtilities.commonTimeFormat.format(event.dateTime!)}");
                  datas.add("Giá    ${model.selectedDatum.elementAt(1).datum}");
                  final String title;
                  print(event.title?.length);
                  if ((event.title?.length ?? 0) > 30) {
                    title = "${event.title?.substring(0, 30) ?? ""}...";
                  } else {
                    title = event.title ?? "";
                  }
                  datas.add(title);
                } else {
                  final index = model.selectedDatum.first.index ?? 0;
                  datas.add(
                      "Ngày ${TimeUtilities.commonTimeFormat.format(stockTradingHistory!.time.elementAt(index))}");
                  datas.add("Giá    ${model.selectedDatum.first.datum}");
                }
                // if (model.selectedDatum.first.datum is SecEvent) {
                //   print(model.selectedDatum.first.datum.dateTime.toString());
                // } else {
                //   print(stockTradingHistory!.time
                //       .elementAt(model.selectedDatum.first.index!)
                //       .toString());
                // }
                // logger.v(model.selectedDatum.first.datum);
                // logger.v(model.selectedDatum.first.series);
                // logger.v(model.selectedSeries);
                _ToolTipMgr.instance.setData(datas);
              } else {
                _ToolTipMgr.instance.setData([]);
              }
            },
          ),
        ],
      );
    } else {
      chart = const SizedBox(
        height: 20,
      );
      row = const SizedBox(
        height: 20,
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 200,
            child: chart,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List<Widget>.generate(
              TimeSeries.values.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      timeSeries = TimeSeries.values[index];
                    });
                    getStockTradingHistory();
                    getListEvent();
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: timeSeries == TimeSeries.values[index]
                              ? AppColors.primary_01
                              : AppColors.text_black),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        row,
      ],
    );
  }

  charts.NumericAxisSpec axisSpec() {
    return const charts.NumericAxisSpec(
      showAxisLine: true,
      tickProviderSpec: charts.BasicNumericTickProviderSpec(
        zeroBound: false,
        // desiredTickCount: 5,
        dataIsInWholeNumbers: false,
      ),
      // viewport: charts.NumericExtents(min.floor(), max.round()),
      renderSpec: charts.GridlineRendererSpec(
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
  bool get wantKeepAlive => true;
}

enum TimeSeries { day, week, month, month_3, month_6, year }

extension TimeSeriesExt on TimeSeries {
  String get title {
    switch (this) {
      case TimeSeries.day:
        return "D";
      case TimeSeries.week:
        return "W";
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

class _ToolTipMgr extends TooltipData {
  _ToolTipMgr._intern();

  static final _ToolTipMgr instance = _ToolTipMgr._intern();
}
