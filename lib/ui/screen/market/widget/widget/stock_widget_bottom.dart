import 'package:flutter/material.dart';

import '../../../../../=models=/response/stock.dart';
import '../../../../../config/service/app_services.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_textstyle.dart';
import '../../../../widget/icon/stock_icon.dart';
import 'add_icon.dart';

class StockWidgetChart extends StatefulWidget {
  final Stock stockModel;
  final bool initSelect;
  final ValueChanged<bool>? onChanged;

  const StockWidgetChart(
      {Key? key,
        required this.stockModel,
        this.onChanged,
        this.initSelect = false})
      : super(key: key);

  @override
  State<StockWidgetChart> createState() => _StockWidgetChartState();
}

class _StockWidgetChartState extends State<StockWidgetChart> {
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22.5),
      decoration: BoxDecoration(color: themeMode.isLight ? AppColors.light_bg : AppColors.neutral_01),
      child: Row(
        children: [
          StockIcon(
            stockCode: widget.stockModel.stockCode,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.stockModel.stockCode,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.stockModel.nameShort ?? "",
                  style: AppTextStyle.labelMedium_12
                      .copyWith(color: AppColors.neutral_03),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          AddStockIcon(initAdd: widget.initSelect, onChanged: widget.onChanged)
        ],
      ),
    );
  }
}