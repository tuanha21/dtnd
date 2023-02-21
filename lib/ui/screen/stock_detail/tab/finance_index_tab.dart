import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/component/benefit_chart.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/financial_index.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;
import '../../../../=models=/response/stock_financial_index_model.dart';
import '../../../../utilities/logger.dart';
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

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    listFinancial = dataCenterService.getStockFinancialIndex(
        widget.stockModel.stock.stockCode, type);
  }

  String type = "Y";

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
                child: ListView(
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
                                  widget.stockModel.stock.stockCode, type);
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
          .map((e) => type == "Y" ? e.rEPORTDATE.year : e.rEPORTDATE.millisecondsSinceEpoch)
          .toList()
          .reduce(math.max);
      min = listData
          .map((e) => type == "Y" ? e.rEPORTDATE.year : e.rEPORTDATE.millisecondsSinceEpoch)
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
