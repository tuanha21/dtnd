import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exercise_right/exercise_right_screen.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../=models=/response/account/i_account.dart';
import '../../../../data/i_exchange_service.dart';
import '../../../../data/i_local_storage_service.dart';
import '../../../../data/implementations/exchange_service.dart';
import '../../../../data/implementations/local_storage_service.dart';
import '../../../../utilities/logger.dart';
import '../../../../utilities/num_utils.dart';
import '../../../../utilities/validator.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_image.dart';
import '../../../theme/app_textstyle.dart';
import '../../../widget/input/interval_input.dart';
import '../../../widget/overlay/dialog_utilities.dart';

class RegistrationRightsSheet extends StatefulWidget {
  const RegistrationRightsSheet({
    super.key,
    required this.data,
    required this.accountModel,
    required this.onSuccessExecute,
  });

  final UnexecutedRightModel? data;
  final IAccountModel accountModel;
  final VoidCallback onSuccessExecute;

  @override
  State<RegistrationRightsSheet> createState() =>
      _RegistrationRightsSheetState();
}

class _RegistrationRightsSheetState extends State<RegistrationRightsSheet>
    with AppValidator {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();

  final GlobalKey<FormState> pinKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final ILocalStorageService localStorageService = LocalStorageService();
  final IExchangeService exchangeService = ExchangeService();

  bool loading = false;
  bool checked = false;

  @override
  void initState() {
    super.initState();
    pinController.text =
        localStorageService.sharedPreferences.getString(pinCodeKey) ?? '';
  }

  void registerRight() async {
    if (!(pinKey.currentState?.validate() ?? false)) {
      return;
    }
    try {
      await exchangeService.registerRight(
          accountModel: widget.accountModel,
          right: widget.data,
          volumn: volumeController.text,
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
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ExerciseRightScreen(
            defaultTab: 1,
          ),
        ));
      }
    } catch (e) {
      logger.e(e);
      await DialogUtilities.showErrorDialog(
          context: context,
          title: S.of(context).register_right_failed,
          content: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(title: S.of(context).register_the_right),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.primary_03,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.data?.cSHARECODE.toString() ?? '',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          S.of(context).remaining_shares_available_for_purchase,
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_03)),
                      Text(
                        "${NumUtils.formatDouble(widget.data?.cSHARERIGHT ?? 0 - (widget.data?.cSHAREBUY ?? 0))}/${NumUtils.formatDouble(widget.data?.cSHARERIGHT ?? 0)}",
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).purchase_price,
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_03)),
                      Text(
                          "${NumUtils.formatInteger(widget.data?.cBUYPRICE ?? 0)} đ"),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).amount_to_be_paid,
                          style: AppTextStyle.labelMedium_12
                              .copyWith(color: AppColors.neutral_03)),
                      Text(
                          "${NumUtils.formatInteger(widget.data?.cCASHBUY ?? 0)} đ"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  // child: IntervalInput(
                  //   controller: volumeController,
                  //   labelText: S.of(context).volumn,
                  //   interval: (value) => 100,
                  //   validator: volumnValidator,
                  //   // onChanged: onChangeVol,
                  // ),
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

                      if (volume <= 0 || volume > widget.data!.shareAvailBuy) {
                        setState(() {
                          errorMsg = S.of(context).invalid_weight;
                        });
                        return errorMsg;
                      }
                      return null;
                    },
                    controller: volumeController,
                    labelText: S.of(context).volumn,
                    interval: (p0) => 1,
                    onChanged: (volume) {
                      if (volume <= 0 || volume > widget.data!.shareAvailBuy) {
                        buyValue.value = 0;
                        return;
                      }
                      buyValue.value = volume;
                    },
                    defaultValue: widget.data!.cSHARERIGHT,
                    // onChanged: onChangedPrice,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Form(
                    key: pinKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: (localStorageService.sharedPreferences
                                .getString(pinCodeKey)
                                ?.isEmpty ??
                            true)
                        ? TextFormField(
                            controller: pinController,
                            // onChanged: (value) => pinFormKey.currentState?.didChange(value),
                            validator: pinValidator,
                            autovalidateMode: AutovalidateMode.disabled,
                            decoration: InputDecoration(
                              labelText: S.of(context).pin_code,
                              // contentPadding: const EdgeInsets.all(0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              suffixIcon: InkWell(
                                onTap: () {
                                  checked = !checked;
                                  if (checked && pinController.text != '') {
                                    EasyLoading.showToast(
                                        S.of(context).saved_pin_code,
                                        maskType: EasyLoadingMaskType.clear);
                                  }
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    AppImages.save_pin_code_icon,
                                    color: (checked && pinController.text != '')
                                        ? AppColors.semantic_01
                                        : AppColors.primary_01,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                registerRight();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.color_primary_1,
                ),
                child: Text(
                  S.of(context).confirm,
                  style:
                      const TextStyle(fontSize: 12, color: AppColors.light_bg),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
