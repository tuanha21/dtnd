import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockDetailOverview extends StatelessWidget {
  const StockDetailOverview({super.key, required this.stockModel});
  final StockModel stockModel;
  @override
  Widget build(BuildContext context) {
    List<_StockDetailPriceElementData> listPrices = [
      _StockDetailPriceElementData(
        title: S.of(context).floor,
        value: stockModel.stockData.f.toString(),
        valueColor: AppColors.semantic_04,
        bgColor: AppColors.accent_light_04,
      ),
      _StockDetailPriceElementData(
        title: S.of(context).ref,
        value: stockModel.stockData.r.toString(),
        valueColor: AppColors.semantic_02,
        bgColor: AppColors.accent_light_02,
      ),
      _StockDetailPriceElementData(
        title: S.of(context).ceil,
        value: stockModel.stockData.c.toString(),
        valueColor: AppColors.semantic_05,
        bgColor: AppColors.accent_light_05,
      )
    ];
    final themeMode = AppService.instance.themeMode.value;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    stockModel.stockData.lastPrice.toString(),
                    style: AppTextStyle.headlineSmall_24
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 10),
                  stockModel.stockData.prefixIcon(size: 10),
                  const SizedBox(width: 3),
                  Text(
                    "${stockModel.stockData.ot} (${stockModel.stockData.changePc}%)",
                    style: AppTextStyle.bodySmall_8.copyWith(
                        fontWeight: FontWeight.w500,
                        color: stockModel.stockData.color),
                  ),
                ],
              ),
              Row(
                children: [
                  ObxValue<Rx<num?>>(
                    (lot) {
                      return Text(
                        "${NumUtils.formatInteger10(lot.value, "-")} CP",
                        style: AppTextStyle.bodySmall_8
                            .copyWith(color: AppColors.neutral_04),
                      );
                    },
                    stockModel.stockData.lot,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${NumUtils.formatInteger(stockModel.stockData.value, "-")} tỷ",
                    style: AppTextStyle.bodySmall_8
                        .copyWith(color: AppColors.neutral_04),
                  ),
                ],
              )
            ],
          ),
        ),
        ...List<Widget>.generate(
            3,
            (index) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _StockDetailPriceElement(
                      data: listPrices[index], themeMode: themeMode),
                ))
      ],
    );
  }
}

class _StockDetailPriceElement extends StatelessWidget {
  const _StockDetailPriceElement({
    required this.data,
    required this.themeMode,
  });
  final ThemeMode themeMode;
  final _StockDetailPriceElementData data;
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(54, 48),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: themeMode.isLight ? Colors.transparent : AppColors.neutral_01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              data.value ?? "-",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600, color: data.valueColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _StockDetailPriceElementData {
  _StockDetailPriceElementData({
    required this.title,
    this.value,
    required this.valueColor,
    required this.bgColor,
  });
  final String title;
  final String? value;
  final Color valueColor;
  final Color bgColor;
}
