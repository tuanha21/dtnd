import 'package:dtnd/=models=/response/order_history_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

class UnclosedDealElement extends StatefulWidget {
  const UnclosedDealElement({super.key, required this.model});
  final OrderHistoryModel model;
  @override
  State<UnclosedDealElement> createState() => _UnclosedDealElementState();
}

class _UnclosedDealElementState extends State<UnclosedDealElement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox.square(
                    dimension: 20, child: Image.asset(AppImages.calendar_2)),
                const SizedBox(width: 8),
                Text(widget.model.cORDERDATE ?? "-"),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).volumn,
                  style: AppTextStyle.labelSmall_10.copyWith(
                    color: AppColors.neutral_03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  NumUtils.formatInteger(widget.model.cORDERVOLUME ?? 0),
                  style: AppTextStyle.labelSmall_10,
                )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Text(
                  "Giá khớp",
                  style: AppTextStyle.labelSmall_10.copyWith(
                    color: AppColors.neutral_03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  NumUtils.formatDouble((widget.model.cMATCHPRICE ?? 0) / 1000),
                  style: AppTextStyle.labelSmall_10,
                )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Text(
                  "Phí GD",
                  style: AppTextStyle.labelSmall_10.copyWith(
                    color: AppColors.neutral_03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  NumUtils.formatInteger(widget.model.cFEEVALUE ?? 0),
                  style: AppTextStyle.labelSmall_10,
                )
              ],
            )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "KL khớp",
                  style: AppTextStyle.labelSmall_10.copyWith(
                    color: AppColors.neutral_03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  NumUtils.formatInteger((widget.model.cMATCHVOL ?? 0)),
                  style: AppTextStyle.labelSmall_10,
                )
              ],
            ))
          ],
        ),
      ],
    );
  }
}
