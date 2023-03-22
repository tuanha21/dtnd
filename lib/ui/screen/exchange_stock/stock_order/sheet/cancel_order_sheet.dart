import 'dart:async';

import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
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
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';

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

  String? errorText;

  void onConfirm() async {
    setState(() {
      errorText = null;
    });
    if (pinKey.currentState?.validate() ?? false) {
      await exchangeService
          .cancelOrder(
            userService,
            widget.data,
            pinController.text,
          )
          .then((value) => Navigator.of(context).pop(const OrderSuccessCmd()))
          .onError((error, stackTrace) {
        logger.e(error);
        if (error is String) {
          setState(() {
            errorText = error;
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
              title: "Xác nhận huỷ lệnh",
              implementBackButton: true,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Bạn có chắc chắn muốn huỷ lệnh?"),
              ],
            ),
            const SizedBox(height: 8),
            Form(
              key: pinKey,
              autovalidateMode: AutovalidateMode.disabled,
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
