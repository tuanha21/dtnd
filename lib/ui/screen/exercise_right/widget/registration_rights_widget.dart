import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utilities/time_utils.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_textstyle.dart';

class RegistrationRightsWidget extends StatefulWidget {
  const RegistrationRightsWidget({super.key, required this.data});

  final UnexecutedRightModel? data;

  @override
  State<RegistrationRightsWidget> createState() =>
      _RegistrationRightsWidgetState();
}

class _RegistrationRightsWidgetState extends State<RegistrationRightsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: AppColors.neutral_06,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.data?.cSHARECODE.toString() ?? '',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: AppColors.text_black_1),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).registration_time,
                style: AppTextStyle.labelMedium_12
                    .copyWith(color: AppColors.neutral_03),
              ),
              Text(
                TimeUtilities.commonTimeFormat
                    .format(
                      DateFormat("MM/dd/yyyy HH:mm:ss")
                          .parse(widget.data?.cCREATEDATE ?? ''),
                    )
                    .toString(),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                    color: AppColors.text_black_1),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).registered_share_volume,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(NumUtils.formatDouble(widget.data?.cSHAREBUY),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: AppColors.text_black_1))
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).purchase_price,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text("${NumUtils.formatInteger(widget.data?.cBUYPRICE ?? 0)} đ",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: AppColors.text_black_1)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).amount_paid,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text('${NumUtils.formatDouble(widget.data?.cCASHBUY)} đ',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: AppColors.text_black_1))
            ],
          ),
        ],
      ),
    );
  }
}
