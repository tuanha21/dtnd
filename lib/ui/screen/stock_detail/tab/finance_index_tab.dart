import 'dart:math' as math;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/radar_chart_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/component/benefit_chart.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/financial_index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/stock_financial_index_model.dart';
import '../../../../utilities/time_utils.dart';
import '../../../theme/app_color.dart';

class FinanceIndexTab extends StatefulWidget {
  const FinanceIndexTab({
    super.key,
    required this.stockModel,
  });

  final StockModel stockModel;

  @override
  State<FinanceIndexTab> createState() => _FinanceIndexTabState();
}

class _FinanceIndexTabState extends State<FinanceIndexTab> {
  final IDataCenterService dataCenterService = DataCenterService();

  late Future<List<StockFinancialIndex>> listFinancial;
  late Future<RadarChartModel> dataRadar;
  RadarChartModel? chartData;
  int selectedDataSetIndex = -1;
  bool relativeAngleMode = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    listFinancial = dataCenterService.getStockFinancialIndex(
        widget.stockModel.stock.stockCode, type);
    // dataRadar =
    //     dataCenterService.getDataRadarChart(widget.stockModel.stock.stockCode);
    // dataRadar.then((value) {
    //   chartData = value;
    // });
  }

  String type = "Y";

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.6)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.6),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        color: AppColors.semantic_06_1,
        values: [
          chartData?.secPe?.toDouble() ?? 0,
          chartData?.secEpsGrowthQy?.toDouble() ?? 0,
          chartData?.secRevGrowthQy?.toDouble() ?? 0,
          chartData?.secPriceBvpst?.toDouble() ?? 0,
          chartData?.secPs?.toDouble() ?? 0,
          chartData?.secRoa?.toDouble() ?? 0,
          chartData?.secRoe?.toDouble() ?? 0,
        ],
      ),
      RawDataSet(
        color: AppColors.data_2,
        values: [
          chartData?.indPe?.toDouble() ?? 0,
          chartData?.indEpsGrowthQy?.toDouble() ?? 0,
          chartData?.indRevGrowthQy?.toDouble() ?? 0,
          chartData?.indPriceBvpst?.toDouble() ?? 0,
          chartData?.indPs?.toDouble() ?? 0,
          chartData?.indRoa?.toDouble() ?? 0,
          chartData?.indRoe?.toDouble() ?? 0,
        ],
      ),
      RawDataSet(
        color: AppColors.semantic_04_1,
        values: [
          chartData?.mkPe?.toDouble() ?? 0,
          chartData?.mkEpsGrowthQy?.toDouble() ?? 0,
          chartData?.mkRevGrowthQy?.toDouble() ?? 0,
          chartData?.mkPriceBvpst?.toDouble() ?? 0,
          chartData?.mkPs?.toDouble() ?? 0,
          chartData?.mkRoa?.toDouble() ?? 0,
          chartData?.mkRoe?.toDouble() ?? 0,
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StockFinancialIndex>>(
        future: listFinancial,
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data;
            if (list == null) return const SizedBox();
            num annotation = 1;
            num max = 2;
            num min = 0;
            if (list.isNotEmpty) {
              annotation = list.first.rEPORTDATE.year;
              max = math.max<num>(
                  list.map((e) => e.rEPORTDATE.year).toList().reduce(math.max),
                  annotation);
              min = math.min<num>(
                  list.map((e) => e.rEPORTDATE.year).reduce(math.min),
                  annotation);
              list.sort((a, b) => a.rEPORTDATE.compareTo(b.rEPORTDATE));
              widget.stockModel.changeStockFinancialIndex(list);
            }

            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      // AspectRatio(
                      //   aspectRatio: 1.35,
                      //   child: RadarChart(
                      //     RadarChartData(
                      //         borderData: FlBorderData(
                      //           show: true,
                      //           border: Border.all(
                      //               color: AppColors.neutral_03, width: 1),
                      //         ),
                      //         radarBorderData: const BorderSide(
                      //             color: AppColors.neutral_03, width: 1),
                      //         radarBackgroundColor: Colors.transparent,
                      //         tickBorderData :  const BorderSide(
                      //             color: AppColors.neutral_03, width: 1),
                      //         gridBorderData: const BorderSide(
                      //             color: AppColors.neutral_03, width: 1),
                      //           ticksTextStyle: TextStyle(color: Colors.transparent,),
                      //         getTitle: (index, angle) {
                      //           switch (index) {
                      //             case 0:
                      //               return const RadarChartTitle(
                      //                 text: 'P/E (T12M)',
                      //                 angle: 0,
                      //               );
                      //             case 1:
                      //               return const RadarChartTitle(
                      //                   text: 'TEPS (%) \n(T12M)', angle: 1);
                      //             case 2:
                      //               return const RadarChartTitle(
                      //                 text: 'Tăng trưởng \ndoanh thu(%)\n(T12M)',
                      //                 angle: 1,
                      //               );
                      //             case 3:
                      //               return const RadarChartTitle(
                      //                 text: 'P/Tangible BV\n(T12M)',
                      //                 angle: 1,
                      //               );
                      //             case 4:
                      //               return const RadarChartTitle(
                      //                 text: 'P/S',
                      //                 angle: 1,
                      //               );
                      //             case 5:
                      //               return const RadarChartTitle(
                      //                 text: 'ROE',
                      //                 angle: 1,
                      //               );
                      //             case 6:
                      //               return const RadarChartTitle(
                      //                 text: 'RO',
                      //                 angle: 1,
                      //               );
                      //             default:
                      //               return const RadarChartTitle(text: '');
                      //           }
                      //         },
                      //         titlePositionPercentageOffset: 0.2,
                      //         titleTextStyle: const TextStyle(
                      //             fontSize: 14, color: AppColors.neutral_03),
                      //         tickCount: 5,
                      //         dataSets: showingDataSets(),
                      //         radarShape: RadarShape.polygon),
                      //     swapAnimationCurve: Curves.linear,
                      //     // swapAnimationDuration: Duration(milliseconds: ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 21,
                      //       height: 8,
                      //       color: AppColors.semantic_06_1,
                      //     ),
                      //     const SizedBox(
                      //       width: 9,
                      //     ),
                      //     Text('Theo mã', style: AppTextStyle.bodySmall_12)
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 21,
                      //       height: 8,
                      //       color: AppColors.data_2,
                      //     ),
                      //     const SizedBox(
                      //       width: 9,
                      //     ),
                      //     Text(
                      //       'Theo ngành',
                      //       style: AppTextStyle.bodySmall_12,
                      //     )
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 21,
                      //       height: 8,
                      //       color: AppColors.semantic_04_1,
                      //     ),
                      //     const SizedBox(
                      //       width: 9,
                      //     ),
                      //     Text('Theo thị trường',
                      //         style: AppTextStyle.bodySmall_12)
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          FinancialIndex(stockModel: widget.stockModel),
                          const SizedBox(height: 20),
                          IndexChart(
                            stockModel: widget.stockModel,
                            min: min,
                            max: max,
                            getType: (String typeSTr) {
                              setState(() {
                                type = typeSTr;
                                listFinancial =
                                    dataCenterService.getStockFinancialIndex(
                                        widget.stockModel.stock.stockCode,
                                        type);
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Doanh thu",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          DoanhThuWidget(
                            list: list,
                            type: type,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        });
  }
}

class IndexChart extends StatefulWidget {
  final StockModel stockModel;
  final num min;
  final num max;
  final ValueChanged<String> getType;

  const IndexChart(
      {Key? key,
      required this.stockModel,
      required this.min,
      required this.max,
      required this.getType})
      : super(key: key);

  @override
  State<IndexChart> createState() => _IndexChartState();
}

class _IndexChartState extends State<IndexChart> {
  bool isYear = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                S.of(context).index,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            GestureDetector(
              onTap: () {
                isYear = !isYear;
                widget.getType.call(isYear ? "Y" : "Q");
              },
              child: Row(
                children: [
                  const Icon(Icons.arrow_drop_down,
                      color: AppColors.primary_01),
                  Text(isYear ? "Theo năm" : 'Theo quý',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppColors.primary_01))
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        BenefitChart(
            listStockFinancialIndex: widget.stockModel.stockFinancialIndex,
            type: isYear ? "Y" : "Q"),
      ],
    );
  }
}

class DoanhThuWidget extends StatelessWidget {
  final List<StockFinancialIndex> list;
  final String type;

  const DoanhThuWidget({Key? key, required this.list, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listData = list;
    num max = 2;
    num min = 0;
    if (listData.isNotEmpty) {
      max = listData
          .map((e) => type == "Y"
              ? e.rEPORTDATE.year
              : e.rEPORTDATE.millisecondsSinceEpoch)
          .toList()
          .reduce(math.max);
      min = listData
          .map((e) => type == "Y"
              ? e.rEPORTDATE.year
              : e.rEPORTDATE.millisecondsSinceEpoch)
          .reduce(math.min);
    }

    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: 150,
              child: Column(
                children: [
                  Expanded(
                    child: charts.ScatterPlotChart(
                      [
                        charts.Series<StockFinancialIndex, int>(
                          id: 'ROA',
                          domainFn: (StockFinancialIndex sales, _) {
                            return type == "Y"
                                ? sales.rEPORTDATE.year
                                : sales.rEPORTDATE.millisecondsSinceEpoch;
                          },
                          measureFn: (StockFinancialIndex sales, _) =>
                              sales.rOA,
                          radiusPxFn: (StockFinancialIndex sales, _) => 8,
                          data: listData,
                          fillColorFn: (StockFinancialIndex sales, _) =>
                              charts.ColorUtil.fromDartColor(
                                  AppColors.primary_01),
                          colorFn: (StockFinancialIndex sales, _) =>
                              charts.ColorUtil.fromDartColor(
                                  AppColors.primary_01),
                        ),
                        charts.Series<StockFinancialIndex, int>(
                          id: 'ROE',
                          domainFn: (StockFinancialIndex sales, _) {
                            return type == "Y"
                                ? sales.rEPORTDATE.year
                                : sales.rEPORTDATE.millisecondsSinceEpoch;
                          },
                          measureFn: (StockFinancialIndex sales, _) =>
                              sales.rOE,
                          radiusPxFn: (StockFinancialIndex sales, _) => 8,
                          data: listData,
                          fillColorFn: (StockFinancialIndex sales, _) =>
                              charts.ColorUtil.fromDartColor(
                                  AppColors.neutral_04),
                          colorFn: (StockFinancialIndex sales, _) =>
                              charts.ColorUtil.fromDartColor(
                                  AppColors.neutral_04),
                        )
                      ],
                      primaryMeasureAxis: const charts.NumericAxisSpec(
                        showAxisLine: false,
                        renderSpec: charts.NoneRenderSpec(),
                      ),
                      domainAxis: charts.NumericAxisSpec(
                          viewport: charts.NumericExtents(min, max),
                          renderSpec: const charts.NoneRenderSpec(),
                          showAxisLine: false),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(listData.length, (index) {
                        String time = "";
                        if (type == "Q") {
                          time =
                              'Q${TimeUtilities.getQuarter(listData[index].rEPORTDATE)}/${listData[index].rEPORTDATE.year}';
                        }
                        if (type == "Y") {
                          time = '${listData[index].rEPORTDATE.year}';
                        }
                        var indexData = listData[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: AppColors.primary_02,
                              ),
                              child: Text(
                                time,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.light_bg),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              indexData.rOE?.toString() ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: AppColors.neutral_04,
                                      fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              indexData.rOA?.toString() ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: AppColors.primary_01,
                                      fontSize: 12),
                            )
                          ],
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.neutral_04),
                    ),
                    const SizedBox(width: 10),
                    const Text('ROE'),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.primary_01),
                    ),
                    const SizedBox(width: 10),
                    const Text("ROA"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        )
      ],
    );
  }
}

class RawDataSet {
  RawDataSet({
    required this.color,
    required this.values,
  });

  final Color color;
  final List<double> values;
}
