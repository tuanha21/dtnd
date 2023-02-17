import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/sheet/execute_right_sheet.dart';
import 'package:dtnd/ui/screen/asset/sheet/sheet_config.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import 'asset_grid_element.dart';

class BuyRightWidget extends StatefulWidget {
  const BuyRightWidget({
    super.key,
    required this.data,
    this.onHold,
    this.onExpand,
  });
  final UnexecutedRightModel? data;
  final ValueChanged<UnexecutedRightModel?>? onExpand;
  final VoidCallback? onHold;

  @override
  State<BuyRightWidget> createState() => _BuyRightWidgetState();
}

class _BuyRightWidgetState extends State<BuyRightWidget> {
  final IDataCenterService dataCenterService = DataCenterService();
  bool expand = false;
  Stock? stock;

  void onTap() {
    setState(() {
      expand = !expand;
    });
    if (expand) {
      widget.onExpand?.call(widget.data);
    }
  }

  @override
  void initState() {
    super.initState();
    getStock(widget.data?.cRECEIVESHARECODE);
  }

  void getStock(String? stockCode) async {
    if (stockCode == null) {
      return;
    }
    final stocks = dataCenterService.getStockFromStockCodes([stockCode]);
    if (stocks.isNotEmpty) {
      setState(() {
        stock = stocks.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            color: themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_06,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  StockIcon(
                    color: Colors.white,
                    stockCode: widget.data?.cRECEIVESHARECODE,
                  ),

                  const SizedBox(width: 8),
                  // Expanded(
                  //   child: Obx(() {
                  //     if (data.stockTradingHistory.value?.c?.isEmpty ?? true) {
                  //       return Container();
                  //     } else {
                  //       return Container(
                  //         constraints: BoxConstraints(
                  //             minWidth: MediaQuery.of(context).size.width / 5,
                  //             maxWidth: MediaQuery.of(context).size.width / 4),
                  //         child: HomeMarketOverviewItemChart(data: data),
                  //       );
                  //     }
                  //   }),
                  // ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.data?.cRECEIVESHARECODE ?? "-",
                              style: textTheme.titleSmall,
                            ),
                            Text(
                              (widget.data?.canRegistered ?? false)
                                  ? "Có thể đăng ký"
                                  : "Không thể đăng ký",
                              style: textTheme.bodySmall!.copyWith(
                                  color: (widget.data?.canRegistered ?? false)
                                      ? AppColors.semantic_01
                                      : AppColors.semantic_03),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                stock?.nameShort ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.labelSmall_10
                                    .copyWith(color: AppColors.neutral_03),
                              ),
                            ),
                            // Expanded(
                            //   child: Container(
                            //     height: 4,
                            //     decoration: const BoxDecoration(
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(4)),
                            //       color: AppColors.neutral_06,
                            //     ),
                            //     child: Row(
                            //       children: [
                            //         Flexible(
                            //           flex: (widget.volPc ?? 0) ~/ 1,
                            //           child: Container(
                            //             height: 4,
                            //             decoration: const BoxDecoration(
                            //               borderRadius: BorderRadius.all(
                            //                   Radius.circular(4)),
                            //               color: AppColors.graph_7,
                            //             ),
                            //           ),
                            //         ),
                            //         Flexible(
                            //           flex: 100 - ((widget.volPc ?? 0) ~/ 1),
                            //           child: Container(),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Còn được mua / tiền phải nộp",
                          style: AppTextStyle.labelSmall_10
                              .copyWith(color: AppColors.neutral_01),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${NumUtils.formatInteger(widget.data?.cSHARERIGHT)}/${NumUtils.formatDouble(widget.data?.cCASHBUYALL)}",
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_03),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Ngày chốt",
                          style: AppTextStyle.labelSmall_10
                              .copyWith(color: AppColors.neutral_01),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.data?.cCLOSEDATE ?? "-",
                          style: AppTextStyle.labelMedium_12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ExpandedSection(
                expand: expand,
                child: Container(
                  height: 134,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: AppColors.neutral_06,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Expanded(
                              child: AssetGridElement(element: {
                                "Tỷ lệ": widget.data?.cRIGHTRATE
                                    ?.replaceAll("-", ":")
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(element: {
                                S.of(context).buy_price: NumUtils.formatDouble(
                                    widget.data?.cBUYPRICE)
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(element: {
                                "Số CKHQ": NumUtils.formatInteger(
                                    widget.data?.cSHAREVOLUME)
                              }),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Flexible(
                        child: Row(
                          children: [
                            Expanded(
                              child: AssetGridElement(element: {
                                "Hạn chốt ĐK": widget.data?.cCLOSEDATE,
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(element: {
                                "Số tiền đã nộp":
                                    NumUtils.formatDouble(widget.data?.cCASHBUY)
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(element: {
                                "Số CK đã ĐK": NumUtils.formatInteger(
                                    widget.data?.cSHAREBUY)
                              }),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 28,
                        child: Row(
                          children: [
                            Flexible(
                              child: SingleColorTextButton(
                                text: S.of(context).sign_up,
                                color: AppColors.graph_3,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                onTap: () {
                                  if (widget.data == null || stock == null) {
                                    return;
                                  }
                                  IExecuteRightSheet(widget.data!).show(
                                      context,
                                      ExecuteRightSheet(
                                        unexecutedRightModel: widget.data!,
                                        stock: stock!,
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(12)),
          child: InkWell(
            onTap: onTap,
            onLongPress: widget.onHold,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(12)),
            child: Ink(
              height: 16,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(12)),
                color: themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_05,
              ),
              child: Center(
                child: AnimatedRotation(
                  turns: expand ? -0.5 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    AppImages.arrow_drop_down_rounded,
                    width: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
