import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/stock_model.dart';
import '../../../stock_detail/stock_detail_screen.dart';

class StockComponent extends StatefulWidget {
  final StockModel model;
  final bool isPercent;

  const StockComponent({Key? key, required this.model, required this.isPercent})
      : super(key: key);

  @override
  State<StockComponent> createState() => _StockComponentState();
}

class _StockComponentState extends State<StockComponent> {
  String get increase => !widget.isPercent
      ? (widget.model.stockData.ot.value?.toString() ?? "")
      : percentString;

  String get percentString {
    if(widget.model.stockData.changePc.value == null){
      return "-";
    }
    if(widget.model.stockData.changePc.value == 0){
      return widget.model.stockData.changePc.value.toString();
    }
    return '${widget.model.stockData.changePc.value?.toString() ?? ""}%';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StockDetailScreen(stockModel: widget.model)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                widget.model.stock.stockCode,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: widget.model.stockData.color),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.model.stockData.lastPrice.value?.toString() ?? "",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: widget.model.stockData.color),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Obx(() {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    increase,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: widget.model.stockData.color),
                  ),
                );
              }),
            ),
            Expanded(
              flex: 3,
              child: Obx(() {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    NumUtils.formatInteger(widget.model.stockData.lot.value),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
