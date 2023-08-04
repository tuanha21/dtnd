import 'package:flutter/material.dart';
import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/asset_catalog_ratio_chart.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/asset_stock_detail_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/utilities/num_utils.dart';

class InvestmentCatalogWidget extends StatefulWidget {
  const InvestmentCatalogWidget({
    super.key,
    required this.data,
    this.onHold,
    this.onExpand,
    this.volPc,
    required this.showFullMode,
  });
  final PorfolioStock? data;
  final double? volPc;
  final ValueChanged<PorfolioStock?>? onExpand;
  final VoidCallback? onHold;
  final bool showFullMode;
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
    final stocks = dataCenterService.getStocksFromStockCodes([stockCode]);
    if (stocks.isNotEmpty) {
      setState(() {
        stock = stocks.first;
      });
    }
  }

  @override
  void didUpdateWidget(covariant InvestmentCatalogWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.showFullMode != widget.showFullMode) {
      getStock(widget.data?.symbol);
    }
  }

  void changeMode() {}

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: InkWell(
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                color: themeMode.isDark ? AppColors.text_black_1 : AppColors.neutral_06,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        StockIcon(
                          color: Colors.white,
                          stockCode: widget.data?.symbol,
                        ),
                        // const SizedBox(width: 2),
                        // SizedBox(
                        //   width: 40,
                        //   child: Text(
                        //     widget.data?.symbol ?? "-",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .titleSmall!
                        //         .copyWith(fontWeight: FontWeight.w600),
                        //   ),
                        // ),
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
                          child: Stack(
                            children: [
                              AnimatedOpacity(
                                opacity: expand ? 1 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  widget.data?.symbol ?? "-",
                                                  style: textTheme.titleSmall?.copyWith(color: themeMode.isLight ? null : AppColors.neutral_07),
                                                ),
                                                const SizedBox(width: 8),
                                                Text.rich(
                                                  TextSpan(children: [
                                                    WidgetSpan(
                                                        child: widget.data
                                                                ?.prefixIcon(
                                                                    size: 12) ??
                                                            const SizedBox()),
                                                    TextSpan(
                                                      text:
                                                          " ${NumUtils.formatDouble(widget.data?.marketPrice)}",
                                                    )
                                                  ]),
                                                  maxLines: 1,
                                                  style: AppTextStyle
                                                      .labelMedium_12
                                                      .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: widget.data?.color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    stock?.nameShort ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyle
                                                        .labelSmall_10
                                                        .copyWith(
                                                            color: AppColors
                                                                .neutral_03),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Text(
                                            //   "${(widget.volPc ?? 0).toStringAsFixed(2)}%",
                                            //   style: textTheme.bodySmall!
                                            //       .copyWith(color: AppColors.neutral_04),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      SizedBox.square(
                                        dimension: 32,
                                        child: AssetCatalogRatioChart(
                                          ratio: widget.volPc ?? 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: expand ? 0 : 1,
                                duration: const Duration(milliseconds: 200),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 2, bottom: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            S.of(context).stock_code,
                                            style: AppTextStyle.labelSmall_10
                                                .copyWith(
                                                    color:
                                                        themeMode.isLight ? AppColors.neutral_01 : AppColors.neutral_07),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            widget.data?.symbol ?? "-",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600,color: themeMode.isLight ? null : AppColors.neutral_07),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            S.of(context).avg_price,
                                            style: AppTextStyle.labelSmall_10,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            NumUtils.formatDouble(
                                                widget.data?.avgPrice),
                                            style: AppTextStyle.labelMedium_12
                                                .copyWith(
                                                    color: widget.data?.color),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            S.of(context).mk_price,
                                            style: AppTextStyle.labelSmall_10,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            NumUtils.formatDouble(
                                                widget.data?.marketPrice),
                                            style: AppTextStyle.labelMedium_12
                                                .copyWith(
                                                    color: widget.data?.color),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${S.of(context).profit_and_loss} (%)",
                                            style: AppTextStyle.labelSmall_10,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                widget.data?.gainLossPer ?? "-",
                                                style: AppTextStyle
                                                    .labelMedium_12
                                                    .copyWith(
                                                        color: themeMode.isLight ? AppColors
                                                            .neutral_03 : AppColors.neutral_07),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ExpandedSection(
                    expand: expand,
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(4),
                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: themeMode.isLight ? AppColors.neutral_06 : AppColors.text_black_1,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).owned,
                                      style: AppTextStyle.labelSmall_10
                                          .copyWith(
                                              color: themeMode.isLight ? AppColors.neutral_01 : AppColors.neutral_07),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      NumUtils.formatInteger(
                                          widget.data?.actualVol),
                                      style: AppTextStyle.labelMedium_12
                                          .copyWith(
                                              color: themeMode.isLight ? AppColors.neutral_03 : AppColors.neutral_07 ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      S.of(context).mk_value,
                                      style: AppTextStyle.labelSmall_10,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      NumUtils.formatInteger(
                                          widget.data?.marketValue),
                                      style: AppTextStyle.labelMedium_12
                                          .copyWith(color: widget.data?.color),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      S.of(context).profit_and_loss,
                                      style: AppTextStyle.labelSmall_10
                                          .copyWith(
                                              color: themeMode.isLight ? AppColors.neutral_01 : AppColors.neutral_07),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      NumUtils.formatDouble(
                                          widget.data?.gainLossValue),
                                      style: AppTextStyle.labelMedium_12
                                          .copyWith(color: widget.data?.color),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
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
                color: themeMode.isDark ? AppColors.text_black_1 : AppColors.neutral_05,
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
        themeMode.isDark ? const Divider(height: 10,color: AppColors.bg_1,) :const SizedBox()
      ],
    );
  }
}
