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
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    if (widget.stockModel.stockFinancialIndex.isEmpty) {
      await getStockFinancialIndex();
    }
    setState(() {
      initialized = true;
    });
  }

  Future<void> getStockFinancialIndex() async {
    widget.stockModel.changeStockFinancialIndex(await dataCenterService
        .getStockFinancialIndex(widget.stockModel.stock.stockCode));
  }

  num annotation = 1;
  num max = 2;
  num min = 0;

  @override
  Widget build(BuildContext context) {
    Widget benefitChart;
    if (widget.stockModel.stockFinancialIndex.isEmpty) {
      benefitChart = Container();
    } else {
      annotation = widget.stockModel.stockFinancialIndex.first.rEPORTDATE.year;
      max = math.max<num>(
          widget.stockModel.stockFinancialIndex
              .map((e) => e.rEPORTDATE.year)
              .toList()
              .reduce(math.max),
          annotation);
      min = math.min<num>(
          widget.stockModel.stockFinancialIndex
              .map((e) => e.rEPORTDATE.year)
              .reduce(math.min),
          annotation);
      benefitChart = BenefitChart(
          listStockFinancialIndex: widget.stockModel.stockFinancialIndex);
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const SizedBox(height: 20),
            FinancialIndex(stockModel: widget.stockModel),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).index,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Container()
              ],
            ),
            const SizedBox(height: 16),
            benefitChart,
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
            SizedBox(
              height: 150,
              child: Column(
                children: [
                  Expanded(
                    child: charts.ScatterPlotChart(
                      [
                        charts.Series<StockFinancialIndex, int>(
                          id: 'ROA',
                          domainFn: (StockFinancialIndex sales, _) =>
                              sales.rEPORTDATE.year,
                          measureFn: (StockFinancialIndex sales, _) =>
                              sales.rOA,
                          radiusPxFn: (StockFinancialIndex sales, _) => 8,
                          data: widget.stockModel.stockFinancialIndex,
                          fillColorFn: (StockFinancialIndex sales, _) =>
                              charts.ColorUtil.fromDartColor(
                                  AppColors.primary_01),
                          colorFn: (StockFinancialIndex sales, _) =>
                              charts.ColorUtil.fromDartColor(
                                  AppColors.primary_01),
                        ),
                        charts.Series<StockFinancialIndex, int>(
                          id: 'ROE',
                          domainFn: (StockFinancialIndex sales, _) =>
                              sales.rEPORTDATE.year,
                          measureFn: (StockFinancialIndex sales, _) =>
                              sales.rOE,
                          radiusPxFn: (StockFinancialIndex sales, _) => 8,
                          data: widget.stockModel.stockFinancialIndex,
                          fillColorFn: (StockFinancialIndex sales, _) =>
                              charts.ColorUtil.fromDartColor(
                                  AppColors.neutral_04),
                          colorFn: (StockFinancialIndex sales, _) =>
                              charts.ColorUtil.fromDartColor(
                                  AppColors.neutral_04),
                        )
                      ],
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        showAxisLine: false,
                        renderSpec: const charts.NoneRenderSpec(),
                        tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                          (measure) => "",
                        ),
                      ),
                      domainAxis: charts.NumericAxisSpec(
                          viewport: charts.NumericExtents(min, max),
                          renderSpec: const charts.GridlineRendererSpec(
                              labelStyle: charts.TextStyleSpec(fontSize: 9)),
                          showAxisLine: false),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(
                          widget.stockModel.stockFinancialIndex.length,
                          (index) {
                        var indexData =
                            widget.stockModel.stockFinancialIndex[index];
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
                                indexData.rEPORTDATE.year.toString(),
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
                    Text("ROA"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
