import 'dart:async';

import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../theme/app_image.dart';

class CancelStockOrderSheet extends StatefulWidget {
  const CancelStockOrderSheet({
    super.key,
    required this.data,
  });

  final BaseOrderModel data;

  @override
  State<CancelStockOrderSheet> createState() => _CancelStockOrderSheetState();
}

class _CancelStockOrderSheetState extends State<CancelStockOrderSheet>
    with AppValidator {
  final INetworkService networkService = NetworkService();
  final IUserService userService = UserService();
  final IExchangeService exchangeService = ExchangeService();
  final IDataCenterService dataCenterService = DataCenterService();
  final GlobalKey<FormState> pinKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final ILocalStorageService localStorageService = LocalStorageService();

  bool loading = false;
  bool checked = false;

  String? errorText;

  void onConfirm() async {
    if (loading) {
      return;
    }
    setState(() {
      errorText = null;
      loading = true;
    });
    if (pinKey.currentState?.validate() ?? false) {
      await exchangeService
          .cancelOrder(
        userService,
        widget.data,
        pinController.text,
      )
          .then((value) {
        loading = false;
        if (checked) {
          localStorageService.savePinCode(pinController.text);
        }
        return Navigator.of(context).pop(const OrderSuccessCmd());
      }).onError((error, stackTrace) {
        loading = false;
        logger.e(error);
        if (error is String) {
          setState(() {
            errorText = error;
          });
        }
        return;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pinController.text =
        localStorageService.sharedPreferences.getString(pinCodeKey) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              title: S.of(context).order_cancellation_confirmation,
              implementBackButton: true,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).Are_you_sure_you_want_to_cancel_the_order),
              ],
            ),
            const SizedBox(height: 8),
            Form(
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
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
            const SizedBox(height: 8),
            ExpandedSection(
                expand: errorText != null,
                child: Row(
                  children: [
                    Text(
                      errorText ?? "",
                      style: AppTextStyle.bodyMedium_14
                          .copyWith(color: AppColors.semantic_03),
                    )
                  ],
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SingleColorTextButton(
                    text: S.of(context).cancel,
                    textStyle: textTheme.titleSmall,
                    color: AppColors.primary_03,
                    onTap: () => Navigator.of(context).pop(const BackCmd()),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SingleColorTextButton(
                    text: S.of(context).confirm,
                    color: AppColors.primary_01,
                    onTap: onConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
