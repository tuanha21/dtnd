import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class HomeMarketOverview extends StatefulWidget {
  const HomeMarketOverview({super.key});
  @override
  State<HomeMarketOverview> createState() => _HomeMarketOverviewState();
}

class _HomeMarketOverviewState extends State<HomeMarketOverview> {
  final IDataCenterService dataCenterService = DataCenterService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        dataCenterService.listInterestedStocks.length,
        (index) => HomeMarketOverviewItem(
          index: index,
          data: dataCenterService.listInterestedStocks[index],
        ),
      ),
    );
  }
}

class HomeMarketOverviewItem extends StatelessWidget {
  const HomeMarketOverviewItem(
      {super.key, required this.index, required this.data});
  final int index;
  final StockModel data;
  @override
  Widget build(BuildContext context) {
    final double width = Responsive.getMaxWidth(context);
    return SizedBox.fromSize(
      size: Size(width, 56),
      child: ObxValue<Rx<ThemeMode>>(
        (themeMode) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: themeMode.value.isDark
                  ? AppColors.bg_2
                  : index.isEven
                      ? AppColors.neutral_06
                      : AppColors.bg_1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.stock.stockCode,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${NumUtils.formatInteger(data.stockData?.lastVolume)} CP",
                        style: AppTextStyle.labelMedium_12.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral_03,
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  if (data.stockTradingHistory?.c?.isEmpty ?? true) {
                    return Container();
                  } else {
                    return Container(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width / 5,
                          maxWidth: MediaQuery.of(context).size.width / 4),
                      child: HomeMarketOverviewItemChart(data: data),
                    );
                  }
                }),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${data.stockData?.lastPrice}",
                        style: AppTextStyle.labelMedium_12.copyWith(
                          fontWeight: FontWeight.w600,
                          color: data.stockData?.color ?? AppColors.semantic_02,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: data.stockData?.bgColor(themeMode.value),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                        ),
                        child: Text(
                          "${data.stockData?.prefix} ${data.stockData?.ot} (${data.stockData?.prefix} ${data.stockData?.changePc}%)",
                          maxLines: 1,
                          style: AppTextStyle.labelMedium_12.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                data.stockData?.color ?? AppColors.semantic_02,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        AppService.instance.themeMode,
      ),
    );
  }
}

class HomeMarketOverviewItemChart extends StatelessWidget {
  const HomeMarketOverviewItemChart({super.key, required this.data});

  final StockModel data;

  List<charts.Series<num, int>> toSeries(StockTradingHistory chartData) => [
        charts.Series<num, int>(
          id: "SimpleChart",
          domainFn: (_, index) => index ?? 0,
          measureFn: (datum, index) => datum,
          data: data.stockTradingHistory!.c!,
          seriesColor: charts.ColorUtil.fromDartColor(
              data.stockData?.color ?? AppColors.semantic_02),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      toSeries(data.stockTradingHistory!),
      animate: true,
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(3),
        topMarginSpec: charts.MarginSpec.fixedPixel(3),
        rightMarginSpec: charts.MarginSpec.fixedPixel(3),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(3),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        showAxisLine: false,
        renderSpec: const charts.NoneRenderSpec(),
        viewport: charts.NumericExtents(
            data.stockTradingHistory?.c?.reduce(min) ?? 0,
            data.stockTradingHistory?.c?.reduce(max) ?? 0),
        tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          zeroBound: false,
        ),
      ),
      domainAxis: charts.NumericAxisSpec(
        showAxisLine: false,
        renderSpec: const charts.NoneRenderSpec(),
        viewport:
            charts.NumericExtents(0, data.stockTradingHistory?.c?.length ?? 0),
        tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          zeroBound: false,
        ),
      ),
      defaultRenderer: charts.LineRendererConfig(smoothLine: true),
      behaviors: [
        charts.RangeAnnotation([
          charts.LineAnnotationSegment(
            data.stockTradingHistory?.c?.first ?? 0,
            charts.RangeAnnotationAxisType.measure,
            color: charts.ColorUtil.fromDartColor(
              AppColors.neutral_02,
            ),
            dashPattern: [5, 5],
            strokeWidthPx: 0.3,
          )
        ])
      ],
    );
  }
}
