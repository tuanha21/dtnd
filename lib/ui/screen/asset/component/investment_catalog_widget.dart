import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/asset_catalog_ratio_chart.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/asset_stock_detail_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import 'asset_grid_element.dart';

class InvestmentCatalogWidget extends StatefulWidget {
  const InvestmentCatalogWidget({
    super.key,
    required this.data,
    this.onHold,
    this.onExpand,
    this.volPc,
  });
  final PorfolioStock? data;
  final double? volPc;
  final ValueChanged<PorfolioStock?>? onExpand;
  final VoidCallback? onHold;

  @override
  State<InvestmentCatalogWidget> createState() =>
      _InvestmentCatalogWidgetState();
}

class _InvestmentCatalogWidgetState extends State<InvestmentCatalogWidget> {
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
    getStock(widget.data?.symbol);
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
                    stockCode: widget.data?.symbol,
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
                            Row(
                              children: [
                                Text(
                                  widget.data?.symbol ?? "-",
                                  style: textTheme.titleSmall,
                                ),
                                const SizedBox(width: 8),
                                Text.rich(
                                  TextSpan(children: [
                                    WidgetSpan(
                                        child:
                                            widget.data?.prefixIcon(size: 12) ??
                                                const SizedBox()),
                                    TextSpan(
                                      text:
                                          " ${NumUtils.formatDouble(widget.data?.marketPrice)}",
                                    )
                                  ]),
                                  maxLines: 1,
                                  style: AppTextStyle.labelMedium_12.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: widget.data?.color,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox.square(
                              dimension: 32,
                              child: AssetCatalogRatioChart(
                                ratio: widget.volPc ?? 0,
                              ),
                            ),
                            // Text(
                            //   "${(widget.volPc ?? 0).toStringAsFixed(2)}%",
                            //   style: textTheme.bodySmall!
                            //       .copyWith(color: AppColors.neutral_04),
                            // ),
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
                          S.of(context).owned,
                          style: AppTextStyle.labelSmall_10
                              .copyWith(color: AppColors.neutral_01),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          NumUtils.formatDouble(widget.data?.actualVol),
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
                          "${S.of(context).profit_and_loss} (%)",
                          style: AppTextStyle.labelSmall_10
                              .copyWith(color: AppColors.neutral_01),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${NumUtils.formatDouble(widget.data?.gainLossValue)}đ (${widget.data?.gainLossPer?.trim()})",
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: widget.data?.color),
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
                  height: 88,
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
                                S.of(context).bought_returning:
                                    NumUtils.formatInteger(widget.data?.buyTVol)
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(element: {
                                S.of(context).avg_price:
                                    NumUtils.formatDouble(widget.data?.avgPrice)
                              }),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: AssetGridElement(element: {
                                S.of(context).bonus_sh: NumUtils.formatInteger(
                                    widget.data?.rightVol)
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
                                text: S.of(context).detail,
                                color: AppColors.neutral_04,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                onTap: () {
                                  if (widget.data != null) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          AssetStockDetailScreen(
                                        stockCode: widget.data!.symbol,
                                        porfolioStock: widget.data!,
                                      ),
                                    ));
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: SingleColorTextButton(
                                text: S.of(context).sell,
                                color: AppColors.semantic_03,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                onTap: () async {
                                  if (!UserService().isLogin) {
                                    final toLogin = await showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return const LoginFirstDialog();
                                      },
                                    );
                                    if (toLogin ?? false) {
                                      if (!mounted) return;
                                      await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ));
                                    }
                                  } else {
                                    final model = await dataCenterService
                                        .getStockModelsFromStockCodes(
                                            [stock!.stockCode]);
                                    if ((model?.isNotEmpty ?? false) &&
                                        mounted) {
                                      StockOrderISheet(model!.first).show(
                                          context,
                                          StockOrderSheet(
                                            stockModel: model.first,
                                            orderData: null,
                                          ));
                                    }
                                  }
                                },
                              ),
                            )
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
