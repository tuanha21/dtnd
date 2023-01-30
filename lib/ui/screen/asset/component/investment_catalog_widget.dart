import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/logic/investment_catalog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestmentCatalogWidget extends StatefulWidget {
  const InvestmentCatalogWidget({
    super.key,
    required this.data,
    this.onHold,
    this.onExpand,
  });
  final InvestmentCatalog data;
  final ValueChanged<InvestmentCatalog>? onExpand;
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
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_07,
              ),
              child: Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Center(
                        child: ClipOval(
                          child: SizedBox.square(
                            dimension: 40.0,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://info.sbsi.vn/logo/${widget.data.stockModel.stock.stockCode}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.scaleDown),
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
                            children: [
                              Text(
                                widget.data.stockModel.stock.stockCode,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 8),
                              Obx(
                                () {
                                  return Text.rich(
                                    TextSpan(children: [
                                      WidgetSpan(
                                          child: widget
                                              .data.stockModel.stockData
                                              .prefixIcon(size: 12)),
                                      TextSpan(
                                        text:
                                            " ${widget.data.stockModel.stockData.lastPrice}",
                                      )
                                    ]),
                                    maxLines: 1,
                                    style: AppTextStyle.labelMedium_12.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: widget
                                          .data.stockModel.stockData.color,
                                    ),
                                  );
                                },
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
                                        flex: 1,
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
                                        flex: 4,
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
        const SizedBox(height: 8),
        ExpandedSection(
            expand: expand,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.neutral_06,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _GridElement(element: {
                          S.of(context).capital_value: widget.data.capitalValue
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: _GridElement(element: {
                          S.of(context).mk_value: widget.data.marketValue
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: _GridElement(element: {
                          S.of(context).available_balanc:
                              NumUtils.formatInteger(
                                  widget.data.availableBalance)
                        }),
                      )
                    ],
                  ),
                  const SizedBox(height: 2),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _GridElement(
                            element: {S.of(context).volumn: null},
                            subElements: {
                              S.of(context).total_vol: NumUtils.formatInteger(
                                  widget.data.totalVolumn),
                              S.of(context).normal_vol: NumUtils.formatInteger(
                                  widget.data.normalVolumn),
                              S.of(context).fs_vol:
                                  NumUtils.formatInteger(widget.data.fsVolumn),
                            },
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _GridElement(element: {
                                      S.of(context).available_vol:
                                          NumUtils.formatInteger(
                                              widget.data.availableVolumn)
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Expanded(
                                    child: _GridElement(element: {
                                      S.of(context).other_vol:
                                          NumUtils.formatInteger(
                                              widget.data.otherVolumn)
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: _GridElement(
                            element: {S.of(context).sold_returning_vol: null},
                            subElements: {
                              "T0": NumUtils.formatInteger(widget.data.t0),
                              "T1": NumUtils.formatInteger(widget.data.t1),
                              "T2": NumUtils.formatInteger(widget.data.t2),
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class _GridElement extends StatelessWidget {
  const _GridElement({
    required this.element,
    this.subElements,
  });
  final Map<String, String?> element;
  final Map<String, String>? subElements;
  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextStyle.labelSmall_10;
    final labelTheme = textTheme.copyWith(color: AppColors.neutral_03);
    bool hasSubElements = (subElements != null);
    List<Widget> child;
    if (hasSubElements) {
      child = [];
      for (var i = 0; i < subElements!.keys.length; i++) {
        child.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subElements!.keys.toList().elementAt(i),
              style: labelTheme,
            ),
            Text(
              subElements!.values.toList().elementAt(i),
              style: textTheme,
            ),
          ],
        ));
      }
    } else {
      child = [
        Text(
          element.values.toList().first!,
          style: textTheme,
        ),
      ];
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            element.keys.toList().first,
            style: labelTheme,
          ),
          ...child,
        ],
      ),
    );
  }
}
