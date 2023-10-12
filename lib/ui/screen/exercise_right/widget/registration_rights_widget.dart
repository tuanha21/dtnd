import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';
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
    final themeMode = AppService.instance.themeMode.value;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color:
              themeMode.isLight ? AppColors.neutral_06 : AppColors.neutral_01,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.data?.cSHARECODE.toString() ?? '',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: themeMode.isLight
                        ? AppColors.text_black_1
                        : AppColors.neutral_07),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).registration_time,
                style: AppTextStyle.labelMedium_12.copyWith(
                    color: themeMode.isLight
                        ? AppColors.neutral_03
                        : AppColors.neutral_07),
              ),
              Text(
                TimeUtilities.commonTimeFormat.format(TimeUtilities
                    .commonTimeFormat
                    .parse(widget.data?.cCREATEDATE ?? '')),
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                    color: themeMode.isLight
                        ? AppColors.text_black_1
                        : AppColors.neutral_07),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).registered_share_volume,
                  style: AppTextStyle.labelMedium_12.copyWith(
                      color: themeMode.isLight
                          ? AppColors.neutral_03
                          : AppColors.neutral_07)),
              Text(NumUtils.formatDouble(widget.data?.cSHAREBUY),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: themeMode.isLight
                          ? AppColors.text_black_1
                          : AppColors.neutral_07))
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).purchase_price,
                  style: AppTextStyle.labelMedium_12.copyWith(
                      color: themeMode.isLight
                          ? AppColors.neutral_03
                          : AppColors.neutral_07)),
              Text("${NumUtils.formatInteger(widget.data?.cBUYPRICE ?? 0)} đ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: themeMode.isLight
                          ? AppColors.text_black_1
                          : AppColors.neutral_07)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).amount_paid,
                  style: AppTextStyle.labelMedium_12.copyWith(
                      color: themeMode.isLight
                          ? AppColors.neutral_03
                          : AppColors.neutral_07)),
              Text('${NumUtils.formatDouble(widget.data?.cCASHBUY)} đ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: themeMode.isLight
                          ? AppColors.text_black_1
                          : AppColors.neutral_07))
            ],
          ),
        ],
      ),
    );
  }
}
