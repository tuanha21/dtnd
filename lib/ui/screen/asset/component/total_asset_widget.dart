import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/button/text_icon_button.dart';
import 'package:dtnd/ui/widget/chart/circle_process_chart.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/account/base_margin_plus_account_model.dart';

enum TotalAssetWidgetType {
  white,
  withBackGround,
}

extension TotalAssetWidgetTypeX on TotalAssetWidgetType {
  bool get hasBG => this == TotalAssetWidgetType.withBackGround;
}

class TotalAssetWidget extends StatefulWidget {
  const TotalAssetWidget({
    Key? key,
    this.type = TotalAssetWidgetType.white,
    this.asset = "200.000.000đ",
    this.percent = 85,
    this.data,
  }) : super(key: key);
  final BaseMarginPlusAccountModel? data;
  final TotalAssetWidgetType type;
  final String asset;
  final double percent;

  @override
  State<TotalAssetWidget> createState() => _TotalAssetWidgetState();
}

class _TotalAssetWidgetState extends State<TotalAssetWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Widget processChart = Container();
    if (widget.type.hasBG) {
      processChart = Center(
        child: SizedBox.square(
          dimension: 40,
          child: CircleProcessChart(
            percent: widget.percent,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
        image: widget.type.hasBG
            ? const DecorationImage(
                image: AssetImage(AppImages.wallet_bg), fit: BoxFit.fitWidth)
            : null,
      ),
      height: 124,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: widget.type.hasBG
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.data != null
                        ? "${NumUtils.formatDouble(widget.data!.equity ?? 0)}đ"
                        : widget.asset,
                    style: textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: widget.type.hasBG ? Colors.white : null),
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
                        "2,108.63 (0.92%)",
                        style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.semantic_01),
                      ),
                    ],
                  ),
                ],
              ),
              processChart
            ],
          ),
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
