import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/order_model/i_order_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/input/interval_input.dart';
import 'package:dtnd/ui/widget/overlay/dialog_utilities.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dtnd/=models=/exchange.dart';

class OrderRecordWidget extends StatefulWidget {
  const OrderRecordWidget({super.key, required this.data});
  final BaseOrderModel data;

  @override
  State<OrderRecordWidget> createState() => _OrderRecordWidgetState();
}

class _OrderRecordWidgetState extends State<OrderRecordWidget> {
  final IExchangeService exchangeService = ExchangeService();
  final IUserService userService = UserService();
  Future<void> onOrderChanged(OrderData data) async {
    await exchangeService.changeOrder(userService, widget.data, data);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Slidable(
      key: ValueKey(widget.data.hashCode),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          Flexible(
            child: Material(
              child: InkWell(
                onTap: () async {
                  final stockModels = await DataCenterService()
                      .getStockModelsFromStockCodes([widget.data.symbol]);
                  final StockModel stockModel;
                  if (stockModels?.isNotEmpty ?? false) {
                    stockModel = stockModels!.first;
                  } else {
                    return;
                  }
                  if (!mounted) {
                    return;
                  }
                  final String currentPrice =
                      stockModel.stockDataCore!.lastPrice?.toStringAsFixed(2) ??
                          stockModel.stockDataCore!.r?.toString() ??
                          stockModel.stockData.lastPrice.value
                              ?.toStringAsFixed(2) ??
                          "0";
                  final TextEditingController priceController =
                      TextEditingController(text: currentPrice);
                  final TextEditingController volumnController =
                      TextEditingController(text: "100");
                  final cancel = await DialogUtilities.showMaterialDialog<bool>(
                      context: context,
                      header: Text(
                        "Xác nhận sửa lệnh",
                        style: textTheme.labelLarge,
                      ),
                      content: Column(
                        children: [
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
                          Row(
                            children: [
                              Expanded(
                                child: IntervalInput(
                                  controller: priceController,
                                  labelText: S.of(context).price,
                                  interval:
                                      stockModel.stock.postTo?.getPriceInterval,
                                  defaultValue:
                                      stockModel.stockData.lastPrice.value ??
                                          stockModel.stockData.r.value ??
                                          0,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: IntervalInput(
                                  controller: volumnController,
                                  labelText: S.of(context).volumn,
                                  interval: (value) => 100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      buttons: [
                        Expanded(
                            child: SingleColorTextButton(
                          textStyle: textTheme.titleSmall,
                          color: AppColors.primary_03,
                          text: S.of(context).cancel,
                          onTap: () => Navigator.of(context).pop(false),
                        )),
                        const SizedBox(width: 16),
                        Expanded(
                            child: SingleColorTextButton(
                          color: AppColors.primary_01,
                          text: S.of(context).confirm,
                          onTap: () => Navigator.of(context).pop(true),
                        )),
                      ]);
                  if (cancel ?? false) {
                    onOrderChanged(OrderData(
                        stockModel: stockModel,
                        orderType: OrderType.LO,
                        volumn: num.tryParse(volumnController.text) ?? 0,
                        price: priceController.text,
                        side: widget.data.side));
                  }
                },
                child: Ink(
                  decoration: const BoxDecoration(
                    color: AppColors.neutral_05,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                            dimension: 16,
                            child: Image.asset(AppImages.edit_slidable_icon)),
                        const SizedBox(height: 8),
                        Text(
                          S.of(context).edit,
                          style: AppTextStyle.labelSmall_10.copyWith(
                            color: AppColors.semantic_04,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Material(
              child: InkWell(
                onTap: () async {
                  final cancel = await DialogUtilities.showMaterialDialog<bool>(
                      context: context,
                      header: Text(
                        "Xác nhận huỷ lệnh",
                        style: textTheme.labelLarge,
                      ),
                      content: const Text("Bạn có chắc chắn muốn huỷ lệnh?"),
                      buttons: [
                        Expanded(
                            child: SingleColorTextButton(
                          textStyle: textTheme.titleSmall,
                          color: AppColors.primary_03,
                          text: S.of(context).cancel,
                          onTap: () => Navigator.of(context).pop(false),
                        )),
                        const SizedBox(width: 16),
                        Expanded(
                            child: SingleColorTextButton(
                          color: AppColors.primary_01,
                          text: S.of(context).confirm,
                          onTap: () => Navigator.of(context).pop(true),
                        )),
                      ]);
                  if (cancel ?? false) {}
                },
                child: Ink(
                  decoration: const BoxDecoration(
                    color: AppColors.neutral_05,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                            dimension: 16,
                            child: Image.asset(AppImages.trash_slidable_icon)),
                        const SizedBox(height: 8),
                        Text(
                          S.of(context).delete,
                          style: AppTextStyle.labelSmall_10.copyWith(
                            color: AppColors.semantic_03,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox.square(
                  dimension: 20,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.data.side.kColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget.data.side.nameShort(context),
                      style: AppTextStyle.titleSmall_14
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.data.symbol,
                  style: textTheme.titleSmall,
                ),
                const SizedBox(width: 6),
                Text(
                  NumUtils.formatDouble(widget.data.matchPrice),
                  style: AppTextStyle.bodySmall_12.copyWith(
                      color: AppColors.semantic_01,
                      fontWeight: FontWeight.w600),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.data.orderStatus.statusName(context),
                      style: AppTextStyle.titleSmall_14
                          .copyWith(color: widget.data.orderStatus.color),
                    )
                  ],
                ))
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).time,
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_04),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        TimeUtilities.onlyHourFormat
                            .format(widget.data.orderTime),
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_01),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         S.of(context).margin,
                //         style: AppTextStyle.labelSmall_10
                //             .copyWith(color: AppColors.neutral_04),
                //       ),
                //       const SizedBox(height: 6),
                //       Text(
                //         "0%",
                //         style: AppTextStyle.labelSmall_10
                //             .copyWith(color: AppColors.neutral_01),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).order_price,
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_04),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.data.showPrice ?? "-",
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_01),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).match_price,
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_04),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        NumUtils.formatDouble(widget.data.matchPrice, "-"),
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_01),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        S.of(context).match_vol,
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_04),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        NumUtils.formatDouble(widget.data.matchVolume, "-"),
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_01),
                      ),
                    ],
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
