import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_textstyle.dart';

class RightsInfoWidget extends StatefulWidget {
  const RightsInfoWidget(
      {super.key, required this.data, this.onChange, this.onCancel});

  final UnexecutedRightModel? data;
  final VoidCallback? onChange;
  final VoidCallback? onCancel;

  @override
  State<RightsInfoWidget> createState() => _RightsInfoWidgetState();
}

class _RightsInfoWidgetState extends State<RightsInfoWidget> {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).rights_type,
                  style: AppTextStyle.labelMedium_12),
              Text(widget.data?.cRIGHTTYPENAME.toString() ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: AppColors.text_black_1))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).stk_code,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cSHARECODE.toString() ?? '',
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
              Text(S.of(context).number_of_shares_entitled,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cRIGHTVOLUME.toString() ?? '',
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
              Text(S.of(context).ratio,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cRIGHTRATE.toString() ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: AppColors.text_black_1))
            ],
          ),
          const SizedBox(height: 8),
          widget.data?.cRIGHTTYPENAME.toString() == "Quyền mua cổ phiếu/TP"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).purchased_stock_code,
                            style: AppTextStyle.labelMedium_12
                                .copyWith(color: AppColors.neutral_03)),
                        Text(widget.data?.cRECEIVESHARECODE.toString() ?? '',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                                color: AppColors.text_black_1))
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                )
              : const SizedBox(),
          widget.data?.cRIGHTTYPENAME.toString() == "Quyền mua cổ phiếu/TP"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).remaining_shares_available_for_purchase,
                            style: AppTextStyle.labelMedium_12
                                .copyWith(color: AppColors.neutral_03)),
                        Text(
                            ((NumUtils.formatDouble(widget.data?.cSHARERIGHT ??
                                0 -
                                    (widget.data?.cSHAREBUY ?? 0) /
                                        (widget.data?.cSHARERIGHT ?? 0)))),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                                color: AppColors.text_black_1))
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                )
              : const SizedBox(),
          widget.data?.cRIGHTTYPENAME.toString() == "Quyền mua cổ phiếu/TP"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).purchase_price,
                            style: AppTextStyle.labelMedium_12
                                .copyWith(color: AppColors.neutral_03)),
                        Text(
                            "${NumUtils.formatInteger(widget.data?.cBUYPRICE ?? 0)} đ",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                                color: AppColors.text_black_1)),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).amount_received,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(
                widget.data?.cCASHVOLUME.toString() ?? '',
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
              Text(S.of(context).number_of_shares_received,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cSHARERIGHT.toString() ?? '',
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
              Text(S.of(context).received_stock_code,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cRECEIVESHARECODE ?? '',
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
              Text(S.of(context).quantity_of_rights_received,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cSHARERIGHT.toString() ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: AppColors.text_black_1))
            ],
          ),
          const SizedBox(height: 8),
          widget.data?.cRIGHTTYPENAME.toString() == "Quyền mua cổ phiếu/TP"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).registration_closing_date,
                            style: AppTextStyle.labelMedium_12
                                .copyWith(color: AppColors.neutral_03)),
                        Text(widget.data?.cREGISTERTODATE ?? '',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                                color: AppColors.text_black_1))
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).planned_execution_date,
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cEXECUTEDATE ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      color: AppColors.text_black_1))
            ],
          ),
          const SizedBox(height: 16),
          (widget.data?.cFLAG == 1 &&
                  ((widget.data?.cSHAREBUY ?? 0) <
                      (widget.data?.cSHARERIGHT ?? 0)))
              ? Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: widget.onChange,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppColors.color_primary_1,
                          ),
                          child: Text(
                            S.of(context).sign_up,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.light_bg),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
