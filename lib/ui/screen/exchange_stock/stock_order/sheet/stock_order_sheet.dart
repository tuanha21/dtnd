import 'dart:async';

import 'package:dtnd/=models=/exchange.dart';
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
import 'package:dtnd/ui/screen/exchange_stock/order_note/screen/order_note_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/component/order_order_note_panel.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/component/order_order_panel.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/component/order_owned_stock_panel.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/ui/widget/input/interval_input.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

class StockOrderSheet extends StatefulWidget {
  const StockOrderSheet({
    super.key,
    required this.stockModel,
    this.orderData,
  });
  final StockModel? stockModel;
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

  final GlobalKey<FormState> orderKey = GlobalKey<FormState>();

  late final Set<OrderType> listOrderTypes;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumnController =
      TextEditingController(text: "100");
  late final TabController tabController;
  Timer? onPriceStoppedTyping;
  bool typingPrice = false;

  late OrderType selectedOrderType;

  StockModel? stockModel;

  StockInfoCore? stockInfoCore;

  StockCashBalanceModel? stockCashBalanceModel;

  String? errorText;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    stockModel = widget.stockModel;
    super.initState();
    if (stockModel == null) {
      listOrderTypes = {OrderType.LO};
      selectedOrderType = listOrderTypes.first;
    } else {
      listOrderTypes = stockModel!.stock.postTo?.listOrderType ?? {};
      selectedOrderType = widget.orderData?.orderType ?? listOrderTypes.first;
      priceController.text = widget.orderData?.price ?? "0";
      volumnController.text = widget.orderData?.volumn.toString() ?? "100";

      // select(selectedOrderType);
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
    if (stockModel == null) {
      return;
    }
    stockModel!.stockDataCore =
        await stockModel!.getStockInfoCore(networkService, userService);
    select(selectedOrderType);
    logger.v(stockModel!.stockDataCore?.toJson());
    setState(() {});
  }

  Future<void> getStockCashBalance() async {
    if (stockModel == null) {
      return;
    }
    stockCashBalanceModel = await exchangeService.getSCashBalance(
        stockCode: stockModel!.stock.stockCode,
        price: priceController.text,
        side: Side.buy);
    setState(() {});
  }

  void select(OrderType orderType) {
    if (orderType.isLO && stockModel?.stockDataCore != null) {
      print(stockModel!.stockDataCore!.lastPrice);
      final String currentPrice =
          stockModel!.stockDataCore!.lastPrice?.toStringAsFixed(2) ??
              stockModel!.stockDataCore!.r?.toString() ??
              stockModel!.stockData.lastPrice.value?.toStringAsFixed(2) ??
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

  void onChangeVol(num value) {
    setState(() {});
  }

  bool isSelected(OrderType orderType) => orderType == selectedOrderType;

  void toConfirmPanel(Side side) async {
    if (orderKey.currentState?.validate() ?? false) {
      final OrderData orderData = OrderData(
        stockModel: stockModel!,
        side: side,
        orderType: selectedOrderType,
        volumn: num.parse(volumnController.text),
        price: priceController.text,
      );
      Navigator.of(context).pop(NextCmd(orderData));
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
    return Form(
      key: orderKey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SheetHeader(
                title: S.of(context).trading,
                implementBackButton: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    controller: tabController,
                    isScrollable: true,
                    labelStyle: textTheme.titleSmall,
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  Material(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                          ..pop()
                          ..push(MaterialPageRoute(
                            builder: (context) => const OrderNoteScreen(),
                          ));
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: Ink(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.primary_03,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: SizedBox.square(
                            dimension: 16,
                            child: Image.asset(AppImages.filter_icon)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      OrderOrderPanel(
                        stockModel: stockModel,
                        onChangeStock: changeStock,
                        onValidate: (value) {
                          setState(() {
                            errorText = value;
                          });
                        },
                      ),
                      const OrderOrderNotePanel(),
                      OrderOwnedStockPanel(
                        onSell: (stockCodes) async {
                          final model = await dataCenterService
                              .getStockModelsFromStockCodes([stockCodes]);
                          if (model?.isNotEmpty ?? false) {
                            changeStock(model!.first);
                            tabController.animateTo(0);
                          }
                        },
                      ),
                    ]),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              SizedBox(
                height: 28,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (final OrderType orderType in listOrderTypes)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: _OrderTypeButton(
                                orderType: orderType,
                                isSelected: isSelected,
                                select: select,
                              ),
                            )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: AppColors.primary_01),
                      child: Text(
                        "Ký quỹ ${stockCashBalanceModel?.imCk}%",
                        style: AppTextStyle.labelSmall_10.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).order_value),
                  Builder(
                    builder: (context) {
                      num price;
                      num vol = num.tryParse(volumnController.text) ?? 0;
                      switch (selectedOrderType) {
                        case OrderType.LO:
                          price = num.tryParse(priceController.text) ?? 0;
                          break;
                        default:
                          price = stockModel?.stockData.c.value ?? 0;
                      }
                      num value = price * vol * 1000;
                      return Text("${NumUtils.formatInteger(value)} VND");
                    },
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: IntervalInput(
                      controller: priceController,
                      labelText: S.of(context).price,
                      interval: stockModel?.stock.postTo?.getPriceInterval ??
                          (value) => 0.1,
                      defaultValue: stockModel?.stockDataCore?.lastPrice ??
                          stockModel?.stockData.r.value ??
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
                      onChanged: onChangeVol,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ExpandedSection(
                  expand: errorText != null,
                  child: Text(
                    errorText ?? "",
                    style: AppTextStyle.bodyMedium_14
                        .copyWith(color: AppColors.semantic_03),
                  )),
              const SizedBox(height: 8),
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
              ),
            ],
          ),
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
