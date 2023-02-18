import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/logic/money_type.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/button/text_icon_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import 'asset_per_type_widget.dart';

class AccountAssetOverviewWidget extends StatefulWidget {
  const AccountAssetOverviewWidget({
    Key? key,
    this.asset = "200.000.000đ",
    this.percent = 85,
    this.data,
  }) : super(key: key);
  final BaseMarginAccountModel? data;
  final String asset;
  final double percent;

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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${NumUtils.formatDouble(widget.data?.equity, "-")}đ",
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.prefix_up_icon,
                        width: 10,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${NumUtils.formatDouble(widget.data?.portfolioStatus?.gainLossValue)} (${widget.data?.portfolioStatus?.gainLossPer?.trim()})",
                        style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.semantic_01),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextIconButton(
                      icon: AppImages.money_recive,
                      label: S.of(context).deposite_money,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextIconButton(
                      icon: AppImages.money_send,
                      label: S.of(context).withdraw_money,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              ExpandedSection(
                expand: expanded,
                child: AssetPerTypeWidget(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  values: [
                    MoneyType(
                        icon: AppImages.wallet_3,
                        label: S.of(context).net_assets,
                        value:
                            "${NumUtils.formatDouble(widget.data?.equity)} đ"),
                    // "${NumUtils.formatDouble((widget.data?.equity ?? 0) - (widget.data?.cashBalance ?? 0) - (widget.data?.debt ?? 0))} đ"),
                    MoneyType(
                        icon: AppImages.chart_2,
                        label: S.of(context).dividend,
                        value:
                            "${NumUtils.formatDouble(widget.data?.collateral)} đ"),
                    MoneyType(
                        icon: AppImages.money_2,
                        label: S.of(context).cash,
                        value:
                            "${NumUtils.formatDouble(widget.data?.cashBalance ?? 0)} đ"),
                    MoneyType(
                        icon: AppImages.money_change,
                        label: S.of(context).total_principal_debt,
                        value:
                            "${NumUtils.formatDouble(widget.data?.debt ?? 0)} đ"),
                    MoneyType(
                        icon: AppImages.timer_2,
                        label: S.of(context).minimum_ee,
                        value:
                            "${NumUtils.formatDouble(widget.data?.ee ?? 0)} đ"),
                    MoneyType(
                        icon: AppImages.chart_3,
                        label: S.of(context).safe_ratio,
                        value: NumUtils.formatDouble(
                            widget.data?.marginRatio ?? 0))
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 32,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 16,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(12)),
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Ink(
                      height: 32,
                      width: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: AppColors.primary_04,
                      ),
                      child: Center(
                        child: AnimatedRotation(
                          turns: expanded ? -0.5 : 0,
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset(
                            AppImages.arrow_drop_down_rounded,
                            width: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
