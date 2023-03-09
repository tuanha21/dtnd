import 'dart:ui';

import 'package:dtnd/=models=/response/top_signal_stock_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/home_simple_line_chart.dart';
import 'package:dtnd/ui/screen/virtual_assistant/signal/signal_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class HomeTopSignalStocks extends StatefulWidget {
  const HomeTopSignalStocks({super.key});

  @override
  State<HomeTopSignalStocks> createState() => _HomeTopSignalStocksState();
}

class _HomeTopSignalStocksState extends State<HomeTopSignalStocks> {
  final HomeController homeController = HomeController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral_07,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox.square(
                    dimension: 36,
                    child: Image.asset(
                      AppImages.home_icon_light,
                    )),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Có top mã cổ phiếu dành cho bạn",
                          style: AppTextStyle.bodyMedium_14
                              .copyWith(color: AppColors.primary_01),
                        ),
                        const SizedBox(width: 8),
                        SizedBox.square(
                            dimension: 20,
                            child: Image.asset(
                              AppImages.home_icon_100,
                            )),
                      ],
                    ),
                    Text(
                      "Đầu tư ngay đừng bỏ lỡ",
                      style: AppTextStyle.bodySmall_12
                          .copyWith(color: AppColors.neutral_03),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox.fromSize(
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
                  itemCount: homeController.topSignalStocks.length,
                  itemBuilder: (context, index) => HomeTopSignalItem(
                    index: index,
                    data: homeController.topSignalStocks[index],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 8,
                  ),
                );
              }, homeController.suggestInitialized),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTopSignalItem extends StatelessWidget {
  const HomeTopSignalItem({super.key, required this.data, required this.index});

  final int index;
  final TopSignalStockModel data;

  @override
  Widget build(BuildContext context) {
    final stockData = data.stockModel.stockData;
    final themeMode = AppService.instance.themeMode.value;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SignalScreen(data: data),
      )),
      child: SizedBox.fromSize(
        size: const Size(148, 136),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: AppColors.accent_light_01,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}",
                    style: AppTextStyle.headlineSmall_24.copyWith(
                      color: AppColors.semantic_01,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.stockModel.stock.stockCode,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 4),
                          ObxValue<Rx<num?>>(
                            (lastPrice) {
                              return Text.rich(
                                TextSpan(children: [
                                  WidgetSpan(
                                      child: Image.asset(
                                    AppImages.prefix_up_icon,
                                    color: AppColors.semantic_01,
                                    width: 16,
                                    height: 16,
                                  )),
                                  TextSpan(
                                    text: "  ${lastPrice.value}",
                                  )
                                ]),
                                style: AppTextStyle.labelMedium_12.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.semantic_01,
                                ),
                              );
                            },
                            stockData.lastPrice,
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      // ObxValue<Rx<num?>>(
                      //   (lot) {
                      //     return Text(
                      //       NumUtils.formatInteger10(lot.value, "-"),
                      //       style: AppTextStyle.labelMedium_12.copyWith(
                      //         fontWeight: FontWeight.w500,
                      //         color: AppColors.neutral_03,
                      //       ),
                      //     );
                      //   },
                      //   stockData.lot,
                      // ),
                      Text(
                        "T+${data.t}",
                        style: AppTextStyle.labelMedium_12.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral_03,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 5,
                      maxWidth: MediaQuery.of(context).size.width / 4),
                  child: HomeSimpleLineChart(
                    kColor: AppColors.semantic_01,
                    data: data.stockModel,
                    getData: () => data.stockModel.getTradingHistory(
                        DataCenterService(),
                        resolution: "1D",
                        from: TimeUtilities.getPreviousDateTime(
                            TimeUtilities.day((data.t ?? 20) * 3 ~/ 2))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
