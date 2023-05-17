import 'dart:ui';

import 'package:dtnd/=models=/response/top_signal_stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/screen/signal/signal_screen.dart';
import 'package:dtnd/ui/screen/home/screen/suggested_signal/suggested_signal_screen.dart';
import 'package:dtnd/ui/screen/home/widget/home_simple_line_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/gestures.dart';
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
                GestureDetector(
                  onTap: () {
                    homeController.getTopSignal();
                  },
                  child: SizedBox.square(
                      dimension: 36,
                      child: Image.asset(
                        AppImages.home_icon_light,
                      )),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                              text: "Có top mã cổ phiếu dành cho bạn",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SuggestedSignalScreen(),
                                  ));
                                }),
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
                if (homeController.loadingTopSignalStocks.value) {
                  return Center(
                    child: Text(S.of(context).loading),
                  );
                }
                if (homeController.topSignalStocks.value?.isEmpty ?? true) {
                  return const Center(
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: EmptyListWidget(),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: homeController.topSignalStocks.value!.length,
                  itemBuilder: (context, index) => HomeTopSignalItem(
                    index: index,
                    data: homeController.topSignalStocks.value![index],
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
    final themeMode = AppService.instance.themeMode.value;
    final Color color = data.color;
    final Color bgColor = data.bgColor(themeMode);
    final Widget icon = data.prefixIcon();

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SignalScreen(
          code: data.cSHARECODE,
          type: data.cTYPE,
          stockModel: data.stockModel,
        ),
      )),
      child: SizedBox.fromSize(
        size: const Size(148, 136),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: bgColor,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}",
                    style: AppTextStyle.headlineSmall_24.copyWith(
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
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
                            Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                  child: SizedBox.square(
                                    dimension: 16,
                                    child: icon,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${data.cSELLPRICE}",
                                )
                              ]),
                              style: AppTextStyle.labelMedium_12.copyWith(
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            )
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "T+${data.t}",
                              style: AppTextStyle.labelMedium_12.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.neutral_03,
                              ),
                            ),
                            Text(
                              "${data.cPC}%",
                              style: AppTextStyle.labelMedium_12.copyWith(
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                    kColor: color,
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
