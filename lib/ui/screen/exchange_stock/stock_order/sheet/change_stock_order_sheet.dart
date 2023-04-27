import 'dart:async';

import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/stock_cash_balance_model.dart';
import 'package:dtnd/=models=/response/stock_info_core.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/side.dart';
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
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/ui/widget/input/interval_input.dart';
import 'package:dtnd/utilities/error_definition.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';

class ChangeStockOrderSheet extends StatefulWidget {
  const ChangeStockOrderSheet({
    super.key,
    required this.data,
  });

  final BaseOrderModel data;

  @override
  State<ChangeStockOrderSheet> createState() => _ChangeStockOrderSheetState();
}

class _ChangeStockOrderSheetState extends State<ChangeStockOrderSheet>
    with AppValidator, OrderMessage {
  final INetworkService networkService = NetworkService();
  final IUserService userService = UserService();
  final IExchangeService exchangeService = ExchangeService();
  final IDataCenterService dataCenterService = DataCenterService();
  late final Set<OrderType> listOrderTypes;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  final GlobalKey<FormState> pinKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String?>> pinFormKey =
      GlobalKey<FormFieldState<String?>>();

  final TextEditingController pinController = TextEditingController();
  final ILocalStorageService localStorageService = LocalStorageService();

  bool loading = false;
  bool checked = false;

  Timer? onPriceStoppedTyping;
  bool typingPrice = false;

  String? errorText;

  StockModel? stockModel;

  StockInfoCore? stockInfoCore;

  StockCashBalanceModel? stockCashBalanceModel;

  @override
  void initState() {
    super.initState();
    getData();
    pinController.text =
        localStorageService.sharedPreferences.getString(pinCodeKey) ?? '';
  }

  Future<void> getData() async {
    final stockModels = await DataCenterService()
        .getStocksModelsFromStockCodes([widget.data.symbol]);
    if (stockModels?.isNotEmpty ?? false) {
      stockModel = stockModels!.first;
      // priceController.text =
      //     stockModel?.stockData.lastPrice.value?.toString() ?? "";
      priceController.text = widget.data.showPrice.toString();
      volumeController.text = widget.data.volume.toString();
    } else {
      return;
    }
  }

  void onConfirm() async {
    if (loading) {
      return;
    }
    setState(() {
      errorText = null;
      loading = true;
    });
    print("pinKey.currentState == null ? ${pinKey.currentState == null}");
    if (pinKey.currentState?.validate() ?? false) {
      exchangeService
          .changeOrder(
        userService,
        widget.data,
        num.tryParse(volumeController.text) ?? 0,
        priceController.text,
        pinController.text,
      )
          .then(
        (value) {
          loading = false;
          if (checked) {
            localStorageService.savePinCode(pinController.text);
          }
          return Navigator.of(context).pop(const OrderSuccessCmd());
        },
      ).onError((error, stackTrace) {
        loading = false;

        logger.e(error);
        if (error is int) {
          setState(() {
            errorText = getErrorMessage(context, error);
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
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              title: S.of(context).confirm_change_order,
              implementBackButton: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).stk_code,
                  style: textTheme.bodySmall,
                ),
                Text(
                  widget.data.symbol,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).order_type,
                  style: textTheme.bodySmall,
                ),
                Text(
                  widget.data.side.toName(context),
                  style: textTheme.bodyMedium
                      ?.copyWith(color: widget.data.side.kColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Form(
              key: pinKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: IntervalInput(
                          controller: priceController,
                          labelText: S.of(context).price,
                          interval:
                              stockModel?.stock.postTo?.getPriceInterval ??
                                  (value) => 0.1,
                          defaultValue: stockModel?.stockData.lastPrice.value ??
                              stockModel?.stockData.r.value ??
                              0,
                          // onChanged: onChangedPrice,
                          // onTextChanged: _onPriceChangeHandler,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: IntervalInput(
                          controller: volumeController,
                          labelText: S.of(context).volumn,
                          interval: (value) => 100,
                          validator: volumnValidator,
                          // onChanged: onChangeVol,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (localStorageService.sharedPreferences
                          .getString(pinCodeKey)
                          ?.isEmpty ??
                      true)
                    TextFormField(
                      key: pinFormKey,
                      controller: pinController,
                      onChanged: (value) {
                        print(pinFormKey.currentState == null);
                        pinFormKey.currentState?.didChange(value);
                        print(pinFormKey.currentState?.value);
                      },
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
                  else
                    const SizedBox(),
                ],
              ),
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
