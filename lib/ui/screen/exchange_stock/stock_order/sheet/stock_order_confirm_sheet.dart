import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/async_single_color_text_button.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/ui/widget/icon/stock_circle_icon.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/string_util.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';

class StockOrderConfirmSheet extends StatefulWidget {
  const StockOrderConfirmSheet({
    super.key,
    required this.orderData,
  });
  final OrderData orderData;
  @override
  State<StockOrderConfirmSheet> createState() => _StockOrderConfirmSheetState();
}

class _StockOrderConfirmSheetState extends State<StockOrderConfirmSheet>
    with AppValidator {
  final IExchangeService exchangeService = ExchangeService();
  final GlobalKey<FormState> pinKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String?>> pinFormKey =
      GlobalKey<FormFieldState<String?>>();

  final TextEditingController pinController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              title: S.of(context).order_confirm,
              backData: widget.orderData,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    StockCirleIcon(
                      stockCode: widget.orderData.stockModel.stock.stockCode,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.orderData.stockModel.stock.stockCode,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.orderData.stockModel.stock.postTo!.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: widget.orderData.side.isBuy
                        ? AppColors.accent_light_01
                        : AppColors.accent_light_03,
                  ),
                  child: Text(
                    widget.orderData.side.name(context).toUpperCase(),
                    style: AppTextStyle.titleSmall_14.copyWith(
                      color: widget.orderData.side.isBuy
                          ? AppColors.semantic_01
                          : AppColors.semantic_03,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.neutral_06,
              ),
              child: Column(
                children: [
                  _Row(
                    label: S.of(context).volumn,
                    value: widget.orderData.volumn.toString(),
                  ),
                  const SizedBox(height: 8),
                  _Row(
                    label: widget.orderData.side.isBuy
                        ? S.of(context).buy_price
                        : S.of(context).sell_price,
                    value: widget.orderData.price,
                  ),
                  const SizedBox(height: 8),
                  _Row(
                    label: S.of(context).order_type,
                    value: widget.orderData.orderType.detailName,
                  ),
                  const SizedBox(height: 8),
                  _Row(
                    label: S.of(context).exchange_total,
                    value: widget.orderData.exchangeTotal?.toString(),
                    valueColor: AppColors.primary_01,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  S.of(context).period_of_validity,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Row(
              children: [
                // Expanded(
                //     child: AsyncButton(
                //   onPressed: () async {
                //     if (pinKey.currentState!.validate()) {
                //       await exchangeService.createNewOrder(widget.orderData
                //           .copyWithPin(pinFormKey.currentState!.value!));
                //     }
                //   },
                //   child: Center(
                //     child: Text(
                //       S.of(context).confirm.toUpperCase(),
                //       style: AppTextStyle.titleSmall_14.copyWith(
                //           color: Colors.white, fontWeight: FontWeight.w700),
                //     ),
                //   ),
                // )),
                Expanded(
                  child: AsyncSingleColorTextButton(
                    text: S.of(context).confirm.toUpperCase(),
                    color: AppColors.semantic_01,
                    onTap: () async {
                      if (pinKey.currentState!.validate()) {
                        // await Future.delayed(const Duration(seconds: 2))
                        //     .then((value) {
                        //   Navigator.of(context).pop(const NextCmd());
                        // });
                        final IUserService userService = UserService();

                        /// code dat lenh
                        BaseOrderModel? response;
                        try {
                          response = await exchangeService.createNewOrder(
                              userService,
                              widget.orderData.copyWithPin(pinController.text));
                        } on int catch (rc) {
                          response = null;
                          Navigator.of(context).pop(OrderFailCmd(rc));
                          return;
                        }
                        if (!mounted) return;
                        Navigator.of(context).pop(OrderSuccessCmd(response));
                        // Fluttertoast.showToast(
                        //   msg: response?.rs ?? S.of(context).unknown_error,
                        //   toastLength: Toast.LENGTH_SHORT,
                        //   gravity: ToastGravity.CENTER,
                        //   timeInSecForIosWeb: 1,
                        //   backgroundColor: Colors.red,
                        //   textColor: Colors.white,
                        //   fontSize: 16.0,
                        // );
                      }
                    },
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
    } else if (value!.isNum) {
      valueTxt = NumUtils.formatDoubleString(value);
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
