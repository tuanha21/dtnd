import 'dart:async';

import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/response/stock.dart';
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
import 'package:dtnd/ui/screen/exchange_stock/stock_order/component/order_order_note_panel.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/ui/screen/search/search_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/ui/widget/input/interval_input.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

class StockOrderSheet extends StatefulWidget {
  const StockOrderSheet({
    super.key,
    required this.stockModel,
    this.orderData,
  });
  final StockModel stockModel;
  final OrderData? orderData;
  @override
  State<StockOrderSheet> createState() => _StockOrderSheetState();
}

class _StockOrderSheetState extends State<StockOrderSheet>
    with SingleTickerProviderStateMixin {
  final INetworkService networkService = NetworkService();
  final IUserService userService = UserService();
  final IExchangeService exchangeService = ExchangeService();
  final IDataCenterService dataCenterService = DataCenterService();
  late final Set<OrderType> listOrderTypes;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumnController =
      TextEditingController(text: "100");
  late final TabController tabController;
  Timer? onPriceStoppedTyping;
  bool typingPrice = false;

  late OrderType selectedOrderType;

  late StockModel stockModel;

  StockInfoCore? stockInfoCore;

  StockCashBalanceModel? stockCashBalanceModel;

  bool showSearchBox = false;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    stockModel = widget.stockModel;
    super.initState();
    if (widget.orderData != null) {
      listOrderTypes = stockModel.stock.postTo?.listOrderType ?? {};
      selectedOrderType = widget.orderData!.orderType;
      priceController.text = widget.orderData!.price;
      volumnController.text = widget.orderData!.volumn.toString();
    } else {
      listOrderTypes = stockModel.stock.postTo?.listOrderType ?? {};
      selectedOrderType = listOrderTypes.first;

      select(selectedOrderType);
    }
    getStockInfoCore();
    getStockCashBalance();
    // stockSearchFocusNode.addListener(() {
    //   if (stockSearchFocusNode.hasFocus) {
    //     setState(() {
    //       showSearchBox = true;
    //     });
    //   } else {
    //     setState(() {
    //       showSearchBox = false;
    //     });
    //   }
    // });
  }

  Future<void> getStockInfoCore() async {
    stockInfoCore =
        await stockModel.getStockInfoCore(networkService, userService);
  }

  Future<void> getStockCashBalance() async {
    stockCashBalanceModel = await exchangeService.getSCashBalance(
        stockCode: stockModel.stock.stockCode,
        price: priceController.text,
        side: Side.buy);
    setState(() {});
  }

  void select(OrderType orderType) {
    if (orderType.isLO) {
      final String currentPrice =
          stockModel.stockData.lastPrice.value?.toStringAsFixed(2) ??
              stockModel.stockData.r.value?.toString() ??
              "0";
      priceController.value = TextEditingValue(
        text: currentPrice,
        selection: TextSelection.collapsed(offset: currentPrice.length),
      );
    } else {
      priceController.value = TextEditingValue(
        text: orderType.value,
        selection: TextSelection.collapsed(offset: orderType.value.length),
      );
    }
    setState(() {
      selectedOrderType = orderType;
    });
    getStockCashBalance();
  }

  void onChangedPrice(num value) {
    setState(() {
      selectedOrderType = listOrderTypes.first;
    });
    getStockCashBalance();
  }

  bool isSelected(OrderType orderType) => orderType == selectedOrderType;

  void toConfirmPanel(Side side) async {
    final OrderData orderData = OrderData(
      stockModel: stockModel,
      side: side,
      orderType: selectedOrderType,
      volumn: num.parse(volumnController.text),
      price: priceController.text,
    );
    Navigator.of(context).pop(NextCmd(orderData));
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
    //           stockModel: stockModel,
    //           orderData: orderData,
    //         )
    //       ],
    //     );
    //   },
    // );
  }

  void changeStock(StockModel model) {
    setState(() {
      stockModel = model;
    });
    select(selectedOrderType);
    getStockInfoCore();
    getStockCashBalance();
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
              title: S.of(context).trading,
              implementBackButton: false,
            ),
            const SizedBox(height: 20),
            TabBar(
              controller: tabController,
              isScrollable: false,
              labelStyle: textTheme.titleSmall,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              tabs: [
                Text(
                  S.of(context).stock_order,
                ),
                Text(
                  S.of(context).order_note,
                ),
                Text(
                  S.of(context).owned,
                ),
              ],
            ),
            const OrderOrderNotePanel(),
            const SizedBox(height: 20),
            Builder(builder: (context) {
              return Row(
                children: [
                  StockIcon(
                    color: Colors.white,
                    stockCode: stockModel.stock.stockCode,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              stockModel.stock.stockCode,
                              style: textTheme.titleSmall,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                stockModel.stock.nameShort ?? "",
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
                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ))
                            .then((value) async {
                          if (value is Stock) {
                            dataCenterService.getStockModelsFromStockCodes(
                                [value.stockCode]).then((stockModels) {
                              if (stockModels?.isNotEmpty ?? false) {
                                return changeStock(stockModels!.first);
                              }
                            });
                          }
                        });
                      },
                      child: Ink(
                        child: const Icon(
                          Icons.cancel_outlined,
                          fill: 1,
                          size: 30,
                          color: AppColors.semantic_03,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
            const SizedBox(height: 20),
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      "${S.of(context).purchasing_ability}: ",
                      style: AppTextStyle.bodySmall_12.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.neutral_04),
                    ),
                    Text(
                      "${NumUtils.formatInteger(stockCashBalanceModel?.pp, "0")}đ",
                      style: textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Row(
                  children: [
                    Text(
                      "${S.of(context).maximum}: ",
                      style: AppTextStyle.bodySmall_12.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.neutral_04),
                    ),
                    Text(
                      NumUtils.formatInteger(
                          stockCashBalanceModel?.volumeAvaiable, "0"),
                      style: AppTextStyle.titleSmall_14
                          .copyWith(color: AppColors.semantic_01),
                    ),
                    Text(
                      "|",
                      style: textTheme.titleSmall,
                    ),
                    Text(
                      NumUtils.formatInteger(
                          stockCashBalanceModel?.balance, "0"),
                      style: AppTextStyle.titleSmall_14
                          .copyWith(color: AppColors.semantic_03),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              children: [
                for (final OrderType orderType in listOrderTypes)
                  _OrderTypeButton(
                    orderType: orderType,
                    isSelected: isSelected,
                    select: select,
                  )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: IntervalInput(
                    controller: priceController,
                    labelText: S.of(context).price,
                    interval: stockModel.stock.postTo?.getPriceInterval,
                    defaultValue: stockModel.stockData.lastPrice.value ??
                        stockModel.stockData.r.value ??
                        0,
                    onChanged: onChangedPrice,
                    onTextChanged: _onPriceChangeHandler,
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
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SingleColorTextButton(
                    text: S.of(context).buy,
                    color: AppColors.semantic_01,
                    onTap: () => toConfirmPanel(Side.buy),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SingleColorTextButton(
                    text: S.of(context).sell,
                    color: AppColors.semantic_03,
                    onTap: () => toConfirmPanel(Side.sell),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onPriceChangeHandler(String value) {
    if (onPriceStoppedTyping != null) {
      setState(() {
        typingPrice = true;
      }); // clear timer
      onPriceStoppedTyping!.cancel();
    }
    setState(
      () => onPriceStoppedTyping = Timer(TimeUtilities.typingDelay, () {
        typingPrice = false;
        getStockCashBalance();
      }),
    );
  }
}

class _OrderTypeButton extends StatelessWidget {
  const _OrderTypeButton({
    required this.orderType,
    required this.isSelected,
    required this.select,
  });
  final OrderType orderType;
  final Function isSelected;
  final ValueChanged<OrderType> select;
  @override
  Widget build(BuildContext context) {
    final bool selected = isSelected.call(orderType);
    final textTheme = Theme.of(context).textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: selected ? Colors.white : AppColors.neutral_04);
    return Material(
      child: InkWell(
        onTap: () => select.call(orderType),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: selected ? AppColors.primary_01 : AppColors.neutral_06,
          ),
          child: Text(
            orderType.value,
            style: textTheme,
          ),
        ),
      ),
    );
  }
}
