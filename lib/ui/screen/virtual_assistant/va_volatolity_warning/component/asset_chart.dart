import 'dart:math';

import 'package:dtnd/=models=/response/account/asset_chart_element.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:charts_flutter/src/text_element.dart' as chartText;
import 'package:charts_flutter/src/text_style.dart' as chartStyle;
import 'package:intl/intl.dart';

var label, value, date;
final simpleCurrencyFormatter =
    charts.BasicNumericTickFormatterSpec.fromNumberFormat(
        NumberFormat.compact());
const percentageFormatter = PercentTickFormatterSpec();

class AssetChart extends StatefulWidget {
  const AssetChart(
      {super.key, this.lineColor = AppColors.semantic_01, this.datas});
  final Color lineColor;
  final List<AssetChartElementModel>? datas;
  @override
  State<AssetChart> createState() => _AssetChartState();
}

class _AssetChartState extends State<AssetChart> {
  final Random random = Random();

  late List<AssetChartElementModel> datas;
  late List<charts.Series<AssetChartElementModel, DateTime>> assetSeriesList;
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
        assetSeriesList = [
          charts.Series(
            id: "Tài sản",
            data: datas,
            domainFn: (data, _) => data.cTRADINGDATE,
            measureFn: (data, _) => data.cNETVALUE,
            seriesColor: charts.ColorUtil.fromDartColor(AppColors.semantic_01),
          ),
          charts.Series(
            id: "Tiền",
            data: datas,
            domainFn: (data, _) => data.cTRADINGDATE,
            measureFn: (data, _) => data.cCASHBALANCE,
            seriesColor: charts.ColorUtil.fromDartColor(AppColors.primary_01),
          ),
          charts.Series(
            id: "Nợ",
            data: datas,
            domainFn: (data, _) => data.cTRADINGDATE,
            measureFn: (data, _) => data.cLOANBALANCE,
            seriesColor: charts.ColorUtil.fromDartColor(AppColors.semantic_03),
          ),
          charts.Series(
            id: "Giá trị CK",
            data: datas,
            domainFn: (data, _) => data.cTRADINGDATE,
            measureFn: (data, _) => data.cSHARECLOSEVALUE,
            seriesColor: charts.ColorUtil.fromDartColor(AppColors.semantic_02),
          ),
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
            showMeasures: true,
            // Optionally provide a measure formatter to format the measure value.
            // If none is specified the value is formatted as a decimal.
            measureFormatter: (num? value) => "",
            defaultHiddenSeries: const ["Tiền", "Nợ", "Giá trị CK"],
          ),
          charts.LinePointHighlighter(
              symbolRenderer:
                  CustomCircleSymbolRenderer() // add this line in behaviours
              ),
        ],
        selectionModels: [
          charts.SelectionModelConfig(
            updatedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection) {
                label = model.selectedSeries.first.id;
                switch (label) {
                  case "Tiền":
                    value = NumUtils.formatDouble(
                        model.selectedDatum.first.datum.cCASHBALANCE);
                    break;
                  case "Nợ":
                    value = NumUtils.formatDouble(
                        model.selectedDatum.first.datum.cLOANBALANCE);
                    break;
                  case "Giá trị CK":
                    value = NumUtils.formatDouble(
                        model.selectedDatum.first.datum.cSHARECLOSEVALUE);
                    break;
                  default:
                    value = NumUtils.formatDouble(
                        model.selectedDatum.first.datum.cNETVALUE);
                }
                date = model.selectedDatum.first.datum.cTRADINGDATE;
                ToolTipMgr.setTitle(
                    {'title': '$label: $value', 'subTitle': '$date'});
              }
            },
          ),
        ],
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        domainAxis: const charts.DateTimeAxisSpec(
            tickProviderSpec: charts.DayTickProviderSpec(increments: [(22)])),
        primaryMeasureAxis: charts.NumericAxisSpec(
            tickProviderSpec:
                const charts.BasicNumericTickProviderSpec(zeroBound: false),
            tickFormatterSpec: simpleCurrencyFormatter),
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

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  static String? value;
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      charts.Color? fillColor,
      charts.FillPatternType? fillPattern,
      charts.Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
      Rectangle(bounds.left - bounds.width - 30, bounds.height - 10,
          bounds.width + 75, bounds.height + 20),
      fill: charts.Color.fromOther(
          color: const charts.Color(a: 100, b: 0, g: 0, r: 0).darker),
    );

    chartStyle.TextStyle textStyle = chartStyle.TextStyle();

    textStyle.color = charts.Color.white;
    textStyle.fontSize = 8;

    canvas.drawText(
      chartText.TextElement('Ngày: ${ToolTipMgr.subTitle}', style: textStyle),
      (bounds.left - bounds.width - 25).round(),
      (bounds.height + 7).round(),
    );
    canvas.drawText(
      chartText.TextElement(ToolTipMgr.title, style: textStyle),
      (bounds.left - bounds.width - 25).round(),
      (bounds.height - 5).round(),
    );
  }
}

String? _title;
String? _subTitle;

class ToolTipMgr {
  static String get title => _title ?? "";

  static String? get subTitle => _subTitle;

  static setTitle(Map<String, dynamic> data) {
    if (data['title'] != null) {
      _title = data['title'];
    }

    if (data['subTitle'] != null) {
      _subTitle = data['subTitle'];
    }
  }
}
