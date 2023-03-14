import 'dart:math';

import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:charts_flutter/flutter.dart' as charts;

//custom chart
import 'package:charts_flutter/src/text_element.dart' as chart_text;
import 'package:charts_flutter/src/text_style.dart' as chart_style;

class LiquidityChart extends StatefulWidget {
  final Future<LiquidityModel> liquidityModel;

  const LiquidityChart({super.key, required this.liquidityModel});

  @override
  State<LiquidityChart> createState() => _LiquidityChartState();
}

class _LiquidityChartState extends State<LiquidityChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Thanh khoản',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.light_bg,
                          borderRadius: BorderRadius.circular(8)),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Biểu đồ so sánh dòng tiền tại cùng thời điểm với phiên trước, trung bình 1 tuần. Dữ liệu ngày ${TimeUtilities.parseDateToString(DateTime.now())}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                    ),
                  ),
                ),
                child: SvgPicture.asset(
                  AppImages.infoCircle,
                ),
              )
            ],
          ),
        ),
        FutureBuilder<LiquidityModel>(
            future: widget.liquidityModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  child: Text(S.of(context).loading),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                final size = MediaQuery.of(context).size;
                var liquidityModel = snapshot.data!;
                return SizedBox(
                  height: 300,
                  child: charts.OrdinalComboChart(
                    [
                      charts.Series<num, String>(
                        id: 'Hiện tại',
                        colorFn: (_, __) =>
                            charts.ColorUtil.fromDartColor(AppColors.graph_2),
                        domainFn: (num val, index) =>
                            liquidityModel.time.elementAt(index ?? 0),
                        measureFn: (num val, _) => val,
                        data: liquidityModel.currVal,
                      ),
                      charts.Series<num, String>(
                        id: 'Phiên trước',
                        colorFn: (_, __) =>
                            charts.ColorUtil.fromDartColor(AppColors.graph_1),
                        domainFn: (num val, index) =>
                            liquidityModel.time.elementAt(index ?? 0),
                        measureFn: (num val, _) => val,
                        data: liquidityModel.prevVal,
                      )..setAttribute(charts.rendererIdKey, 'customLine'),
                      charts.Series<num, String>(
                        id: '1 tuần',
                        colorFn: (_, __) =>
                            charts.ColorUtil.fromDartColor(AppColors.graph_5),
                        domainFn: (num val, index) =>
                            liquidityModel.time.elementAt(index ?? 0),
                        measureFn: (num val, _) => val,
                        data: liquidityModel.week1Val,
                      )..setAttribute(charts.rendererIdKey, 'customLine'),
                      // charts.Series<num, String>(
                      //   id: '2 tuần',
                      //   colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.graph_4),
                      //   domainFn: (num val, index) => liquidityModel.time.elementAt(index ?? 0),
                      //   measureFn: (num val, _) => val,
                      //   data: liquidityModel.week2Val,
                      // )..setAttribute(charts.rendererIdKey, 'customLine'),
                      // charts.Series<num, String>(
                      //   id: '1 tháng',
                      //   colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.graph_3),
                      //   domainFn: (num val, index) => liquidityModel.time.elementAt(index ?? 0),
                      //   measureFn: (num val, _) => val,
                      //   data: liquidityModel.monthVal,
                      // )..setAttribute(charts.rendererIdKey, 'customLine'),
                    ],
                    animate: true,
                    defaultRenderer: charts.BarRendererConfig(
                      groupingType: charts.BarGroupingType.grouped,
                      // By default, bar renderer will draw rounded bars with a constant
                      // radius of 100.
                      // To not have any rounded corners, use [NoCornerStrategy]
                      // To change the radius of the bars, use [ConstCornerStrategy]
                      cornerStrategy: const charts.ConstCornerStrategy(2),
                    ),
                    customSeriesRenderers: [
                      charts.LineRendererConfig(customRendererId: 'customLine'),
                    ],
                    behaviors: [
                      charts.SeriesLegend(
                        // Positions for "start" and "end" will be left and right respectively
                        // for widgets with a build context that has directionality ltr.
                        // For rtl, "start" and "end" will be right and left respectively.
                        // Since this example has directionality of ltr, the legend is
                        // positioned on the right side of the chart.
                        position: charts.BehaviorPosition.bottom,
                        // For a legend that is positioned on the left or right of the chart,
                        // setting the justification for [endDrawArea] is aligned to the
                        // bottom of the chart draw area.
                        outsideJustification:
                            charts.OutsideJustification.middleDrawArea,
                        // By default, if the position of the chart is on the left or right of
                        // the chart, [horizontalFirst] is set to false. This means that the
                        // legend entries will grow as new rows first instead of a new column.
                        horizontalFirst: false,
                        // By setting this value to 2, the legend entries will grow up to two
                        // rows before adding a new column.
                        desiredMaxRows: 1,
                        // This defines the padding around each legend entry.
                        cellPadding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 10),
                        // Render the legend entry text with custom styles.
                        // entryTextStyle: const charts.TextStyleSpec(
                        //     color: charts.Color(r: 127, g: 63, b: 191),
                        //     fontFamily: 'Georgia',
                        //     fontSize: 11),
                      ),
                      charts.SelectNearest(
                          eventTrigger: charts.SelectionTrigger.tapAndDrag),
                      charts.LinePointHighlighter(
                          showHorizontalFollowLine:
                              charts.LinePointHighlighterFollowLineType.none,
                          showVerticalFollowLine: charts
                              .LinePointHighlighterFollowLineType.nearest),
                      charts.LinePointHighlighter(
                        symbolRenderer: _CustomTooltipRenderer(size: size),
                      ),
                    ],
                    selectionModels: [
                      charts.SelectionModelConfig(
                        updatedListener: (charts.SelectionModel model) {
                          if (model.hasDatumSelection) {
                            final selectedDatum = model.selectedDatum;
                            _TooltipData.setData(
                                liquidityModel.time
                                    .elementAt(selectedDatum.first.index ?? 0),
                                NumUtils.formatDouble(
                                    selectedDatum.first.datum),
                                NumUtils.formatDouble(
                                    selectedDatum.elementAt(1).datum),
                                NumUtils.formatDouble(
                                    selectedDatum.elementAt(2).datum));
                          }
                        },
                      ),
                    ],
                    // secondaryMeasureAxis: charts.NumericAxisSpec(
                    //     tickProviderSpec:
                    //         charts.BasicNumericTickProviderSpec(desiredTickCount: 10)),
                    domainAxis: const charts.OrdinalAxisSpec(
                      renderSpec: charts.SmallTickRendererSpec(
                        labelRotation: 45,
                      ),
                    ),

                    primaryMeasureAxis: const charts.NumericAxisSpec(
                      tickProviderSpec: charts.StaticNumericTickProviderSpec(
                        // Create the ticks to be used the domain axis.
                        <charts.TickSpec<num>>[
                          charts.TickSpec(-2, label: ''),
                          charts.TickSpec(-1, label: ''),
                          charts.TickSpec(0, label: ''),
                          charts.TickSpec(1, label: ''),
                          charts.TickSpec(2, label: ''),
                        ],
                      ),

                      // showAxisLine: false,
                    ),
                  ),
                );
              }
              return const SizedBox();
            }),
      ],
    );
  }
}

class _CustomTooltipRenderer extends charts.CircleSymbolRenderer {
  final Size size;

  _CustomTooltipRenderer({required this.size});

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

    final List<String> listElement = [
      'Hiện tại : ${_TooltipData.instance.currentLiquidity} tỷ VNĐ',
      'Phiên trước : ${_TooltipData.instance.lastdayLiquidity} tỷ VNĐ',
      'Tuần trước : ${_TooltipData.instance.lastweekLiquidity} tỷ VNĐ',
    ];

    int maxLenght = 0;
    for (String element in listElement) {
      if (element.length > maxLenght) {
        maxLenght = element.length;
      }
    }

    canvas.drawRect(
      Rectangle(bounds.left - bounds.width - 30, bounds.height - 10,
          bounds.width + (maxLenght * 4), bounds.height + (13 * 4)),
      fill: charts.Color.fromOther(
          color: const charts.Color(a: 100, b: 0, g: 0, r: 0).darker),
    );

    chart_style.TextStyle textStyle = chart_style.TextStyle();

    textStyle.color = charts.Color.white;
    textStyle.fontSize = 8;
    for (var i = 0; i < 3; i++) {
      canvas.drawText(
        chart_text.TextElement(listElement.elementAt(i), style: textStyle),
        (bounds.left - bounds.width - 25).round(),
        getHeight(i + 1).round(),
      );
    }

    canvas.drawText(
      chart_text.TextElement('${_TooltipData.instance.time}', style: textStyle),
      (bounds.left - bounds.width - 25).round(),
      getHeight(0).round(),
    );
  }

  int getHeight(int index) {
    return index * 8 + (index + 1) * 5;
  }
}

class _TooltipData {
  _TooltipData._internal();
  static final _TooltipData _instance = _TooltipData._internal();
  static _TooltipData get instance => _instance;
  String? time;
  String? currentLiquidity;
  String? lastdayLiquidity;
  String? lastweekLiquidity;
  factory _TooltipData({
    String? time,
    String? currentLiquidity,
    String? lastdayLiquidity,
    String? lastweekLiquidity,
  }) {
    setData(time, currentLiquidity, lastdayLiquidity, lastweekLiquidity);
    return _instance;
  }

  static void setData(
    String? time,
    String? currentLiquidity,
    String? lastdayLiquidity,
    String? lastweekLiquidity,
  ) {
    _instance.time = time;
    _instance.currentLiquidity = currentLiquidity;
    _instance.lastdayLiquidity = lastdayLiquidity;
    _instance.lastweekLiquidity = lastweekLiquidity;
  }
}
