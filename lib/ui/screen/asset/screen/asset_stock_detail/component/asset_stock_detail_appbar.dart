import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/appbar/i_appbar.dart';
import 'package:dtnd/ui/widget/svg_icon_button.dart';
import 'package:flutter/material.dart';

class AssetStockDetailAppbar extends IAppbar {
  const AssetStockDetailAppbar({
    super.key,
    required this.stockCode,
    this.stockModel,
    this.onTap,
  });

  final String stockCode;
  final StockModel? stockModel;
  final VoidCallback? onTap;

  // void addCatalog(BuildContext context) async {
  //   await AddCatalogISheet(stock: stockModel.stock.stockCode)
  //       .show(context, AddCatalogSheet(stock: stockModel.stock.stockCode));
  // }

  @override
  Widget titleBuilder(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: stockModel?.stock.stockCode ?? stockCode,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w700)),
                  const TextSpan(text: " "),
                  TextSpan(
                    text: "(${stockModel?.stock.postTo?.name ?? "-"})",
                    style: AppTextStyle.labelLarge_18
                        .copyWith(color: AppColors.neutral_03),
                  ),
                ],
              ),
            ),
            Text(
              stockModel?.stock.nameShort ?? "-",
              style: AppTextStyle.bottomNavLabel
                  .copyWith(color: AppColors.neutral_03),
            ),
          ],
        ),
      );

  @override
  List<Widget> actionsBuilder(BuildContext context) => [
        SvgIconButton(
          AppImages.add_square,
          onPressed: () {
            // addCatalog(context);
          },
          iconSize: 20,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        SvgIconButton(
          AppImages.notification_appbar_icon,
          onPressed: () {},
          iconSize: 20,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(
          width: 16,
        ),
      ];
}
