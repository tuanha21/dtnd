import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import '../../../../=models=/response/account/unexecuted_right_model.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_textstyle.dart';

class PurchaseRightsHistoryWidget extends StatelessWidget {
  const PurchaseRightsHistoryWidget({Key? key, required this.data})
      : super(key: key);

  final UnexecutedRightModel? data;

  @override
  Widget build(BuildContext context) {
    String titlePermission = '';
    String valuePermission = '';
    String titleMoneyReceive = '';
    String moneyReceive = '';
    String titleRightRate = '';
    String rightRate = '';

    switch (data?.cBUSINESSCODE) {
      case "RIGHT_BUY":
        titlePermission = S.of(context).stock_with_rights;
        valuePermission = NumUtils.formatDouble(data?.cSHAREBUY);
        titleMoneyReceive = S.of(context).amount_paid;
        moneyReceive = "${NumUtils.formatDouble(data?.cCASHBUY)}đ";
        titleRightRate = S.of(context).purchase_price;
        rightRate = "${NumUtils.formatDouble(data?.cBUYPRICE)}đ";
        break;
      case "RIGHT_DIVIDEND":
        titlePermission = S.of(context).registered_share_volume;
        valuePermission = NumUtils.formatDouble(data?.cSHAREVOLUME);
        titleMoneyReceive = S.of(context).amount_received;
        moneyReceive =
        "${NumUtils.formatDouble((double.tryParse(data?.cCASHVOLUME.toString() ?? '') ?? 0) + (double.tryParse(data?.cTAXVOLUME.toString() ?? '') ?? 0))}đ";
        titleRightRate = S.of(context).ratio;
        rightRate = "${data?.cRIGHTRATE}";
        break;
      case "RIGHT_STOCK_DIV":
      case "RIGHT_STOCK_BONUS":
      case "RIGHT_VOTE":
        titlePermission = S.of(context).registered_share_volume;
        valuePermission = NumUtils.formatDouble(data?.cSHAREVOLUME);
        titleMoneyReceive = S.of(context).number_of_shares_received;
        moneyReceive = NumUtils.formatDouble(data?.cSHAREDIVIDENT);
        titleRightRate = S.of(context).ratio;
        rightRate = data?.cRIGHTRATE ?? '';
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.neutral_06,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data?.cEXECUTEDATE.toString() ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                  color: AppColors.neutral_03,
                ),
              ),
              Text(
                data?.cSTATUSNAME.toString() ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                  color: AppColors.text_blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data?.cSHARECODE.toString() ?? '',
                style: AppTextStyle.labelMedium_12.copyWith(
                  color: AppColors.text_black_1,
                ),
              ),
              Text(
                data?.cRIGHTTYPE.toString() ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                  color: AppColors.text_black_1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titlePermission,
                      maxLines: 1,
                      style: AppTextStyle.labelMedium_12.copyWith(
                        color: AppColors.neutral_03,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      valuePermission,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                        color: AppColors.text_black_1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      titleRightRate,
                      style: AppTextStyle.labelMedium_12.copyWith(
                        color: AppColors.neutral_03,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      rightRate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                        color: AppColors.text_black_1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      titleMoneyReceive,
                      style: AppTextStyle.labelMedium_12.copyWith(
                        color: AppColors.neutral_03,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      moneyReceive,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                        color: AppColors.text_black_1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
