import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/market/sec_trading.dart';
import '../../../../=models=/response/market/stock_board.dart';
import '../../../../config/service/app_services.dart';
import '../../../../l10n/generated/l10n.dart';

class ForeignWidget extends StatefulWidget {
  final StockModel stockModel;

  const ForeignWidget({Key? key, required this.stockModel}) : super(key: key);

  @override
  State<ForeignWidget> createState() => _ForeignWidgetState();
}

class _ForeignWidgetState extends State<ForeignWidget> {
  final INetworkService iNetworkService = NetworkService();

  late Future<StockBoard> stockBoard;

  late Future<List<SecTrading>> secTrading;

  @override
  void initState() {
    stockBoard = iNetworkService.getStockBoard(widget.stockModel.stockData.sym);
    secTrading =
        iNetworkService.getSecTradingHistory(widget.stockModel.stockData.sym);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var title = Theme.of(context).textTheme.bodySmall;
    final themeMode = AppService.instance.themeMode.value;

    return Column(
      children: [
        FutureBuilder<StockBoard>(
            future: stockBoard,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var stockBoard = snapshot.data!;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: themeMode.isLight
                          ? AppColors.light_bg
                          : AppColors.neutral_01),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Spacer(flex: 5),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(S.of(context).buy,
                                    style: title?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: themeMode.isLight
                                            ? AppColors.neutral_02
                                            : AppColors.neutral_05)),
                              )),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(S.of(context).sell,
                                    style: title?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: themeMode.isLight
                                            ? AppColors.neutral_02
                                            : AppColors.neutral_05)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("Mua bán ròng",
                                    style: title?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: themeMode.isLight
                                            ? AppColors.neutral_02
                                            : AppColors.neutral_05)),
                              ))
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                        height: 16,
                        color: AppColors.neutral_04,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Text(S.of(context).volumn,
                                  style: title?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: themeMode.isLight
                                          ? AppColors.neutral_02
                                          : AppColors.neutral_05))),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    NumUtils.formatInteger(
                                        stockBoard.fGBuyQuantity),
                                    style: title?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary_01)),
                              )),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  NumUtils.formatInteger(
                                      stockBoard.fGSellQuantity),
                                  style: title?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary_01),
                                ),
                              )),
                          Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  NumUtils.formatInteger(
                                      stockBoard.fGNetQuantity),
                                  style: title?.copyWith(
                                      fontWeight: FontWeight.w600),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Text("Giá trị giao dịch",
                                  style: title?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: themeMode.isLight
                                          ? AppColors.neutral_02
                                          : AppColors.neutral_05))),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      parseEmpty(stockBoard.fGBuyValue),
                                      style: title?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.semantic_01),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      S.of(context).billion,
                                      style: title?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: themeMode.isLight
                                              ? AppColors.neutral_02
                                              : AppColors.neutral_05),
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      parseEmpty(stockBoard.fGSellValue),
                                      style: title?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.semantic_03),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      S.of(context).billion,
                                      style: title?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: themeMode.isLight
                                              ? AppColors.neutral_02
                                              : AppColors.neutral_05),
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      parseEmpty(stockBoard.fGNetValue),
                                      style: title?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: stockBoard.fGNetValue! > 0
                                              ? AppColors.semantic_01
                                              : AppColors.semantic_03),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      S.of(context).billion,
                                      style: title?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: themeMode.isLight
                                              ? AppColors.neutral_02
                                              : AppColors.neutral_05),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            }),
        const SizedBox(height: 10),
        FutureBuilder<List<SecTrading>>(
            future: secTrading,
            builder: (context, snapshot) {
              final size = MediaQuery.of(context).size;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var list = snapshot.data;
                return SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: charts.BarChart(
                      [
                        charts.Series<SecTrading, String>(
                          id: 'Sales',
                          colorFn: (_, __) =>
                              charts.MaterialPalette.blue.shadeDefault,
                          domainFn: (SecTrading model, _) => model.time,
                          measureFn: (SecTrading model, _) =>
                              model.fNETBUYVOLUME,
                          fillColorFn: (SecTrading model, _) =>
                              charts.ColorUtil.fromDartColor(
                                  model.fNETBUYVOLUME! > 0
                                      ? AppColors.semantic_01
                                      : AppColors.semantic_03),
                          data: list!,
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
                            (value) => NumUtils.getMoneyWithPostfix(
                                (value ?? 0) * 1000000, context)),
                        tickProviderSpec:
                            const charts.BasicNumericTickProviderSpec(
                                dataIsInWholeNumbers: false,
                                desiredTickCount: 4,
                                zeroBound: false),
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
                            lineStyle: charts.LineStyleSpec(dashPattern: [4])),
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
                              final selectedDatum =
                                  model.selectedDatum.first.datum;
                              // if (liquidityModel.time.elementAt(
                              //         selectedDatum.elementAt(1).index ?? 0) !=
                              //     liquidityModel.time.elementAt(
                              //         selectedDatum.first.index ?? 0)) {}
                              // print(selectedDatum.first.index);
                              // print(selectedDatum.elementAt(1).index);
                              final datas = <String>[
                                selectedDatum.time,
                                if ((selectedDatum.fNETBUYVOLUME ?? 0) > 0)
                                  "Mua ròng : ${NumUtils.formatDouble(selectedDatum.fNETBUYVOLUME)} tỷ"
                                else if ((selectedDatum.fNETBUYVOLUME ?? 0) < 0)
                                  "Bán ròng : ${NumUtils.formatDouble(selectedDatum.fNETBUYVOLUME.abs())} tỷ"
                                else
                                  "Không có giao dịch"
                              ];
                              _TooltipData.instance.setData(datas);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            })
      ],
    );
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
