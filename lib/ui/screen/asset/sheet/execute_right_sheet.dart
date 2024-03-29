import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/=models=/response/market/stock.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/ui/widget/input/interval_input.dart';
import 'package:dtnd/ui/widget/overlay/dialog_utilities.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/service/app_services.dart';

class ExecuteRightSheet extends StatefulWidget {
  const ExecuteRightSheet({
    super.key,
    required this.unexecutedRightModel,
    required this.stock,
    required this.accountModel,
    required this.onSuccessExecute,
  });

  final UnexecutedRightModel unexecutedRightModel;
  final Stock stock;
  final IAccountModel accountModel;
  final VoidCallback onSuccessExecute;
  @override
  State<ExecuteRightSheet> createState() => _ExecuteRightSheetState();
}

class _ExecuteRightSheetState extends State<ExecuteRightSheet>
    with AppValidator {
  final IExchangeService exchangeService = ExchangeService();
  final TextEditingController pinController = TextEditingController();
  late final TextEditingController volumnController;
  final GlobalKey<FormState> pinKey = GlobalKey<FormState>();
  final Rx<num?> buyValue = Rxn();
  String? errorMsg;

  @override
  void initState() {
    volumnController = TextEditingController(
        text: (widget.unexecutedRightModel.shareAvailBuy.toInt()).toString());
    buyValue.value = widget.unexecutedRightModel.shareAvailBuy;
    super.initState();
  }

  void registerRight() async {
    if (!(pinKey.currentState?.validate() ?? false)) {
      return;
    }
    try {
      await exchangeService.registerRight(
          accountModel: widget.accountModel,
          right: widget.unexecutedRightModel,
          volumn: volumnController.text,
          pin: pinController.text);
      widget.onSuccessExecute.call();
      if (mounted) {
        await DialogUtilities.showErrorDialog(
            context: context,
            title: S.of(context).register_right_successfully,
            content: S.of(context).register_right_successfully);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      logger.e(e);
      await DialogUtilities.showErrorDialog(
          context: context,
          title: S.of(context).register_right_failed,
          content: e.toString());
    }

    // await showModalBottomSheet(
    //   context: context,
    //   shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    //   builder: (BuildContext context) {
    //     return Wrap(
    //       children: [
    //         // TechnicalTradings(
    //         //   onChoosen: (value) => Navigator.of(context).pop(value),
    //         // ),
    //         StockOrderConfirmSheet(
    //           stockModel: widget.stockModel,
    //           unexecutedRightModel: unexecutedRightModel,
    //         )
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              title: S.of(context).register_to_buy,
              implementBackButton: false,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                StockIcon(
                  color: Colors.white,
                  stockCode: widget.unexecutedRightModel.cRECEIVESHARECODE,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.unexecutedRightModel.cRECEIVESHARECODE ??
                                "-",
                            style: textTheme.titleSmall?.copyWith(
                                color: themeMode.isLight
                                    ? null
                                    : AppColors.neutral_07),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.stock.nameShort ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.labelSmall_10
                                  .copyWith(color: AppColors.neutral_03),
                            ),
                          ),
                          // Expanded(
                          //   child: Container(
                          //     height: 4,
                          //     decoration: const BoxDecoration(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(4)),
                          //       color: AppColors.neutral_06,
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Flexible(
                          //           flex: (widget.volPc ?? 0) ~/ 1,
                          //           child: Container(
                          //             height: 4,
                          //             decoration: const BoxDecoration(
                          //               borderRadius: BorderRadius.all(
                          //                   Radius.circular(4)),
                          //               color: AppColors.graph_7,
                          //             ),
                          //           ),
                          //         ),
                          //         Flexible(
                          //           flex: 100 - ((widget.volPc ?? 0) ~/ 1),
                          //           child: Container(),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: themeMode.isLight
                    ? AppColors.neutral_06
                    : AppColors.bg_share_inside_nav,
              ),
              child: Column(
                children: [
                  _Row(
                    label: S.of(context).maximum_load,
                    value: NumUtils.formatInteger(
                        widget.unexecutedRightModel.shareAvailBuy),
                  ),
                  const SizedBox(height: 8),
                  _Row(
                    label: S.of(context).buying_price,
                    value: NumUtils.formatInteger(
                        widget.unexecutedRightModel.cBUYPRICE),
                  ),
                  const SizedBox(height: 8),
                  _Row(
                    label: S.of(context).deduction_account,
                    value: widget.unexecutedRightModel.cACCOUNTCODE,
                  ),
                  const SizedBox(height: 8),
                  Obx(() => _Row(
                        label: S.of(context).total_transaction,
                        value: widget.unexecutedRightModel.cBUYPRICE == null ||
                                buyValue.value == null
                            ? "-"
                            : NumUtils.formatDouble(buyValue.value! *
                                widget.unexecutedRightModel.cBUYPRICE!),
                        valueColor: AppColors.primary_01,
                      )),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: pinKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Row(
                children: [
                  Expanded(
                    child: IntervalInput(
                      validator: (vol) {
                        if (vol == null) {
                          setState(() {
                            errorMsg = S.of(context).Weight_must_be_filled_in;
                          });
                          return errorMsg;
                        }
                        late final num volume;
                        try {
                          volume = num.parse(vol);
                        } catch (e) {
                          volume = -1;
                        }

                        if (volume <= 0 ||
                            volume >
                                widget.unexecutedRightModel.shareAvailBuy) {
                          setState(() {
                            errorMsg = S.of(context).invalid_weight;
                          });
                          return errorMsg;
                        }
                        return null;
                      },
                      controller: volumnController,
                      labelText: S.of(context).volumn,
                      interval: (p0) {
                        return 1;
                      },
                      onTextChanged: (value) {
                        try {
                          buyValue.value = num.parse(value);
                        } catch (e) {
                          buyValue.value = 0;
                        }
                      },
                      onChanged: (volume) {
                        if (volume <= 0 ||
                            volume >
                                widget.unexecutedRightModel.shareAvailBuy) {
                          buyValue.value = 0;
                          return;
                        }
                        buyValue.value = volume;
                      },
                      defaultValue: widget.unexecutedRightModel.cSHARERIGHT,
                      // onChanged: onChangedPrice,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: pinController,
                      // onChanged: (value) => pinFormKey.currentState?.didChange(value),
                      validator: pinValidator,
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecoration(
                        labelText: S.of(context).pin_code,
                        // contentPadding: const EdgeInsets.all(0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // ExpandedSection(
            //   expand: errorMsg != null,
            //   child: Row(
            //     children: [
            //       Expanded(
            //           child: Text(
            //         errorMsg ?? "",
            //         style:
            //             AppTextStyle.bodySmall_12.copyWith(color: Colors.red),
            //       ))
            //     ],
            //   ),
            // ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SingleColorTextButton(
                    text: S.of(context).confirm,
                    color: AppColors.semantic_01,
                    onTap: registerRight,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    this.value,
    this.valueColor,
  });

  final String label;
  final String? value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final textheme = Theme.of(context).textTheme;
    final labelTheme = textheme.titleSmall!;
    final valueTheme = textheme.bodyMedium!
        .copyWith(fontWeight: FontWeight.w600, color: valueColor);
    String valueTxt;
    if (value == null) {
      valueTxt = "-";
    } else {
      valueTxt = value!;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelTheme,
        ),
        Text(
          valueTxt,
          style: valueTheme,
        ),
      ],
    );
  }
}
