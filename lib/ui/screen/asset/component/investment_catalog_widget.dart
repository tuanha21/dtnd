import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/asset_stock_detail_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
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
  bool expand = false;

  void onTap() {
    setState(() {
      expand = !expand;
    });
    if (expand) {
      widget.onExpand?.call(widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    return Column(
      children: [
        Material(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: InkWell(
            onTap: onTap,
            onLongPress: widget.onHold,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Ink(
              // alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_07,
              ),
              child: Center(
                child: Row(
                  children: [
                    StockIcon(stockCode: widget.data?.symbol),

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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 8),
                                  Text.rich(
                                    TextSpan(children: [
                                      WidgetSpan(
                                          child: widget.data
                                                  ?.prefixIcon(size: 12) ??
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
                              Text(
                                widget.data?.gainLossPer ?? "-",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.neutral_04),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    color: AppColors.neutral_06,
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: (widget.volPc ?? 0) ~/ 1,
                                        child: Container(
                                          height: 4,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            color: AppColors.graph_7,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 100 - ((widget.volPc ?? 0) ~/ 1),
                                        child: Container(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // const SizedBox(height: 8),
        ExpandedSection(
          expand: expand,
          child: Container(
            height: 146,
            padding: const EdgeInsets.all(8),
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
                          S.of(context).capital_value:
                              "${NumUtils.formatDouble(widget.data?.capitalValue)}đ"
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: AssetGridElement(element: {
                          S.of(context).mk_value:
                              "${NumUtils.formatDouble(widget.data?.marketValue)}đ"
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: AssetGridElement(element: {
                          S.of(context).profit_and_loss:
                              NumUtils.formatDouble(widget.data?.gainLossValue)
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
                          S.of(context).volumn:
                              NumUtils.formatInteger(widget.data?.actualVol),
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: AssetGridElement(element: {
                          S.of(context).available_vol:
                              NumUtils.formatInteger(widget.data?.avaiableVol)
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: AssetGridElement(element: {
                          S.of(context).sold_returning_vol:
                              NumUtils.formatInteger(widget.data?.buyTVol)
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
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        onTap: () {
                          if (widget.data != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AssetStockDetailScreen(
                                stockCode: widget.data!.symbol,
                                porfolioStock: widget.data!,
                              ),
                            ));
                          }
                        },
                      )),
                      const SizedBox(width: 8),
                      Flexible(
                          child: SingleColorTextButton(
                        text: S.of(context).sell,
                        color: AppColors.semantic_03,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        onTap: () {},
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
