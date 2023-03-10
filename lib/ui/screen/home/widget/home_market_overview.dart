import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/home_simple_line_chart.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/chart/simple_line_chart.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_controller.dart';
import 'trash_component.dart';

class HomeMarketOverview extends StatefulWidget {
  const HomeMarketOverview({super.key});
  @override
  State<HomeMarketOverview> createState() => _HomeMarketOverviewState();
}

class _HomeMarketOverviewState extends State<HomeMarketOverview>
    with SingleTickerProviderStateMixin {
  final HomeController homeController = HomeController();
  late final TabController _tabController;

  bool up = true;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<bool>>((initialized) {
      if (!initialized.value) {
        return Center(
          child: Text(S.of(context).loading),
        );
      }
      List<TrashModel>? data;

      // Widget grid = SizedBox(
      //   height: 72 * 3 + 16 * 2,
      //   child: GridView.builder(
      //     padding: const EdgeInsets.symmetric(horizontal: 16),
      //     itemCount: data.length,
      //     scrollDirection: Axis.horizontal,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 3,
      //       mainAxisSpacing: 16,
      //       crossAxisSpacing: 16,
      //       childAspectRatio: 72 / (width - 32),
      //     ),
      //     itemBuilder: (context, index) => HomeMarketOverviewItem(
      //       data: data[index],
      //     ),
      //   ),
      // );

      final Widget sortArrow = Container(
        // color: Colors.green,
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Opacity(
              opacity: up ? 1.0 : 0.3,
              child: const Icon(
                Icons.expand_less_rounded,
                size: 12,
              ),
            ),
            Opacity(
              opacity: !up ? 1.0 : 0.3,
              child: const Icon(
                Icons.expand_more_rounded,
                size: 12,
              ),
            ),
          ],
        ),
      );
      Widget list = Obx(() {
        switch (_tabController.index) {
          case 1:
            if (!up) {
              data = homeController.priceDecreaseToday.value;
            } else {
              data = homeController.priceIncreaseToday.value;
            }
            break;
          case 2:
            data = homeController.topVolumnToday.value;
            break;
          default:
            data = homeController.hotToday.value;
        }
        return Column(
          children: [
            for (int i = 0; i < (data?.length ?? 0); i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: SizedBox(
                  height: 72,
                  child: TrashComponent(
                    snapshotData: data![i],
                  ),
                ),
              )
          ],
        );
      });
      Widget grid = Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onTap: (value) async {
                  if (!_tabController.indexIsChanging && value == 1) {
                    up = !up;
                    await homeController.changeList(_tabController.index, up,
                        data?.map((e) => e.sTOCKCODE).toList());
                  } else {
                    await homeController.changeList(_tabController.index, true,
                        data?.map((e) => e.sTOCKCODE).toList());
                  }
                  setState(() {});
                  // setState(() {});
                },
                tabs: <Widget>[
                  // const Text("🔥HOT"),
                  const Text("Phổ biến"),
                  Row(
                    children: [
                      const Text("Top biến động"),
                      sortArrow,
                    ],
                  ),
                  const Text("Top khối lượng"),
                ],
              ),
            ),
          ),
          list,
        ],
      );
      return grid;
    }, homeController.topInitialized);
  }
}

// class HomeMarketOverviewItem extends StatelessWidget {
//   const HomeMarketOverviewItem({
//     super.key,
//     required this.dataCenterService,
//     this.data,
//     this.onHold,
//     this.onTap,
//   });
//   final IDataCenterService dataCenterService;
//   final StockModel? data;
//   final VoidCallback? onTap;
//   final VoidCallback? onHold;
//   @override
//   Widget build(BuildContext context) {
//     final themeMode = AppService.instance.themeMode.value;
//     final double width = Responsive.getMaxWidth(context);
//     return Material(
//       borderRadius: const BorderRadius.all(Radius.circular(8)),
//       child: InkWell(
//         onTap: () {
//           if (data != null) {
//             if (onTap != null) {
//               return onTap!.call();
//             } else {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => StockDetailScreen(stockModel: data!),
//               ));
//               return;
//             }
//           }
//         },
//         onLongPress: onHold,
//         borderRadius: const BorderRadius.all(Radius.circular(8)),
//         child: Ink(
//           // alignment: Alignment.center,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(8)),
//             color: themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_07,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               StockIcon(
//                 stockCode: data?.stock.stockCode,
//               ),
//               const SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     data?.stock.stockCode ?? "-",
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleSmall!
//                         .copyWith(fontWeight: FontWeight.w600),
//                   ),
//                   ObxValue<Rx<num?>>(
//                     (lastPrice) {
//                       return Text(
//                         "${data?.stockData.changePc ?? "-"}%",
//                         style: AppTextStyle.labelMedium_12.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: data?.stockData.color ?? AppColors.semantic_02,
//                         ),
//                       );
//                     },
//                     data?.stockData.lastPrice ?? 0.obs,
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 24),
//               Expanded(
//                 child: Container(
//                   constraints: BoxConstraints(
//                       minWidth: MediaQuery.of(context).size.width / 5,
//                       maxWidth: MediaQuery.of(context).size.width / 4),
//                   child: Obx(() {
//                     data?.stockData.lastPrice.value;
//                     print(data?.stock.stockCode);
//                     if (data?.stock.stockCode == "SCR") {
//                       logger.v(data?.simpleChartData.value);
//                     }
//                     return SimpleLineChart(
//                       data: data?.simpleChartData.value,
//                       annotation: data?.stockData.r.value ??
//                           data?.simpleChartData.value?.first,
//                       color: data?.stockData.color,
//                       // getData: data != null
//                       //     ? () async {
//                       //         final todayHstr = await dataCenterService
//                       //             .getStockTradingHistory(
//                       //                 data!.stock.stockCode,
//                       //                 "5",
//                       //                 DateTime.now().beginningOfDay,
//                       //                 DateTime.now());
//                       //         if (data!.simpleChartData.value?.isEmpty ??
//                       //             true) {
//                       //           return todayHstr;
//                       //         } else {
//                       //           if (todayHstr?.o?.isEmpty ?? true) {
//                       //             return await dataCenterService
//                       //                 .getStockTradingHistory(
//                       //                     data!.stock.stockCode,
//                       //                     "5",
//                       //                     TimeUtilities.getPreviousDateTime(
//                       //                             TimeUtilities.day(1))
//                       //                         .beginningOfDay,
//                       //                     DateTime.now());
//                       //           } else {
//                       //             return todayHstr;
//                       //           }
//                       //         }
//                       //       }
//                       //     : null,
//                       // future: data.getTradingHistory(DataCenterService(),
//                       //     resolution: "5", from: TimeUtilities.beginningOfDay),
//                     );
//                   }),
//                 ),
//               ),
//               const SizedBox(width: 24),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // ObxValue<Rx<num?>>(
//                   //   (lastPrice) {
//                   //     return Text(
//                   //       "${lastPrice.value}",
//                   //       style: AppTextStyle.labelMedium_12.copyWith(
//                   //         fontWeight: FontWeight.w600,
//                   //         color: data.stockData.color,
//                   //       ),
//                   //     );
//                   //   },
//                   //   data.stockData.lastPrice,
//                   // ),
//                   ObxValue<Rx<num?>>(
//                     (lastPrice) {
//                       return Row(
//                         children: [
//                           data?.stockData.prefixIcon(size: 12) ??
//                               Image.asset(
//                                 AppImages.prefix_ref_icon,
//                                 width: 12,
//                                 height: 12,
//                               ),
//                           Text(
//                             " ${data?.stockData.lastPrice ?? "-"}",
//                             maxLines: 1,
//                             style: AppTextStyle.labelMedium_12.copyWith(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 13,
//                               color: data?.stockData.color ??
//                                   AppColors.semantic_02,
//                             ),
//                           )
//                         ],
//                       );
//                     },
//                     data?.stockData.lastPrice ?? 0.obs,
//                   ),

//                   Obx(() {
//                     return Text(
//                       "${NumUtils.formatInteger10(data?.stockData.lot.value ?? 0)} CP",
//                       style: AppTextStyle.labelMedium_12.copyWith(
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.neutral_03,
//                       ),
//                     );
//                   }),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
