import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/top_signal_detail_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;

const List<String> _label = ["1M", "3M", "6M", "1Y"];

class SignalChart extends StatefulWidget {
  const SignalChart({super.key, required this.stockModel, required this.data});
  final StockModel? stockModel;
  final TopSignalDetailModel? data;
  @override
  State<SignalChart> createState() => _SignalChartState();
}

class _SignalChartState extends State<SignalChart> {
  final IDataCenterService dataCenterService = DataCenterService();
  String currentPeriod = _label[1];
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
    annotationX = widget.data?.cBUYPRICE ?? 0;
    annotationY = widget.data?.cBUYDATE ?? DateTime.now();
    super.initState();
    if (widget.data != null) {
      getDatas();
    }
  }

  @override
  void didUpdateWidget(SignalChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      annotationX = widget.data?.cBUYPRICE ?? 0;
      annotationY = widget.data?.cBUYDATE ?? DateTime.now();
      if (widget.data != null) {
        getDatas();
      }
    }
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
        widget.data!.cSHARECODE, "1D", from, now);
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
                  id: 'signal2Chart',
                  domainFn: (_, int? index) {
                    if (index != null) {
                      final DateTime date = datas!.time[index].beginningOfDay;
                      return date;
                    } else {
                      throw Exception("Chart index null");
                    }
                  },
                  measureFn: (num o, _) {
                    return o;
                  },
                  seriesColor: charts.ColorUtil.fromDartColor(
                      widget.stockModel?.stockData.color ??
                          AppColors.semantic_02),
                  data: datas!.o,
                )..setAttribute(charts.rendererIdKey, 'scatterChart'),
                charts.Series<num, DateTime>(
                  id: 'signal2Chart',
                  domainFn: (_, int? index) {
                    if (index != null) {
                      final DateTime date = datas!.time[index].beginningOfDay;
                      return date;
                    } else {
                      throw Exception("Chart index null");
                    }
                  },
                  measureFn: (num o, _) {
                    return o;
                  },
                  seriesColor: charts.ColorUtil.fromDartColor(
                      widget.stockModel?.stockData.color ??
                          AppColors.semantic_02),
                  data: datas!.o,
                )
                  ..setAttribute(charts.rendererIdKey, 'scatterChart')
                  ..setAttribute(
                      charts.measureAxisIdKey, "secondaryMeasureAxisId"),
                if (widget.data?.cBUYDATE != null)
                  charts.Series<TopSignalDetailModel, DateTime>(
                    id: 'Annotation Series 2',
                    colorFn: (_, __) =>
                        charts.MaterialPalette.green.shadeDefault,
                    domainFn: (TopSignalDetailModel event, _) =>
                        event.cBUYDATE!,
                    measureFn: (TopSignalDetailModel event, __) {
                      final int index = datas!.time.indexWhere((element) {
                        final int compare =
                            element.beginningOfDay.compareTo(event.cBUYDATE!);
                        switch (compare) {
                          case 0:
                            return true;
                          default:
                            return false;
                        }
                      });
                      return index > -1
                          ? datas!.o.elementAt(index)
                          : event.cBUYPRICE;
                    },
                    radiusPxFn: (_, __) => 5.0,
                    data: [widget.data!],
                  )
                    // Configure our custom symbol annotation renderer for this series.
                    // ..setAttribute(charts.rendererIdKey, 'scatterChart')
                    // Optional radius for the annotation shape. If not specified, this will
                    // default to the same radius as the points.
                    ..setAttribute(charts.boundsLineRadiusPxKey, 3.5),
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
                      charts.BasicDateTimeTickFormatterSpec.fromDateFormat(
                          TimeUtilities.dateMonthTimeFormat),
                  tickProviderSpec: const charts.AutoDateTimeTickProviderSpec(),
                  showAxisLine: true,
                  // viewport: charts.NumericExtents(minX, maxX),
                  renderSpec: const charts.GridlineRendererSpec(
                      axisLineStyle: charts.LineStyleSpec(
                          // dashPattern: [4],
                          // thickness: 0,
                          // color: charts.Color(r: 74, g: 85, b: 104),
                          ),
                      labelStyle: charts.TextStyleSpec(fontSize: 9),
                      lineStyle: charts.LineStyleSpec(dashPattern: [4]))),
              primaryMeasureAxis: const charts.NumericAxisSpec(
                showAxisLine: false,
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
                ),
                renderSpec: charts.NoneRenderSpec(),
              ),
              secondaryMeasureAxis: const charts.NumericAxisSpec(
                showAxisLine: true,
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
                ),
                renderSpec: charts.GridlineRendererSpec(
                  axisLineStyle: charts.LineStyleSpec(
                      // dashPattern: [4],
                      // thickness: 0,
                      // color: charts.Color(r: 74, g: 85, b: 104),
                      ),
                  labelStyle: charts.TextStyleSpec(fontSize: 9),
                  lineStyle: charts.LineStyleSpec(dashPattern: [4]),
                ),
              ),
              defaultRenderer: charts.PointRendererConfig(),
              customSeriesRenderers: [
                charts.LineRendererConfig(
                  smoothLine: true,
                  includeArea: true,
                  customRendererId: 'scatterChart',
                ),
                // charts.PointRendererConfig(
                //     customRendererId: 'scatterChart',
                //     layoutPaintOrder: charts.LayoutViewPaintOrder.point + 1),
              ],
              behaviors: [
                charts.LinePointHighlighter(
                    symbolRenderer: CustomTooltipRenderer(_ToolTipMgr.instance,
                        size: MediaQuery.of(context).size,
                        fontSize: 10) // add this line in behaviours,

                    ),
                // charts.RangeAnnotation<DateTime>(
                //   [
                //     charts.LineAnnotationSegment<num>(
                //       annotationX,
                //       charts.RangeAnnotationAxisType.measure,
                //       color: charts.ColorUtil.fromDartColor(
                //         AppColors.neutral_02,
                //       ),
                //       startLabel: annotationX.toString(),
                //       endLabel: "Giá mua",
                //       dashPattern: [5, 5],
                //       strokeWidthPx: 0.3,
                //     ),
                //     charts.LineAnnotationSegment<DateTime>(
                //       annotationY,
                //       charts.RangeAnnotationAxisType.domain,
                //       color: charts.ColorUtil.fromDartColor(
                //         AppColors.neutral_02,
                //       ),
                //       startLabel: "Ngày mua",
                //       endLabel:
                //           TimeUtilities.commonTimeFormat.format(annotationY),
                //       dashPattern: [5, 5],
                //       strokeWidthPx: 0.3,
                //     )
                //   ],
                // )
              ],
              selectionModels: [
                charts.SelectionModelConfig(
                  type: charts.SelectionModelType.info,
                  changedListener: (charts.SelectionModel model) {
                    if (model.hasDatumSelection) {
                      // logger.v(model.selectedDatum.first.datum);
                      // logger.v(model.selectedDatum.first.series);
                      // logger.v(model.selectedSeries);
                      // for (var i = 0; i < model.selectedDatum.length; i++) {
                      //   print(model.selectedDatum.elementAt(i).index);
                      // }

                      // logger.v(model.selectedDatum.first.datum);
                      // logger.v(model.selectedDatum.first.series);
                      // logger.v(model.selectedSeries);
                      final List<String> data = [];
                      if (model.selectedDatum.length > 1) {
                        late TopSignalDetailModel topSignalStockModel;
                        late num price;
                        for (var element in model.selectedDatum) {
                          if (element.datum is TopSignalDetailModel) {
                            topSignalStockModel = element.datum;
                          } else if (element.datum is num) {
                            price = element.datum;
                          }
                        }
                        data.add(
                            "Ngày ${TimeUtilities.commonTimeFormat.format(topSignalStockModel.cBUYDATE!)}");
                        data.add("Giá mua ${topSignalStockModel.cBUYPRICE}");
                        data.add("Giá $price");
                      } else {
                        final index = model.selectedDatum.first.index ?? 0;
                        data.add(
                            "Ngày ${TimeUtilities.commonTimeFormat.format(datas!.time.elementAt(index))}");
                        data.add("Giá ${model.selectedDatum.first.datum}");
                      }
                      _ToolTipMgr.instance.setData(data);
                    } else {
                      _ToolTipMgr.instance.setData([]);
                    }
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ToolTipMgr extends TooltipData {
  _ToolTipMgr._intern();

  static final _ToolTipMgr instance = _ToolTipMgr._intern();
}
