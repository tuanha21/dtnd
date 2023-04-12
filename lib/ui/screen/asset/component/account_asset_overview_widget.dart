import 'package:dtnd/=models=/response/account/base_margin_plus_account_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

class AccountAssetOverviewWidget extends StatefulWidget {
  const AccountAssetOverviewWidget({
    Key? key,
    this.data,
  }) : super(key: key);
  final BaseMarginPlusAccountModel? data;

  @override
  State<AccountAssetOverviewWidget> createState() =>
      _AccountAssetOverviewWidgetState();
}

class _AccountAssetOverviewWidgetState
    extends State<AccountAssetOverviewWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            color: Colors.white,
          ),
          // height: 186,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).net_assets,
                        style: AppTextStyle.labelMedium_12.copyWith(
                          color: AppColors.neutral_03,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${NumUtils.formatDouble(widget.data?.totalEquity, "-")}đ",
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        S.of(context).profit_and_loss,
                        style: AppTextStyle.labelMedium_12.copyWith(
                          color: AppColors.neutral_03,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            widget.data?.portfolioStatus?.prefixIcon ??
                                AppImages.prefix_ref_icon,
                            width: 10,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${NumUtils.formatDouble(widget.data?.portfolioStatus?.gainLossValue)} (${widget.data?.portfolioStatus?.gainLossPer?.trim() ?? "-"})",
                            style: textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: widget.data?.portfolioStatus?.color ??
                                    AppColors.semantic_02),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 33),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       child: TextIconButton(
              //         icon: AppImages.money_recive,
              //         label: S.of(context).deposite_money,
              //       ),
              //     ),
              //     const SizedBox(width: 10),
              //     Expanded(
              //       child: TextIconButton(
              //         icon: AppImages.money_send,
              //         label: S.of(context).withdraw_money,
              //       ),
              //     )
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: _ExpandableRow(
                  icon: Image.asset(AppImages.simple_line_chart_icon),
                  text: S.of(context).stock_value,
                  value: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: const BoxDecoration(
                      color: AppColors.accent_light_01,
                      borderRadius: BorderRadius.all(Radius.circular(56)),
                    ),
                    child: Text(
                      S.of(context).trading,
                      style: AppTextStyle.labelSmall_10.copyWith(
                          color: AppColors.semantic_01,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 24, right: 8, top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppColors.neutral_06,
                      ),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Quản trị rủi ro",
                                style: AppTextStyle.labelSmall_10,
                              ),
                              // Text(
                              //     "${NumUtils.formatInteger(widget.data?.cashBalance ?? 0)}đ",
                              //     style: textTheme.labelMedium!
                              //         .copyWith(fontWeight: FontWeight.w600))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 80,
                                width: 2,
                                color: const Color(0xFFD8EBFD),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Giá trị vay",
                                          style: AppTextStyle.labelSmall_10
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                            "${NumUtils.formatInteger(widget.data?.lmv ?? 0)}đ",
                                            style: textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600))
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Lãi vay",
                                          style: AppTextStyle.labelSmall_10
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                            "${NumUtils.formatInteger(widget.data?.loanFee ?? 0)}đ",
                                            style: textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600))
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tỷ lệ an toàn",
                                          style: AppTextStyle.labelSmall_10
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                            NumUtils.formatInteger(
                                                widget.data?.marginRatio ?? 0),
                                            style: textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Giá trị danh mục",
                                style: AppTextStyle.labelSmall_10,
                              ),
                              Text(
                                  "${NumUtils.formatInteger(widget.data?.totalMarket ?? 0)}đ",
                                  style: textTheme.labelMedium!
                                      .copyWith(fontWeight: FontWeight.w600))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: _ExpandableRow(
                  icon: Image.asset(AppImages.wallet_3),
                  text: S.of(context).total_cash,
                  value: Text(
                    "${NumUtils.formatInteger(widget.data?.cashBalance ?? 0)}đ",
                    style: textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 24, right: 8, top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppColors.neutral_06,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).cash,
                                style: AppTextStyle.labelSmall_10,
                              ),
                              Text(
                                  "${NumUtils.formatInteger(widget.data?.cashBalance ?? 0)}đ",
                                  style: textTheme.labelMedium!
                                      .copyWith(fontWeight: FontWeight.w600))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 56,
                                width: 2,
                                color: const Color(0xFFD8EBFD),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          S.of(context).purchasing_ability,
                                          style: AppTextStyle.labelSmall_10
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                            "${NumUtils.formatInteger(widget.data?.ee ?? 0)}đ",
                                            style: textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600))
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tiền tạm giữ",
                                          style: AppTextStyle.labelSmall_10
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        Text("0đ",
                                            style: textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).returning_money,
                                style: AppTextStyle.labelSmall_10,
                              ),
                              Text(
                                  // (widget.data?.apT0 + widget.data?.apT1 + widget.data?.apT2),
                                  "${NumUtils.formatInteger( (widget.data?.apT0 ?? 0) + (widget.data?.apT1 ?? 0) + (widget.data?.apT2 ?? 0))}đ",
                                  style: textTheme.labelMedium!
                                      .copyWith(fontWeight: FontWeight.w600))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: _ExpandableRow(
                  icon: Image.asset(AppImages.chart_star_icon),
                  text: S.of(context).accumulation,
                  value: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: const BoxDecoration(
                      color: AppColors.accent_light_02,
                      borderRadius: BorderRadius.all(Radius.circular(56)),
                    ),
                    child: Text(
                      S.of(context).accumulation,
                      style: AppTextStyle.labelSmall_10.copyWith(
                          color: AppColors.graph_4,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              // ExpandedSection(
              //   expand: expanded,
              //   child: AssetPerTypeWidget(
              //     // margin: const EdgeInsets.symmetric(vertical: 12),
              //     values: [
              //       MoneyType(
              //           icon: AppImages.wallet_3,
              //           label: S.of(context).net_assets,
              //           value:
              //               "${NumUtils.formatDouble(widget.data?.equity)} đ"),
              //       // "${NumUtils.formatDouble((widget.data?.equity ?? 0) - (widget.data?.cashBalance ?? 0) - (widget.data?.debt ?? 0))} đ"),
              //       MoneyType(
              //           icon: AppImages.chart_2,
              //           label: S.of(context).dividend,
              //           value:
              //               "${NumUtils.formatDouble(widget.data?.collateral)} đ"),
              //       MoneyType(
              //           icon: AppImages.money_2,
              //           label: S.of(context).cash,
              //           value:
              //               "${NumUtils.formatDouble(widget.data?.cashBalance ?? 0)} đ"),
              //       MoneyType(
              //           icon: AppImages.money_change,
              //           label: S.of(context).total_principal_debt,
              //           value:
              //               "${NumUtils.formatDouble(widget.data?.debt ?? 0)} đ"),
              //       MoneyType(
              //           icon: AppImages.timer_2,
              //           label: S.of(context).minimum_ee,
              //           value:
              //               "${NumUtils.formatDouble(widget.data?.ee ?? 0)} đ"),
              //       MoneyType(
              //           icon: AppImages.chart_3,
              //           label: S.of(context).safe_ratio,
              //           value: NumUtils.formatDouble(
              //               widget.data?.marginRatio ?? 0))
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExpandableRow extends StatefulWidget {
  const _ExpandableRow({
    required this.icon,
    required this.text,
    required this.value,
    this.child,
  });

  final Widget icon;
  final String text;
  final Widget value;
  final Widget? child;

  @override
  State<_ExpandableRow> createState() => __ExpandableRowState();
}

class __ExpandableRowState extends State<_ExpandableRow> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Ink(
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 32,
                    child: widget.icon,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          widget.text,
                          style: textTheme.labelMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 8),
                        Center(
                          child: AnimatedRotation(
                            turns: expanded ? -0.5 : 0,
                            duration: const Duration(milliseconds: 500),
                            child: SizedBox.square(
                              dimension: 10,
                              child: Image.asset(
                                AppImages.arrow_drop_down_rounded,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.value,
                ],
              ),
            ),
          ),
        ),
        if (widget.child != null)
          ExpandedSection(expand: expanded, child: widget.child!),
      ],
    );
  }
}
// expand more widget
// SizedBox(
//           height: 32,
//           child: Stack(
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   height: 16,
//                   decoration: const BoxDecoration(
//                     borderRadius:
//                         BorderRadius.vertical(bottom: Radius.circular(12)),
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Material(
//                   borderRadius: const BorderRadius.all(Radius.circular(12)),
//                   child: InkWell(
//                     onTap: () {
//                       setState(() {
//                         expanded = !expanded;
//                       });
//                     },
//                     borderRadius: const BorderRadius.all(Radius.circular(12)),
//                     child: Ink(
//                       height: 32,
//                       width: 120,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(12)),
//                         color: AppColors.primary_04,
//                       ),
//                       child: Center(
//                         child: AnimatedRotation(
//                           turns: expanded ? -0.5 : 0,
//                           duration: const Duration(milliseconds: 500),
//                           child: Image.asset(
//                             AppImages.arrow_drop_down_rounded,
//                             width: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
