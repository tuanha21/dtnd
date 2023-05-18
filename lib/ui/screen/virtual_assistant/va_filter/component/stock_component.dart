import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class StockComponent extends StatelessWidget {
  const StockComponent({
    super.key,
    required this.model,
    this.onSelected,
  });

  final StockModel model;
  final ValueChanged<Stock>? onSelected;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 72,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color:
              themeMode.isLight ? AppColors.neutral_06 : AppColors.neutral_01,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        model.stock.stockCode,
                        style: textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        model.stockData.lastPrice.value.toString(),
                        style: textTheme.labelMedium!.copyWith(
                            color: model.stockData.color,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                          color: model.stockData.color,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(56)),
                        ),
                        child: Row(
                          children: [
                            model.stockData
                                .prefixIcon(color: Colors.white, size: 7),
                            const SizedBox(width: 3),
                            Text(
                              "${model.stockData.changePc.value}%",
                              style: AppTextStyle.bodySmall_8.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      )
                    ],
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
            InkWell(
              onTap: () => onSelected?.call(model.stock),
              child: Image.asset(
                AppImages.add_rounded_icon,
                scale: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
