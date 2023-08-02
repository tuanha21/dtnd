import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/stock_model.dart';
import '../../../../../config/service/app_services.dart';
import '../../../stock_detail/stock_detail_screen.dart';

class StockComponent extends StatefulWidget {
  final StockModel model;
  final bool isPercent;
  final int index;
  const StockComponent(
      {Key? key,
      required this.model,
      required this.isPercent,
      required this.index})
      : super(key: key);

  @override
  State<StockComponent> createState() => _StockComponentState();
}

class _StockComponentState extends State<StockComponent> {
  String get increase => !widget.isPercent
      ? (widget.model.stockData.ot.value?.toString() ?? "")
      : percentString;

  String get percentString {
    if (widget.model.stockData.changePc.value == null) {
      return "-";
    }
    if (widget.model.stockData.changePc.value == 0) {
      return widget.model.stockData.changePc.value.toString();
    }
    return '${widget.model.stockData.changePc.value?.toString() ?? ""}%';
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StockDetailScreen(stockModel: widget.model)));
      },
      child: Container(
        color: widget.index.isEven ? (themeMode.isLight ? Colors.white : AppColors.neutral_01) : null,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                widget.model.stock.stockCode,
                style: AppTextStyle.titleSmall_14
                    .copyWith(color: widget.model.stockData.color),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Obx(() {
                  return Text(
                    (widget.model.stockData.lastPrice.value == 0
                                ? widget.model.stockData.r.value
                                : widget.model.stockData.lastPrice.value)
                            ?.toString() ??
                        "",
                    style: AppTextStyle.titleSmall_14.copyWith(
                        fontWeight: FontWeight.w500,
                        color: widget.model.stockData.color),
                  );
                }),
              ),
            ),
            Expanded(
              flex: 3,
              child: Obx(() {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    increase,
                    style: AppTextStyle.titleSmall_14.copyWith(
                        fontWeight: FontWeight.w500,
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
                    NumUtils.formatInteger10(widget.model.stockData.lot.value),
                    style: AppTextStyle.titleSmall_14.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF566276)),
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
