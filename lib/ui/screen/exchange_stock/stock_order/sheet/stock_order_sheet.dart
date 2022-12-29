import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/ui/widget/input/interval_input.dart';
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

class _StockOrderSheetState extends State<StockOrderSheet> {
  late final Set<OrderType> listOrderTypes;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumnController =
      TextEditingController(text: "100");

  late OrderType selectedOrderType;

  @override
  void initState() {
    super.initState();
    if (widget.orderData != null) {
      setState(() {
        listOrderTypes = widget.stockModel.stock.postTo?.listOrderType ?? {};
        selectedOrderType = widget.orderData!.orderType;
        priceController.text = widget.orderData!.price;
        volumnController.text = widget.orderData!.volumn.toString();
      });
    } else {
      setState(() {
        listOrderTypes = widget.stockModel.stock.postTo?.listOrderType ?? {};
        selectedOrderType = listOrderTypes.first;
      });
      select(selectedOrderType);
    }
  }

  void select(OrderType orderType) {
    if (orderType.isLO) {
      final String currentPrice =
          widget.stockModel.stockData.lastPrice.value?.toStringAsPrecision(4) ??
              widget.stockModel.stockData.r.value?.toString() ??
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
  }

  void onChangedPrice(num value) {
    setState(() {
      selectedOrderType = listOrderTypes.first;
    });
  }

  bool isSelected(OrderType orderType) => orderType == selectedOrderType;

  void toConfirmPanel(Side side) async {
    final OrderData orderData = OrderData(
      stockModel: widget.stockModel,
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
    //           stockModel: widget.stockModel,
    //           orderData: orderData,
    //         )
    //       ],
    //     );
    //   },
    // );
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
              title: S.of(context).trading,
              implementBackButton: false,
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
                    interval: widget.stockModel.stock.postTo?.getPriceInterval,
                    defaultValue: widget.stockModel.stockData.lastPrice.value ??
                        widget.stockModel.stockData.r.value ??
                        0,
                    onChanged: onChangedPrice,
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
