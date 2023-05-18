import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingStockComponent extends StatelessWidget {
  const FollowingStockComponent({
    super.key,
    required this.index,
    required this.model,
  });
  final int index;
  final StockModel model;
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: index == 0 ? 0 : 16),
      child: SizedBox(
        height: 52,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color:
                themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_01,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.stock.stockCode,
                      style: textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      model.stock.nameShort ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelMedium!
                          .copyWith(color: AppColors.neutral_03),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Obx(() {
                  return Text(
                    NumUtils.formatInteger10(model.stockData.lot.value),
                    style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: model.stockData.color),
                  );
                }),
              )),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        model.stockData.lastPrice.value.toString(),
                        style: textTheme.bodySmall!
                            .copyWith(color: model.stockData.color),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                          color: model.stockData.color,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                        ),
                        child: Text(
                          "(${model.stockData.prefix}${model.stockData.changePc.value}%)",
                          style: AppTextStyle.bodySmall_8.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
                }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
