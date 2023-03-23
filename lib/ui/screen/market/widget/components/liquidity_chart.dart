import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

//custom chart

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
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Row(
        //     children: [
        //       Text(
        //         'Thanh khoản',
        //         style: Theme.of(context)
        //             .textTheme
        //             .labelMedium
        //             ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
        //       ),
        //       const SizedBox(
        //         width: 4,
        //       ),
        //       GestureDetector(
        //         onTap: () => showDialog<String>(
        //           context: context,
        //           builder: (BuildContext context) => Dialog(
        //             child: Container(
        //               padding: const EdgeInsets.all(16),
        //               decoration: BoxDecoration(
        //                   color: AppColors.light_bg,
        //                   borderRadius: BorderRadius.circular(8)),
        //               width: MediaQuery.of(context).size.width,
        //               child: Text(
        //                   'Biểu đồ so sánh dòng tiền tại cùng thời điểm với phiên trước, trung bình 1 tuần. Dữ liệu ngày ${TimeUtilities.parseDateToString(DateTime.now())}',
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .labelMedium
        //                       ?.copyWith(
        //                           fontWeight: FontWeight.w400, fontSize: 14)),
        //             ),
        //           ),
        //         ),
        //         child: SvgPicture.asset(
        //           AppImages.infoCircle,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
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
                        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
                            AppColors.semantic_01),
                        domainFn: (num val, index) =>
                            liquidityModel.time.elementAt(index ?? 0),
                        measureFn: (num val, index) {
                          // print(liquidityModel.time.elementAt(index ?? 0));
                          // print(val);
                          return val;
                        },
                        data: liquidityModel.currVal,
                      )..setAttribute(
                          charts.measureAxisIdKey, "secondaryMeasureAxisId"),

                      charts.Series<num, String>(
                        id: 'Phiên trước',
                        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
                            AppColors.semantic_04),
                        domainFn: (num val, index) =>
                            liquidityModel.time.elementAt(index ?? 0),
                        measureFn: (num val, _) => val,
                        data: liquidityModel.prevVal,
                      )..setAttribute(charts.rendererIdKey, 'customLine'),

                      charts.Series<num, String>(
                        id: '1 tuần',
                        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
                            AppColors.semantic_05),
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
                      // groupingType: charts.BarGroupingType.grouped,

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
                            final selectedDatum = model.selectedDatum;
                            // if (liquidityModel.time.elementAt(
                            //         selectedDatum.elementAt(1).index ?? 0) !=
                            //     liquidityModel.time.elementAt(
                            //         selectedDatum.first.index ?? 0)) {}
                            // print(selectedDatum.first.index);
                            // print(selectedDatum.elementAt(1).index);
                            final datas = [
                              liquidityModel.time.elementAt(
                                  selectedDatum.elementAt(1).index ?? 0),
                              if (selectedDatum.first.datum != 0)
                                "Hiện tại : ${NumUtils.formatDouble(selectedDatum.first.datum)} tỷ",
                              "Phiên trước : ${NumUtils.formatDouble(selectedDatum.elementAt(1).datum)} tỷ",
                              "Tuần trước : ${NumUtils.formatDouble(selectedDatum.elementAt(2).datum)} tỷ",
                            ];
                            _TooltipData.instance.setData(datas);
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
                    secondaryMeasureAxis: const charts.NumericAxisSpec(
                      renderSpec: charts.NoneRenderSpec(),
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(
                          // zeroBound: true,
                          ),
                      showAxisLine: false,
                      // showAxisLine: false,
                    ),
                    primaryMeasureAxis: const charts.NumericAxisSpec(
                      renderSpec: charts.NoneRenderSpec(),
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(
                          // zeroBound: true,
                          ),
                      showAxisLine: false,
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

  // final axis = charts.NumericAxisSpec(
  //   tickProviderSpec:
  //       const charts.BasicNumericTickProviderSpec(dataIsInWholeNumbers: false),
  //   showAxisLine: false,
  //   renderSpec: charts.GridlineRendererSpec(
  //       labelStyle: const charts.TextStyleSpec(
  //           color: charts.MaterialPalette.white, fontSize: 12),
  //       lineStyle: charts.LineStyleSpec(
  //         color: charts.ColorUtil.fromDartColor(AppColors.primary_01),
  //         thickness: 0,
  //       )),
  // );
}

class _TooltipData extends TooltipData {
  _TooltipData._internal();
  static final _TooltipData instance = _TooltipData._internal();
}
