import 'package:dtnd/=models=/response/index_board.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_color.dart';

class MoneyChart extends StatefulWidget {
  final double height;
  final Future<List<IndexBoard>> indexBoard;

  const MoneyChart({super.key, this.height = 150, required this.indexBoard});

  @override
  State<MoneyChart> createState() => _MoneyChartState();
}

class _MoneyChartState extends State<MoneyChart> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Dòng tiền',
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
                          'Biểu đồ thể hiện giá trị giao dịch mua chủ động ròng trong phiên.',
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
        SizedBox(
          height: widget.height * 1.5,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<IndexBoard>>(
              future: widget.indexBoard,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    child: Text(S.of(context).loading),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var list = snapshot.data;
                  if (list == null) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: charts.NumericComboChart(
                      [
                        charts.Series<IndexBoard, num>(
                          id: 'chart1',
                          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
                              AppColors.semantic_01),
                          domainFn: (IndexBoard indexBoard, int? index) =>
                              index!,
                          measureFn: (IndexBoard sales, _) {
                            return sales.totalBuyActivelyValues;
                          },
                          data: list,
                        )..setAttribute(
                            charts.measureAxisIdKey, "secondaryMeasureAxisId")
                      ],
                      behaviors: [
                        charts.SelectNearest(
                            eventTrigger: charts.SelectionTrigger.tapAndDrag),
                        charts.LinePointHighlighter(
                            showHorizontalFollowLine:
                                charts.LinePointHighlighterFollowLineType.none,
                            showVerticalFollowLine: charts
                                .LinePointHighlighterFollowLineType.nearest),
                        charts.LinePointHighlighter(
                          symbolRenderer: CustomTooltipRenderer(
                              _MoneyFlowTooltipData.instance,
                              size: size),
                        ),
                      ],
                      selectionModels: [
                        charts.SelectionModelConfig(
                          updatedListener: (charts.SelectionModel model) {
                            if (model.hasDatumSelection) {
                              final selectedDatum = model.selectedDatum;
                              final List<String> listData = [
                                "${selectedDatum.first.datum.time} : ${NumUtils.formatDouble(selectedDatum.first.datum.totalBuyActivelyValues)}"
                              ];
                              _MoneyFlowTooltipData.instance.setData(listData);
                            }
                          },
                        ),
                      ],
                      defaultRenderer: charts.LineRendererConfig(
                          includeArea: true, stacked: true),
                      domainAxis: domainSpec(list),
                      secondaryMeasureAxis: axisSpec(),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Độ rộng thị trường',
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
                          'Biểu đồ thể hiện tỷ trọng các mã tăng giá, giảm giá và không đổi theo thời gian trong phiên.',
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
        const SizedBox(height: 20),
        SizedBox(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<IndexBoard>>(
              future: widget.indexBoard,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    child: Text(S.of(context).loading),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var list = snapshot.data;
                  if (list == null) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 40),
                    child: charts.NumericComboChart(
                      _createSampleData(list),
                      defaultRenderer: charts.LineRendererConfig(
                          includeArea: true, stacked: true),
                      animate: true,
                      layoutConfig: charts.LayoutConfig(
                        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                        topMarginSpec: charts.MarginSpec.fixedPixel(0),
                        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
                      ),
                      secondaryMeasureAxis: const charts.NumericAxisSpec(
                        viewport: charts.NumericExtents(0, 100),
                        tickProviderSpec: charts.BasicNumericTickProviderSpec(
                            desiredTickCount: 5),
                      ),
                      domainAxis: domainSpec(list),
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
                              final selectedDatum = model.selectedDatum;
                              // if (liquidityModel.time.elementAt(
                              //         selectedDatum.elementAt(1).index ?? 0) !=
                              //     liquidityModel.time.elementAt(
                              //         selectedDatum.first.index ?? 0)) {}
                              // print(selectedDatum.first.index);
                              // print(selectedDatum.elementAt(1).index);
                              final List<String> datas = [
                                selectedDatum.first.datum.time,
                                "Tăng : ${NumUtils.formatDouble(selectedDatum.first.datum.advancesPer)} %",
                                "Không thay đổi : ${NumUtils.formatDouble(selectedDatum.first.datum.noChangesPer)} %",
                                "Giảm : ${NumUtils.formatDouble(selectedDatum.first.datum.declinesPer)} %",
                              ];
                              _TooltipData.instance.setData(datas);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              }),
        ),
      ],
    );
  }

  List<charts.Series<IndexBoard, num>> _createSampleData(
      List<IndexBoard> list) {
    return [
      charts.Series<IndexBoard, num>(
          id: 'Declines',
          // colorFn specifies that the line will be red.
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(AppColors.semantic_03),
          // areaColorFn specifies that the area skirt will be light red.
          areaColorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(AppColors.semantic_03),
          domainFn: (IndexBoard sales, index) => index!,
          measureFn: (IndexBoard sales, _) {
            return sales.declinesPer;
          },
          data: list)
        ..setAttribute(charts.measureAxisIdKey, "secondaryMeasureAxisId"),
      charts.Series<IndexBoard, num>(
        id: 'NoChanges',
        // colorFn specifies that the line will be green.
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.semantic_02),
        // areaColorFn specifies that the area skirt will be light green.
        areaColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.semantic_02),
        domainFn: (IndexBoard sales, index) => index!,
        measureFn: (IndexBoard sales, _) => sales.noChangesPer,
        data: list,
      )..setAttribute(charts.measureAxisIdKey, "secondaryMeasureAxisId"),
      charts.Series<IndexBoard, num>(
        id: 'Advances',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.semantic_01),

        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.semantic_01),
        domainFn: (IndexBoard sales, index) => index!,
        measureFn: (IndexBoard sales, _) => sales.advancesPer,
        data: list,
      )..setAttribute(charts.measureAxisIdKey, "secondaryMeasureAxisId"),
    ];
  }

  charts.NumericAxisSpec domainSpec(List<IndexBoard> list) {
    return charts.NumericAxisSpec(
        tickFormatterSpec: charts.BasicNumericTickFormatterSpec((index) {
          if (index! < list.length) {
            String formattedDate =
                DateFormat('HH:mm').format(list[index.toInt()].dateTime!);
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
      tickFormatterSpec: charts.BasicNumericTickFormatterSpec((measure) {
        if (measure! > 10000000 || measure < -10000000) {
          return "${NumUtils.formatInteger((measure / 1000000))}M";
        }
        if (measure > 10000 || measure < -10000) {
          return "${NumUtils.formatInteger((measure / 1000))}K";
        }
        return NumUtils.formatInteger(measure);
      }),
      tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          dataIsInWholeNumbers: false, desiredTickCount: 4, zeroBound: false),
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

class _MoneyFlowTooltipData extends TooltipData {
  _MoneyFlowTooltipData._internal();
  static final _MoneyFlowTooltipData instance =
      _MoneyFlowTooltipData._internal();
}

class _TooltipData extends TooltipData {
  _TooltipData._internal();
  static final _TooltipData instance = _TooltipData._internal();
}
