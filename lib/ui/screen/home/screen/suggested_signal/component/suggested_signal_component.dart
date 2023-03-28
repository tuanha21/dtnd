import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/suggested_signal_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

class SuggestedSignalComponent extends StatefulWidget {
  const SuggestedSignalComponent({super.key, required this.data});
  final SuggestedSignalModel data;
  @override
  State<SuggestedSignalComponent> createState() =>
      _SuggestedSignalComponentState();
}

class _SuggestedSignalComponentState extends State<SuggestedSignalComponent> {
  final IDataCenterService dataCenterService = DataCenterService();
  Stock? stock;
  @override
  void initState() {
    super.initState();
    if (widget.data.cSHARECODE.length == 3) {
      stock = dataCenterService.getStockFromStockCode(widget.data.cSHARECODE);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              StockIcon(
                color: Colors.white,
                stockCode: widget.data.cSHARECODE,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.cSHARECODE,
                      style: textTheme.titleSmall,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            stock?.nameShort ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.labelSmall_10
                                .copyWith(color: AppColors.neutral_03),
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   "${(widget.volPc ?? 0).toStringAsFixed(2)}%",
                    //   style: textTheme.bodySmall!
                    //       .copyWith(color: AppColors.neutral_04),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).signal_type,
                    style: AppTextStyle.bodySmall_8.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.data.cTYPE ?? "",
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).effective,
                    style: AppTextStyle.bodySmall_8.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${NumUtils.formatDouble(widget.data.ratio)}%",
                    style: AppTextStyle.titleSmall_14,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).ratio,
                    style: AppTextStyle.bodySmall_8.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${NumUtils.formatDouble(widget.data.cPC)}%",
                    style: AppTextStyle.titleSmall_14,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
