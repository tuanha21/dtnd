import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/top_signal_detail_model.dart';
import 'package:dtnd/=models=/response/top_signal_stock_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignalOverview extends StatefulWidget {
  const SignalOverview({super.key, required this.data, this.detail});
  final TopSignalStockModel data;
  final TopSignalDetailModel? detail;
  @override
  State<SignalOverview> createState() => _SignalOverviewState();
}

class _SignalOverviewState extends State<SignalOverview> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final stockData = widget.data.stockModel.stockData;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.data.prefixIcon(size: 28),
              const SizedBox(width: 10),
              Text(
                widget.data.cSELLPRICE.toString(),
                style: AppTextStyle.headlineSmall_24
                    .copyWith(color: widget.data.color),
              ),
              // const SizedBox(width: 10),
              // Text(
              //   "${NumUtils.formatInteger10(stockData.lot.value)} CP",
              //   style: AppTextStyle.labelMedium_12
              //       .copyWith(color: AppColors.neutral_03),
              // ),
            ],
          ),
          const SizedBox(height: 14),
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
                      TimeUtilities.commonTimeFormat
                          .format(widget.data.cBUYDATE),
                      style: AppTextStyle.labelSmall_10),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Loại tín hiệu",
                    style: AppTextStyle.labelSmall_10.copyWith(
                        color: AppColors.neutral_03,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  Text(widget.data.cTYPE ?? "-",
                      style: AppTextStyle.labelSmall_10),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: const BoxDecoration(
              color: AppColors.neutral_06,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Column(
                  "Giá mua",
                  widget.data.cBUYPRICE.toString(),
                  textStyle: textTheme.titleSmall,
                ),
                const VerticalDivider(
                  thickness: 1,
                  width: 1,
                ),
                _Column(
                  "Lợi nhuận",
                  "${widget.data.cPC}%",
                  textStyle: textTheme.titleSmall,
                ),
                const VerticalDivider(
                  thickness: 1,
                  width: 1,
                ),
                _Column(
                  "Rủi ro",
                  "${widget.detail?.rUIRO ?? "-"}%",
                  textStyle: textTheme.titleSmall,
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
