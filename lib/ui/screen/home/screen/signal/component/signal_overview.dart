import 'package:dtnd/=models=/response/top_signal_detail_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

class SignalOverview extends StatelessWidget {
  const SignalOverview({super.key, this.detail});

  final TopSignalDetailModel? detail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: themeMode.isLight ? Colors.white : AppColors.text_black_1,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              detail?.prefixIcon(size: 28) ?? Container(),
              const SizedBox(width: 10),
              Text(
                detail?.cSELLPRICE?.toString() ?? "-",
                style: AppTextStyle.headlineSmall_24
                    .copyWith(color: detail?.color),
              ),
              // const SizedBox(width: 10),
              // Text(
              //   "${NumUtils.formatInteger10(stockData.lot.value)} CP",
              //   style: AppTextStyle.labelMedium_12
              //       .copyWith(color: AppColors.neutral_03),
              // ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).buy_date,
                    style: AppTextStyle.labelSmall_10.copyWith(
                        color: AppColors.neutral_03,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  Text(
                      detail?.cBUYDATE != null
                          ? TimeUtilities.commonTimeFormat
                              .format(detail!.cBUYDATE!)
                          : "-",
                      style: AppTextStyle.labelSmall_10),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).signal_type,
                    style: AppTextStyle.labelSmall_10.copyWith(
                        color: AppColors.neutral_03,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  Text(detail?.cTYPE ?? "-", style: AppTextStyle.labelSmall_10),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: themeMode.isLight ? AppColors.neutral_06 : AppColors.bg_share_inside_nav,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Column(
                  S.of(context).purchase_price,
                  detail?.cBUYPRICE.toString() ?? "-",
                  textStyle: textTheme.titleSmall?.copyWith(color: themeMode.isLight ? null : AppColors.neutral_07),
                ),
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: themeMode.isLight ? null : AppColors.neutral_03,
                ),
                _Column(
                  S.of(context).profit_value,
                  "${detail?.cPC ?? "-"}%",
                  textStyle: textTheme.titleSmall?.copyWith(color: themeMode.isLight ? null : AppColors.neutral_07),
                ),
                  VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: themeMode.isLight ? null : AppColors.neutral_03,
                ),
                _Column(
                  S.of(context).risk,
                  "${detail?.rUIRO ?? "-"}%",
                  textStyle: textTheme.titleSmall?.copyWith(color: themeMode.isLight ? null : AppColors.neutral_07),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Column extends StatelessWidget {
  const _Column(this.label, this.value, {this.textStyle});

  final String label;
  final String value;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style:
              AppTextStyle.labelMedium_12.copyWith(color: AppColors.neutral_03),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textStyle ?? Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }
}
