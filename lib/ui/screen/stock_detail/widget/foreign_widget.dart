import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../../=models=/response/sec_trading.dart';
import '../../../../=models=/response/stock_board.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/app_color.dart';

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
                      color: AppColors.light_bg),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                child: Text("Mua",
                                    style: title?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.neutral_02)),
                              )),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("Bán",
                                    style: title?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.neutral_02)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("Mua bán ròng",
                                    style: title?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.neutral_02)),
                              ))
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                        height: 10,
                        color: AppColors.neutral_04,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Text(S.of(context).volumn,
                                  style: title?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.neutral_02))),
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
                                      color: AppColors.neutral_02))),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${stockBoard.fGBuyValue?.toStringAsFixed(2)}T",
                                  style: title?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary_01),
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${stockBoard.fGSellValue?.toStringAsFixed(2)}T",
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
                                  NumUtils.formatInteger(stockBoard.fGNetValue),
                                  style: title?.copyWith(
                                      fontWeight: FontWeight.w600),
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
                      domainAxis: const charts.OrdinalAxisSpec(
                        renderSpec: charts.SmallTickRendererSpec(
                          labelOffsetFromAxisPx: 5,
                          labelStyle: charts.TextStyleSpec(fontSize: 9),
                        ),
                      ),
                      secondaryMeasureAxis: charts.NumericAxisSpec(
                        showAxisLine: true,
                        tickFormatterSpec:
                            charts.BasicNumericTickFormatterSpec((measure) {
                          return NumUtils.formatInteger(measure);
                        }),
                        tickProviderSpec:
                            const charts.BasicNumericTickProviderSpec(
                                dataIsInWholeNumbers: false,
                                desiredTickCount: 4,
                                zeroBound: false),
                        renderSpec: const charts.GridlineRendererSpec(
                            axisLineStyle: charts.LineStyleSpec(
                              dashPattern: [4],
                              thickness: 0,
                              color: charts.Color(r: 74, g: 85, b: 104),
                            ),
                            labelStyle: charts.TextStyleSpec(fontSize: 9),
                            lineStyle: charts.LineStyleSpec(dashPattern: [4])),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            })
      ],
    );
  }
}
