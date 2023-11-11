import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetStockDetailOverview extends StatelessWidget {
  const AssetStockDetailOverview({super.key, this.stockModel});
  final StockModel? stockModel;
  @override
  Widget build(BuildContext context) {
    List<_StockDetailPriceElementData> listPrices = [
      _StockDetailPriceElementData(
        title: S.of(context).floor,
        value: stockModel?.stockData.f.toString() ?? "-",
        valueColor: AppColors.semantic_04,
        bgColor: AppColors.accent_light_04,
      ),
      _StockDetailPriceElementData(
        title: S.of(context).ref,
        value: stockModel?.stockData.r.toString() ?? "-",
        valueColor: AppColors.semantic_02,
        bgColor: AppColors.accent_light_02,
      ),
      _StockDetailPriceElementData(
        title: S.of(context).ceil,
        value: stockModel?.stockData.c.toString() ?? "-",
        valueColor: AppColors.semantic_05,
        bgColor: AppColors.accent_light_05,
      )
    ];
    final themeMode = AppService.instance.themeMode.value;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (stockModel?.stockData.lastPrice.value ?? 0) == 0
                    ? (stockModel?.stockData.r.value.toString() ?? "-")
                    : (stockModel?.stockData.lastPrice.toString() ?? "-"),
                style: AppTextStyle.headlineLarge_32
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (stockModel?.stockData != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: stockModel!.stockData.prefixIcon(size: 10),
                        ),
                      Text(
                        "${stockModel?.stockData.ot ?? "-"} (${stockModel?.stockData.changePc ?? "-"}%)",
                        style: AppTextStyle.labelSmall_10.copyWith(
                            fontWeight: FontWeight.w500,
                            color: stockModel?.stockData.color ??
                                AppColors.semantic_02),
                      ),
                    ],
                  ),
                  ObxValue<Rx<num?>>(
                    (lot) {
                      return Text(
                        "${NumUtils.formatInteger10(lot.value, "-")} CP",
                        textAlign: TextAlign.left,
                        style: AppTextStyle.labelSmall_10
                            .copyWith(color: AppColors.neutral_04),
                      );
                    },
                    stockModel?.stockData.lot ?? 0.obs,
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
