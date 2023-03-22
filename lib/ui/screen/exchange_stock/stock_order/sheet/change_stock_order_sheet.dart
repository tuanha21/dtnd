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
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/ui/widget/input/interval_input.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/error_definition.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController volumnController =
      TextEditingController(text: "100");
  final GlobalKey<FormState> pinKey = GlobalKey<FormState>();

  final TextEditingController pinController = TextEditingController();
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
  }

  Future<void> getData() async {
    final stockModels = await DataCenterService()
        .getStockModelsFromStockCodes([widget.data.symbol]);
    if (stockModels?.isNotEmpty ?? false) {
      stockModel = stockModels!.first;
      priceController.text =
          stockModel?.stockData.lastPrice.value?.toString() ?? "";
    } else {
      return;
    }
  }

  void onConfirm() async {
    // final OrderData orderData = OrderData(
    //   stockModel: stockModel!,
    //   side: side,
    //   volumn: num.parse(volumnController.text),
    //   price: priceController.text,
    //   orderType: OrderType.LO,
    // );
    setState(() {
      errorText = null;
    });
    if (pinKey.currentState?.validate() ?? false) {
      await exchangeService
          .changeOrder(
            userService,
            widget.data,
            num.tryParse(volumnController.text) ?? 0,
            priceController.text,
            pinController.text,
          )
          .then((value) => Navigator.of(context).pop(OrderSuccessCmd()))
          .onError((error, stackTrace) {
        logger.e(error);
        if (error is int) {
          setState(() {
            errorText = getErrorMessage(context, error);
          });
        }
        return;
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
            const SheetHeader(
              title: "Xác nhận sửa lệnh",
              implementBackButton: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mã CK",
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
                  widget.data.side.name(context),
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
                          controller: volumnController,
                          labelText: S.of(context).volumn,
                          interval: (value) => 100,
                          validator: volumnValidator,
                          // onChanged: onChangeVol,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
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
