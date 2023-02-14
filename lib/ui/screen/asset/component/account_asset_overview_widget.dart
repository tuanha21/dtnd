import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/button/text_icon_button.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import 'asset_grid_element.dart';

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
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      height: 186,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Container(
            height: 106,
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
                          S.of(context).net_assets:
                              "${NumUtils.formatDouble(widget.data?.equity)}đ"
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: AssetGridElement(element: {
                          S.of(context).cash:
                              "${NumUtils.formatDouble(widget.data?.cashBalance)}đ"
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: AssetGridElement(element: {
                          "Sức mua tối thiểu":
                              "${NumUtils.formatDouble(widget.data?.ee)}đ"
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
                          S.of(context).dividend:
                              NumUtils.formatDouble(widget.data?.collateral),
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: AssetGridElement(element: {
                          S.of(context).total_principal_debt:
                              NumUtils.formatDouble(widget.data?.debt)
                        }),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: AssetGridElement(element: {
                          S.of(context).safe_ratio:
                              NumUtils.formatDouble(widget.data?.marginRatio)
                        }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
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
          )
        ],
      ),
    );
  }
}
