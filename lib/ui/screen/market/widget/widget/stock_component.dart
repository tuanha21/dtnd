import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../=models=/response/stock_model.dart';

class StockComponent extends StatefulWidget {
  final StockModel model;

  const StockComponent({Key? key, required this.model}) : super(key: key);

  @override
  State<StockComponent> createState() => _StockComponentState();
}

class _StockComponentState extends State<StockComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.model.stockData.ot.value?.toString() ?? "",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: widget.model.stockData.color),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                NumUtils.formatInteger(widget.model.stockData.lot.value),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
