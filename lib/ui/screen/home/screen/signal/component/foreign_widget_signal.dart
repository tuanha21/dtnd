import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../=models=/response/market/signal_month_model.dart';

class ForeignWidgetSignal extends StatefulWidget {
  const ForeignWidgetSignal({Key? key, required this.code, required this.type})
      : super(key: key);

  final String code;
  final String type;

  @override
  State<ForeignWidgetSignal> createState() => _ForeignWidgetState();
}

class _ForeignWidgetState extends State<ForeignWidgetSignal> {
  final IDataCenterService dataCenterService = DataCenterService();

  List<SignalMonthModel>? listMonth;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    listMonth =
        await dataCenterService.getSignalMonth(widget.code, widget.type);
    if (mounted) setState(() {});
  }

  // @override
  // void didUpdateWidget(covariant ForeignWidgetSignal oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.code != widget.code || oldWidget.type != widget.type) {
  //     getData();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    listMonth?.sort((a, b) => a.cMONTH.compareTo(b.cMONTH));
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return listMonth?.isNotEmpty == true
        ? Column(
            children: [
              SizedBox(
                height: 200,
                child: charts.BarChart(
                  [
                    charts.Series<SignalMonthModel, String>(
                      id: 'Sales',
                      colorFn: (_, __) =>
                          charts.MaterialPalette.blue.shadeDefault,
                      domainFn: (SignalMonthModel model, _) =>
                          DateFormat('MM/yyyy').format(model.cMONTH),
                      measureFn: (SignalMonthModel model, _) => model.cPC,
                      fillColorFn: (SignalMonthModel model, _) =>
                          charts.ColorUtil.fromDartColor((model.cPC ?? 0) > 0
                              ? AppColors.semantic_01
                              : AppColors.semantic_03),
                      data: listMonth!,
                    )..setAttribute(
                        charts.measureAxisIdKey, "secondaryMeasureAxisId")
                  ],
                  animate: true,
                  defaultRenderer: charts.BarRendererConfig(
                    cornerStrategy: const charts.ConstCornerStrategy(2),
                  ),
                  domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelOffsetFromAxisPx: 5,
                      lineStyle: charts.LineStyleSpec(
                        color: themeMode.isLight
                            ? null
                            : charts.ColorUtil.fromDartColor(
                                AppColors.neutral_02),
                      ),
                      labelStyle: charts.TextStyleSpec(
                          fontSize: 9,
                          color: themeMode.isLight
                              ? null
                              : charts.ColorUtil.fromDartColor(
                                  AppColors.neutral_07)),
                    ),
                  ),
                  secondaryMeasureAxis: charts.NumericAxisSpec(
                    showAxisLine: true,
                    tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                        (value) => '${NumUtils.formatInteger((value ?? 0))}%'),
                    tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                        dataIsInWholeNumbers: false,
                        desiredTickCount: 4,
                        zeroBound: true),
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
                                : charts.ColorUtil.fromDartColor(
                                    AppColors.neutral_02))),
                  ),
                  behaviors: [
                    charts.SelectNearest(
                      eventTrigger: charts.SelectionTrigger.tapAndDrag,
                      // selectionMode:
                      //     charts.SelectionMode.selectOverlapping,
                    ),
                    charts.LinePointHighlighter(
                      // drawFollowLinesAcrossChart: false,
                      showHorizontalFollowLine:
                          charts.LinePointHighlighterFollowLineType.none,
                      showVerticalFollowLine:
                          charts.LinePointHighlighterFollowLineType.all,
                    ),
                    charts.LinePointHighlighter(
                      symbolRenderer: CustomTooltipRenderer(
                          _TooltipData.instance,
                          size: size),
                    ),
                  ],
                  selectionModels: [
                    charts.SelectionModelConfig(
                      type: charts.SelectionModelType.info,
                      updatedListener: (charts.SelectionModel model) {
                        if (model.hasDatumSelection) {
                          final selectedDatum = model.selectedDatum.first.datum;
                          final datas = <String>[
                            "${S.of(context).effective} : ${selectedDatum.cPC}%"
                          ];
                          _TooltipData.instance.setData(datas);
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          )
        : const SizedBox();
  }

  String parseEmpty(num? value) {
    if (value == null || value == 0) {
      return "-";
    } else {
      return NumUtils.formatDouble(value);
    }
  }
}

class _TooltipData extends TooltipData {
  _TooltipData._internal();

  static final _TooltipData instance = _TooltipData._internal();
}
