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
    return IntrinsicHeight(
      child: Row(
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
                        (stockModel.stockData.lastPrice.value == 0
                                ? stockModel.stockData.r.value
                                : stockModel.stockData.lastPrice.value)
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            stockModel.stockData.prefixIconData(size: 10),
                            Text(
                              "${stockModel.stockData.ot} (${stockModel.stockData.changePc}%)",
                              style: AppTextStyle.labelSmall_10.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: stockModel.stockData.color,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        ObxValue<Rx<num?>>(
                          (lot) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                "${NumUtils.formatInteger10(lot.value, "-")} CP",
                                style: AppTextStyle.labelSmall_10
                                    .copyWith(color: themeMode.isLight ? AppColors.neutral_04 : AppColors.neutral_07),
                              ),
                            );
                          },
                          stockModel.stockData.lot,
                        )
                      ],
                    ),
                  ],
                ),
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
      ),
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
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: themeMode.isLight ? Colors.transparent : AppColors.neutral_01,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppColors.neutral_03),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            data.value ?? "-",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontWeight: FontWeight.w600, color: data.valueColor),
          ),
        ],
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
