import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/stock_detail_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

import '../home_controller.dart';

class HomeMarketOverview extends StatefulWidget {
  const HomeMarketOverview({super.key});
  @override
  State<HomeMarketOverview> createState() => _HomeMarketOverviewState();
}

class _HomeMarketOverviewState extends State<HomeMarketOverview> {
  final HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<bool>>((initialized) {
      if (!initialized.value) {
        return Center(
          child: Text(S.of(context).loading),
        );
      }
      final width = MediaQuery.of(context).size.width;

      Widget grid = SizedBox(
        height: 72 * 3 + 16 * 2,
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: homeController.marketToday.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 72 / (width - 32),
          ),
          itemBuilder: (context, index) => HomeMarketOverviewItem(
            data: homeController.marketToday[index],
          ),
        ),
      );
      return grid;
      return Column(
        children: List<Widget>.generate(
          homeController.marketToday.length,
          (index) => HomeMarketOverviewItem(
            data: homeController.marketToday[index],
          ),
        ),
      );
    }, homeController.initialized);
  }
}

class HomeMarketOverviewItem extends StatelessWidget {
  const HomeMarketOverviewItem({
    super.key,
    required this.data,
    this.onHold,
    this.onTap,
  });
  final StockModel data;
  final VoidCallback? onTap;
  final VoidCallback? onHold;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final double width = Responsive.getMaxWidth(context);
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: onTap ??
            () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StockDetailScreen(stockModel: data),
                )),
        onLongPress: onHold,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          // alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_07,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 32,
                  child: Center(
                    child: ClipOval(
                      child: SizedBox.square(
                        dimension: 32.0,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://info.sbsi.vn/logo/${data.stock.stockCode}",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 32.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.scaleDown),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  data.stock.stockCode,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: Obx(() {
                    if (data.stockTradingHistory.value?.c?.isEmpty ?? true) {
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
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ObxValue<Rx<num?>>(
                    //   (lastPrice) {
                    //     return Text(
                    //       "${lastPrice.value}",
                    //       style: AppTextStyle.labelMedium_12.copyWith(
                    //         fontWeight: FontWeight.w600,
                    //         color: data.stockData.color,
                    //       ),
                    //     );
                    //   },
                    //   data.stockData.lastPrice,
                    // ),

                    ObxValue<Rx<num?>>(
                      (lastPrice) {
                        return Text.rich(
                          TextSpan(children: [
                            WidgetSpan(
                                child: data.stockData.prefixIcon(size: 12)),
                            TextSpan(
                              text: " ${data.stockData.changePc}%",
                            )
                          ]),
                          maxLines: 1,
                          style: AppTextStyle.labelMedium_12.copyWith(
                            fontWeight: FontWeight.w600,
                            color: data.stockData.color,
                          ),
                        );
                      },
                      data.stockData.lastPrice,
                    ),
                    Obx(() {
                      return Text(
                        "${NumUtils.formatInteger10(data.stockData.lot.value)} CP",
                        style: AppTextStyle.labelMedium_12.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral_03,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
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
          data: data.stockTradingHistory.value!.c!,
          seriesColor: charts.ColorUtil.fromDartColor(data.stockData.color),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      toSeries(data.stockTradingHistory.value!),
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
            data.stockTradingHistory.value?.c?.reduce(min) ?? 0,
            data.stockTradingHistory.value?.c?.reduce(max) ?? 0),
        tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          zeroBound: false,
        ),
      ),
      domainAxis: charts.NumericAxisSpec(
        showAxisLine: false,
        renderSpec: const charts.NoneRenderSpec(),
        viewport: charts.NumericExtents(
            0, data.stockTradingHistory.value?.c?.length ?? 0),
        tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          zeroBound: false,
        ),
      ),
      defaultRenderer: charts.LineRendererConfig(smoothLine: true),
      behaviors: [
        charts.RangeAnnotation([
          charts.LineAnnotationSegment(
            data.stockTradingHistory.value?.c?.first ?? 0,
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
