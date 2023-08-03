import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/top_signal_detail_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/charts/chart_data_mixin.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/service/app_services.dart';

const List<String> _label = ["1M", "3M", "6M", "1Y"];

class SignalChart extends StatefulWidget {
  const SignalChart({super.key, required this.stockModel, required this.data});

  final StockModel? stockModel;
  final TopSignalDetailModel? data;

  @override
  State<SignalChart> createState() => _SignalChartState();
}

class _SignalChartState extends State<SignalChart> with ChartDatasMixin {
  final IDataCenterService dataCenterService = DataCenterService();
  final ThemeMode themeMode = AppService.instance.themeMode.value;

  String currentPeriod = _label[1];
  List<OhlcHistoryItem> datas = [];
  late num annotationX;
  late DateTime annotationY;
  charts.RangeAnnotation? rangeAnnotation;
  num max = 2;
  num min = 0;
  num length = 2;

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
      if (mounted) {
        setState(() {
          datas = historyToChartItem(history);
          // datas!.c.clear();
          // for (var i = 0; i < datas!.t.length; i += 3) {
          //   if ((datas!.t.length - datas!.c.length) < 3) {
          //     datas!.c.addAll(List.filled(datas!.t.length - datas!.c.length,
          //         math.Random().nextDouble()));
          //   } else {
          //     datas!.c.addAll(List.filled(3, math.Random().nextDouble()));
          //   }
          // }
          length = datas.length;
        });
      }

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;

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
                            : themeMode.isLight
                                ? AppColors.neutral_06
                                : AppColors.bg_share_inside_nav,
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
        if (datas.isEmpty)
          const SizedBox(height: 20)
        else
          SizedBox(
            height: 240,
            child: charts.TimeSeriesChart(
              [
                charts.Series<OhlcHistoryItem, DateTime>(
                  id: 'signal2Chart',
                  domainFn: (OhlcHistoryItem data, int? index) =>
                      data.time.beginningOfDay,
                  measureFn: (OhlcHistoryItem data, _) => data.close,
                  seriesColor: charts.ColorUtil.fromDartColor(
                      widget.stockModel?.stockData.color ??
                          AppColors.semantic_02),
                  data: datas,
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
                    measureFn: (TopSignalDetailModel event, __) =>
                        event.cBUYPRICE,
                    radiusPxFn: (_, __) => 5.0,
                    data: [widget.data!],
                  )
                    ..setAttribute(charts.boundsLineRadiusPxKey, 3.5)
                    ..setAttribute(
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
                    charts.BasicDateTimeTickFormatterSpec.fromDateFormat(
                        TimeUtilities.dateMonthTimeFormat),
                tickProviderSpec: const charts.AutoDateTimeTickProviderSpec(),
                showAxisLine: true,
                // viewport: charts.NumericExtents(minX, maxX),
                renderSpec: charts.GridlineRendererSpec(
                  axisLineStyle: const charts.LineStyleSpec(
                    dashPattern: [4],
                    thickness: 0,
                    color: charts.Color(r: 74, g: 85, b: 104),
                  ),
                  labelStyle: charts.TextStyleSpec(
                      fontSize: 9,
                      color: themeMode.isLight
                          ? null
                          : charts.ColorUtil.fromDartColor(
                              AppColors.neutral_07)),
                  lineStyle: charts.LineStyleSpec(
                    dashPattern: [4],
                    color: themeMode.isLight
                        ? null
                        : charts.ColorUtil.fromDartColor(AppColors.neutral_02),
                  ),
                ),
              ),
              primaryMeasureAxis: const charts.NumericAxisSpec(
                showAxisLine: false,
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
                ),
                renderSpec: charts.NoneRenderSpec(),
              ),
              secondaryMeasureAxis: charts.NumericAxisSpec(
                showAxisLine: true,
                tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
                ),
                renderSpec: charts.GridlineRendererSpec(
                  axisLineStyle: const charts.LineStyleSpec(
                    dashPattern: [4],
                    thickness: 0,
                    color: charts.Color(r: 74, g: 85, b: 104),
                  ),
                  labelStyle: charts.TextStyleSpec(
                      fontSize: 9,
                      color: themeMode.isLight
                          ? null
                          : charts.ColorUtil.fromDartColor(
                              AppColors.neutral_07)),
                  lineStyle: charts.LineStyleSpec(
                    dashPattern: [4],
                    color: themeMode.isLight
                        ? null
                        : charts.ColorUtil.fromDartColor(AppColors.neutral_02),
                  ),
                ),
              ),
              defaultRenderer: charts.PointRendererConfig(),
              customSeriesRenderers: [
                charts.LineRendererConfig(
                  smoothLine: true,
                  includeArea: true,
                  // includePoints: true,
                  customRendererId: 'scatterChart',
                ),
              ],
              behaviors: [
                charts.LinePointHighlighter(
                    symbolRenderer: CustomTooltipRenderer(_ToolTipMgr.instance,
                        size: MediaQuery.of(context).size,
                        fontSize: 10) // add this line in behaviours,
                    ),
              ],
              selectionModels: [
                charts.SelectionModelConfig(
                  type: charts.SelectionModelType.info,
                  changedListener: (charts.SelectionModel model) {
                    if (model.hasDatumSelection) {
                      final List<String> data = [];
                      if (model.selectedDatum.length > 1) {
                        late TopSignalDetailModel topSignalStockModel;
                        late OhlcHistoryItem item;
                        for (var element in model.selectedDatum) {
                          if (element.datum is TopSignalDetailModel) {
                            topSignalStockModel = element.datum;
                          } else if (element.datum is OhlcHistoryItem) {
                            item = element.datum as OhlcHistoryItem;
                          }
                        }
                        data.add(
                            "Ngày ${TimeUtilities.commonTimeFormat.format(topSignalStockModel.cBUYDATE!)}");
                        data.add("Giá mua ${topSignalStockModel.cBUYPRICE}");
                        data.add("Giá ${item.close}");
                      } else {
                        dynamic item = model.selectedDatum.first.datum;
                        if (item is OhlcHistoryItem) {
                          data.add(
                              "Ngày ${TimeUtilities.commonTimeFormat.format(item.time)}");
                          data.add("Giá ${item.close}");
                        } else {
                          logger.v(item.cBUYDATE.toString());
                          data.add(
                              "Ngày ${TimeUtilities.commonTimeFormat.format(item.cBUYDATE)}");
                          data.add("Giá mua ${item.cBUYPRICE}");
                        }
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
