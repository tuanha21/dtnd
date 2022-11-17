import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
                Column(
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
                      "${data.stockData?.lastVolume} CP",
                      style: AppTextStyle.labelMedium_12.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_03,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Builder(builder: (context) {
                  if (data.listStockTrade?.isEmpty ?? true) {
                    return Container();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: HomeMarketOverviewItemChart(
                          data: data.listStockTrade!),
                    );
                  }
                })),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${data.stockData?.lastPrice}",
                      style: AppTextStyle.labelMedium_12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.semantic_01,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: themeMode.value.isLight
                            ? AppColors.accent_light_01
                            : AppColors.accent_dark_01,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                      ),
                      child: Text(
                        "${data.stockData?.ot}",
                        style: AppTextStyle.labelMedium_12.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.semantic_01,
                        ),
                      ),
                    ),
                  ],
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

  final List<StockTrade> data;

  List<charts.Series<StockTrade, int>> toSeries(List<StockTrade> chartData) => [
        charts.Series<StockTrade, int>(
          id: "SimpleChart",
          domainFn: (_, index) => index ?? 0,
          measureFn: (datum, index) => datum.lastPrice,
          data: data,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      toSeries(data),
      animate: true,
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        showAxisLine: false,
        renderSpec: charts.NoneRenderSpec(),
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          zeroBound: false,
        ),
      ),
      domainAxis: const charts.NumericAxisSpec(
        showAxisLine: false,
        renderSpec: charts.NoneRenderSpec(),
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          zeroBound: false,
        ),
      ),
    );
  }
}
