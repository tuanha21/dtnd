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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Loại quyền', style: AppTextStyle.labelMedium_12),
              Text(widget.data?.cRIGHTTYPENAME.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mã CK',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cSHARECODE.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Số CP được hưởng',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cRIGHTVOLUME.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tỷ lệ',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cRIGHTRATE.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mã CP được mua',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cRECEIVESHARECODE.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Số CP còn được mua',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(((NumUtils.formatDouble(widget.data?.cSHARERIGHT ??
                  0 -
                      (widget.data?.cSHAREBUY ?? 0) /
                          (widget.data?.cSHARERIGHT ?? 0)))))
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Giá mua',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text("${NumUtils.formatInteger(widget.data?.cBUYPRICE ?? 0)} đ"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Số tiền được nhận',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cCASHVOLUME.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Số CP được nhận',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cSHARERIGHT.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mã CP được nhận',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cRECEIVESHARECODE.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Số quyền được nhận',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cSHARERIGHT.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ngày chốt đăng ký',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cREGISTERTODATE.toString() ?? '')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ngày thực hiện dự định',
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03)),
              Text(widget.data?.cEXECUTEDATE.toString() ?? '')
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
