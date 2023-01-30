import 'dart:ui';

import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';
import 'home_market_overview.dart';

class HomeInterestedCatalog extends StatefulWidget {
  const HomeInterestedCatalog({super.key});

  @override
  State<HomeInterestedCatalog> createState() => _HomeInterestedCatalogState();
}

class _HomeInterestedCatalogState extends State<HomeInterestedCatalog> {
  final HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(MediaQuery.of(context).size.width, 136),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ObxValue<Rx<bool>>((initialized) {
          if (!initialized.value) {
            return Center(
              child: Text(S.of(context).loading),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: homeController.interestedCatalog.length,
            itemBuilder: (context, index) => HomeInterestedCatalogItem(
              data: homeController.interestedCatalog[index],
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              width: 8,
            ),
          );
        }, homeController.initialized),
      ),
    );
  }
}

class HomeInterestedCatalogItem extends StatelessWidget {
  const HomeInterestedCatalogItem({super.key, required this.data});
  final StockModel data;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StockDetailScreen(stockModel: data),
      )),
      child: SizedBox.fromSize(
        size: const Size(148, 136),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: data.stockData.bgColor(themeMode),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.stock.stockCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            ObxValue<Rx<num?>>(
                              (lastPrice) {
                                return Text.rich(
                                  TextSpan(children: [
                                    WidgetSpan(
                                        child: data.stockData
                                            .prefixIcon(size: 16)),
                                    TextSpan(
                                      text: "${lastPrice.value}",
                                    )
                                  ]),
                                  style: AppTextStyle.labelMedium_12.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: data.stockData.color,
                                  ),
                                );
                                return Text(
                                  "${lastPrice.value}",
                                  style: AppTextStyle.labelMedium_12.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: data.stockData.color,
                                  ),
                                );
                              },
                              data.stockData.lastPrice,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ObxValue<Rx<num?>>(
                              (lot) {
                                return Text(
                                  NumUtils.formatInteger10(lot.value, "-"),
                                  style: AppTextStyle.labelMedium_12.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.neutral_03,
                                  ),
                                );
                              },
                              data.stockData.lot,
                            ),
                            // Container(
                            //   padding: const EdgeInsets.all(4.0),
                            //   decoration: BoxDecoration(
                            //     color: data.stockData.bgColor(themeMode),
                            //     borderRadius:
                            //         const BorderRadius.all(Radius.circular(2)),
                            //   ),
                            //   child: Obx(() {
                            //     return Text(
                            //       "${data.stockData.ot.value}",
                            //       style: AppTextStyle.labelMedium_12.copyWith(
                            //         fontWeight: FontWeight.w600,
                            //         color: data.stockData.color,
                            //       ),
                            //     );
                            //   }),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
