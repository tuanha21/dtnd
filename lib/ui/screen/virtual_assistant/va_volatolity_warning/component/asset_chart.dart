import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/account/asset_chart_element.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../config/service/app_services.dart';

final simpleCurrencyFormatter =
    charts.BasicNumericTickFormatterSpec.fromNumberFormat(
        NumberFormat.compact());
const percentageFormatter = PercentTickFormatterSpec();

class AssetChart extends StatefulWidget {
  const AssetChart({super.key, this.datas});

  final List<AssetChartElementModel>? datas;

  @override
  State<AssetChart> createState() => _AssetChartState();
}

class _AssetChartState extends State<AssetChart> {
  final Random random = Random();
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  late List<AssetChartElementModel> datas;
  late List<charts.Series<AssetChartElementModel, DateTime>> assetSeriesList;
  DateTime start = DateTime.now().subtract(const Duration(days: 1));
  DateTime end = DateTime.now();

  @override
  void initState() {
    super.initState();
    datas = widget.datas ?? [];
    _generateChartData();
  }

  @override
  void didUpdateWidget(covariant AssetChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _generateChartData();
  }

  void _generateChartData() {
    if (mounted) {
      setState(() {
        datas = widget.datas ?? [];
        if (datas.isNotEmpty) {
          start = datas.first.cTRADINGDATE;
          end = datas.last.cTRADINGDATE;
        }
        assetSeriesList = [
          charts.Series(
            id: "Tài sản",
            data: datas,
            domainFn: (data, _) => data.cTRADINGDATE,
            measureFn: (data, _) => data.cNETVALUE,
            seriesColor: charts.ColorUtil.fromDartColor(AppColors.semantic_03),
          )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
          charts.Series(
            id: "Tiền",
            data: datas,
            domainFn: (data, _) => data.cTRADINGDATE,
            measureFn: (data, _) => data.cCASHBALANCE,
            seriesColor: charts.ColorUtil.fromDartColor(AppColors.primary_01),
          )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
          // charts.Series(
          //   id: "Nợ",
          //   data: datas,
          //   domainFn: (data, _) => data.cTRADINGDATE,
          //   measureFn: (data, _) => data.cLOANBALANCE,
          //   seriesColor: charts.ColorUtil.fromDartColor(AppColors.semantic_03),
          // )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
          charts.Series(
            id: "Giá trị CK",
            data: datas,
            domainFn: (data, _) => data.cTRADINGDATE,
            measureFn: (data, _) => data.cSHARECLOSEVALUE,
            seriesColor: charts.ColorUtil.fromDartColor(AppColors.semantic_01),
          )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
        ];
      });
    }
    // final List<charts.Series<AssetChartElementModel, DateTime>>
    //     profitSeriesList = [
    //   charts.Series(
    //     id: "Lãi lỗ",
    //     data: datas,
    //     colorFn: (data, _) {
    //       if ((data.cDAYPROFITVALUE) >= 0) {
    //         return charts.ColorUtil.fromDartColor(AppColors.semantic_01);
    //       }
    //       return charts.ColorUtil.fromDartColor(AppColors.semantic_03);
    //     },
    //     domainFn: (data, _) => data.cTRADINGDATE,
    //     measureFn: (data, _) => data.cDAYPROFITVALUE,
    //   ),
    // ];

    // final List<charts.Series<AssetChartElementModel, DateTime>>
    //     effectSeriesList = [
    //   charts.Series(
    //     id: "Hiệu quả",
    //     data: datas,
    //     colorFn: (data, _) {
    //       if ((data.cDAYPROFITRATE ?? 0) >= 0) {
    //         return charts.ColorUtil.fromDartColor(AppColors.semantic_01);
    //       }
    //       return charts.ColorUtil.fromDartColor(AppColors.semantic_03);
    //     },
    //     domainFn: (data, _) => data.cTRADINGDATE,
    //     measureFn: (data, _) => data.cDAYPROFITRATE,
    //   ),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Container(
      height: 260,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomCenter,
      child: charts.TimeSeriesChart(
        assetSeriesList,
        animate: false,

        // Configure a stroke width to enable borders on the bars.
        // defaultRenderer: new charts.LineRendererConfig(
        //   // groupingType: charts.BarGroupingType.stacked,
        //   strokeWidthPx: 2.0,
        // ),
        // layoutConfig: charts.LayoutConfig(
        //   leftMarginSpec: charts.MarginSpec.fixedPixel(10),
        //   topMarginSpec: charts.MarginSpec.fixedPixel(0),
        //   rightMarginSpec: charts.MarginSpec.fixedPixel(10),
        //   bottomMarginSpec: charts.MarginSpec.fixedPixel(20),
        // ),
        defaultRenderer:
            charts.LineRendererConfig(includeArea: true, smoothLine: true),
        behaviors: [
          charts.SeriesLegend(
            // Positions for "start" and "end" will be left and right respectively
            // for widgets with a build context that has directionality ltr.
            // For rtl, "start" and "end" will be right and left respectively.
            // Since this example has directionality of ltr, the legend is
            // positioned on the right side of the chart.
            position: charts.BehaviorPosition.bottom,
            // By default, if the position of the chart is on the left or right of
            // the chart, [horizontalFirst] is set to false. This means that the
            // legend entries will grow as new rows first instead of a new column.
            horizontalFirst: true,
            // This defines the padding around each legend entry.
            cellPadding: const EdgeInsets.only(right: 4.0),
            // Set show measures to true to display measures in series legend,
            // when the datum is selected.
            // showMeasures: true,
            // Optionally provide a measure formatter to format the measure value.
            // If none is specified the value is formatted as a decimal.
            measureFormatter: (num? value) => "",
            // defaultHiddenSeries: const ["Nợ", "Tài sản"],
          ),
          charts.LinePointHighlighter(
              symbolRenderer: CustomTooltipRenderer(_ToolTipMgr.instance,
                  size: MediaQuery.of(context).size,
                  fontSize: 10) // add this line in behaviours
              ),
        ],
        selectionModels: [
          charts.SelectionModelConfig(
            updatedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection) {
                final String time =
                    "Ngày : ${TimeUtilities.commonTimeFormat.format(model.selectedDatum.first.datum.cTRADINGDATE)}";
                final List<String> datas = [
                  time,
                ];
                for (var element in model.selectedDatum) {
                  final String label = element.series.id;
                  final String value;
                  switch (label) {
                    case "Tiền":
                      value = NumUtils.formatDouble(element.datum.cCASHBALANCE);
                      break;
                    case "Nợ":
                      value = NumUtils.formatDouble(element.datum.cLOANBALANCE);
                      break;
                    case "Giá trị CK":
                      value =
                          NumUtils.formatDouble(element.datum.cSHARECLOSEVALUE);
                      break;
                    default:
                      value = NumUtils.formatDouble(element.datum.cNETVALUE);
                  }
                  final String data = "$label : $value";
                  datas.add(data);
                }

                _ToolTipMgr.instance.setData(datas);
              }
            },
          ),
        ],
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        domainAxis: charts.DateTimeAxisSpec(
          viewport: charts.DateTimeExtents(start: start, end: end),
          // tickProviderSpec:
          //     charts.DayTickProviderSpec(increments: [datas.length ~/ 3]),
          tickFormatterSpec:
              charts.BasicDateTimeTickFormatterSpec.fromDateFormat(
            DateFormat("dd-MM-yyyy"),
          ),
          renderSpec: charts.GridlineRendererSpec(
            labelOffsetFromAxisPx: 6,
            axisLineStyle: charts.LineStyleSpec(
              dashPattern: const [4],
              thickness: 1,
              color: charts.ColorUtil.fromDartColor(AppColors.neutral_03),
            ),
            labelStyle: charts.TextStyleSpec(
                fontSize: 8,
                color: themeMode.isLight
                    ? null
                    : charts.ColorUtil.fromDartColor(AppColors.neutral_07)),
            lineStyle: charts.LineStyleSpec(
                dashPattern: [4],
                color: themeMode.isLight
                    ? null
                    : charts.ColorUtil.fromDartColor(AppColors.neutral_02)),
          ),
        ),
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec:
              const charts.BasicNumericTickProviderSpec(zeroBound: false),
          tickFormatterSpec: simpleCurrencyFormatter,
        ),
        secondaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec:
              const charts.BasicNumericTickProviderSpec(zeroBound: false),
          tickFormatterSpec: simpleCurrencyFormatter,
          renderSpec: charts.GridlineRendererSpec(
              axisLineStyle: charts.LineStyleSpec(
                dashPattern: const [4],
                thickness: 1,
                color: charts.ColorUtil.fromDartColor(AppColors.neutral_03),
              ),
              labelStyle: charts.TextStyleSpec(
                  fontSize: 8,
                  color: themeMode.isLight
                      ? null
                      : charts.ColorUtil.fromDartColor(AppColors.neutral_07)),
              lineStyle: charts.LineStyleSpec(
                dashPattern: [4],
                color: themeMode.isLight
                    ? null
                    : charts.ColorUtil.fromDartColor(AppColors.neutral_02),
              )),
        ),
      ),
    );
  }
}

class PercentTickFormatterSpec implements charts.NumericTickFormatterSpec {
  const PercentTickFormatterSpec();

  @override
  PercentageTickFormatter createTickFormatter(charts.ChartContext context) {
    return const PercentageTickFormatter();
  }
}

class PercentageTickFormatter extends charts.SimpleTickFormatterBase<num> {
  const PercentageTickFormatter();

  @override
  String formatValue(num value) {
    if ((value % 1.0) != 0) {
      return "$value%";
    } else {
      return "${value.toInt()}%";
    }
  }

  @override
  bool operator ==(Object other) => other is PercentageTickFormatter;

  @override
  int get hashCode => 31;
}

class _ToolTipMgr extends TooltipData {
  _ToolTipMgr._intern();

  static final _ToolTipMgr instance = _ToolTipMgr._intern();
}
