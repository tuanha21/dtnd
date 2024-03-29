import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/account/unexecuted_right_model.dart';
import '../../../../config/service/app_services.dart';
import '../../../../l10n/generated/l10n.dart';
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
          widget.data?.cBUSINESSNAME == "Quyền mua cổ phiếu/TP"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.data?.cSHARECODE.toString() ?? '',
                        style: AppTextStyle.bodyMedium_14),
                    (widget.data?.cFLAG == 1 &&
                            ((widget.data?.cSHAREBUY ?? 0) <
                                (widget.data?.cSHARERIGHT ?? 0)))
                        ? InkWell(
                            onTap: widget.onChange,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: AppColors.color_primary_1,
                              ),
                              child: Text(
                                S.of(context).sign_up,
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.light_bg),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                )
              : const SizedBox(),
          widget.data?.cBUSINESSNAME != "Quyền mua cổ phiếu/TP"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.data?.cSHARECODE.toString() ?? '',
                        style: AppTextStyle.bodyMedium_14),
                    Text(widget.data?.cBUSINESSNAME.toString() ?? '',
                        style: AppTextStyle.bodyMedium_14),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).number_of_shares_entitled,
                  style: AppTextStyle.labelMedium_12.copyWith(
                      color: themeMode.isLight
                          ? AppColors.neutral_03
                          : AppColors.neutral_07)),
              Text(NumUtils.formatInteger(widget.data?.cSHAREVOLUME ?? 0),
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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).ratio,
                      style: AppTextStyle.labelMedium_12.copyWith(
                          color: themeMode.isLight
                              ? AppColors.neutral_03
                              : AppColors.neutral_07)),
                  Text(
                      widget.data?.cBUSINESSCODE == "RIGHT_DIVIDEND"
                          ? "${NumUtils.formatInteger(widget.data?.cCASHRECEIVERATE ?? 0)}%"
                          : widget.data?.cRIGHTRATE ?? '',
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
            ],
          ),
          widget.data?.cBUSINESSCODE == "RIGHT_BUY"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).purchased_stock_code,
                            style: AppTextStyle.labelMedium_12.copyWith(
                                color: themeMode.isLight
                                    ? AppColors.neutral_03
                                    : AppColors.neutral_07)),
                        Text(widget.data?.cRECEIVESHARECODE.toString() ?? '',
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
                  ],
                )
              : const SizedBox(),
          widget.data?.cBUSINESSCODE == "RIGHT_BUY"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            S
                                .of(context)
                                .remaining_shares_available_for_purchase,
                            style: AppTextStyle.labelMedium_12.copyWith(
                                color: themeMode.isLight
                                    ? AppColors.neutral_03
                                    : AppColors.neutral_07)),
                        Text(
                            "${NumUtils.formatDouble((widget.data?.cSHARERIGHT.toDouble() ?? 0) - (widget.data?.cSHAREBUY.toDouble() ?? 0))}/${NumUtils.formatDouble(widget.data?.cSHARERIGHT ?? 0)}",
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
                  ],
                )
              : const SizedBox(),
          widget.data?.cBUSINESSCODE == "RIGHT_BUY"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).purchase_price,
                            style: AppTextStyle.labelMedium_12.copyWith(
                                color: themeMode.isLight
                                    ? AppColors.neutral_03
                                    : AppColors.neutral_07)),
                        Text(
                            "${NumUtils.formatInteger(widget.data?.cBUYPRICE ?? 0)} đ",
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
                  ],
                )
              : const SizedBox(),
          widget.data?.cBUSINESSCODE == "RIGHT_DIVIDEND"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).amount_received,
                            style: AppTextStyle.labelMedium_12.copyWith(
                                color: themeMode.isLight
                                    ? AppColors.neutral_03
                                    : AppColors.neutral_07)),
                        Text(
                          NumUtils.formatInteger(widget.data?.cCASHVOLUME ?? 0),
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
                  ],
                )
              : const SizedBox(),
          widget.data?.cBUSINESSCODE == "RIGHT_STOCK_DIV"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).number_of_shares_received,
                            style: AppTextStyle.labelMedium_12.copyWith(
                                color: themeMode.isLight
                                    ? AppColors.neutral_03
                                    : AppColors.neutral_07)),
                        Text(
                            NumUtils.formatInteger(
                                widget.data?.cSHAREDIVIDENT ?? 0),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                                color: themeMode.isLight
                                    ? AppColors.text_black_1
                                    : AppColors.neutral_07))
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                )
              : const SizedBox(),
          widget.data?.cBUSINESSCODE != "RIGHT_VOTE"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).received_stock_code,
                            style: AppTextStyle.labelMedium_12.copyWith(
                                color: themeMode.isLight
                                    ? AppColors.neutral_03
                                    : AppColors.neutral_07)),
                        Text(
                            widget.data?.cRECEIVESHARECODE == "null"
                                ? '-'
                                : widget.data?.cRECEIVESHARECODE ?? '-',
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
                  ],
                )
              : const SizedBox(),
          widget.data?.cBUSINESSCODE == "RIGHT_VOTE"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).quantity_of_rights_received,
                            style: AppTextStyle.labelMedium_12.copyWith(
                                color: themeMode.isLight
                                    ? AppColors.neutral_03
                                    : AppColors.neutral_07)),
                        Text(
                            NumUtils.formatInteger(
                                widget.data?.cRIGHTVOLUME ?? 0),
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
                  ],
                )
              : const SizedBox(),
          widget.data?.cBUSINESSCODE == "RIGHT_BUY"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).registration_closing_date,
                            style: AppTextStyle.labelMedium_12.copyWith(
                                color: themeMode.isLight
                                    ? AppColors.neutral_03
                                    : AppColors.neutral_07)),
                        Text(widget.data?.cREGISTERTODATE ?? '',
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
                  ],
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).planned_execution_date,
                  style: AppTextStyle.labelMedium_12.copyWith(
                      color: themeMode.isLight
                          ? AppColors.neutral_03
                          : AppColors.neutral_07)),
              Text(
                  widget.data?.cEXECUTEDATE == "null"
                      ? '-'
                      : widget.data?.cEXECUTEDATE ?? '-',
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
